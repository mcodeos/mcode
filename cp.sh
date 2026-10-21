#!/bin/bash
# Install mcode through the mcc content-addressed store (the copy face is
# retired; the store walk applies the working-tree exclusions itself).
# mcode installs into the global data root, so this runs from anywhere.
#
# The library version is the one truth in project.toml (`[project] version`);
# this script passes it to `mcc lib install --version`, because the store
# keys the installed view by that version and refuses a re-install of the
# same one. Bumping the version in project.toml is therefore the release
# step for the library face.
#
# After install we also seed project.toml into the installed root. The store
# install face refuses project.toml by design, but subdir files inside
# `comp/*.mc` carry `use ../ifs/<iface>` — without project.toml to anchor
# the lib root the use resolver falls back to file-relative and trips on
# `<root>/comp/ifs/<iface>` (mcc WARN: McCode::new failed), and every
# TERM/PCAP/DIO/XTAL interface binding degrades to "treating '[1, 2]' as
# plain pin alias" (E3110 sweep). The source tree already carries project.toml
# (b5582); this seed closes the symmetric gap on the installed copy that
# the LSP / mcc check consume under the store view. b5585.
SRC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LIB_VERSION="$( sed -n 's/^[[:space:]]*version[[:space:]]*=[[:space:]]*"\([^"]*\)".*/\1/p' \
    "$SRC/project.toml" 2>/dev/null | head -1 )"
if [ -z "$LIB_VERSION" ]; then
    printf 'cp.sh: no [project] version in %s/project.toml\n' "$SRC" >&2
    exit 1
fi
# `lib install` refuses a re-install of the same version; we treat that as a
# no-op (the lib is in place; cp.sh's only side effect is the project.toml
# seed below, which is idempotent).
INSTALL_OUT="$(mcc lib install mcode --from "$SRC" --version "$LIB_VERSION" 2>&1)" || {
    case "$INSTALL_OUT" in
        *already*installed*) : ;;
        *) printf '%s\n' "$INSTALL_OUT" >&2; exit 1 ;;
    esac
}
if [ -f "$SRC/project.toml" ]; then
    INSTALLED="$(mcc lib list 2>/dev/null | awk -v v="$LIB_VERSION" '
        $1 == "mcode@" v { print $3; exit }
    ')"
    if [ -n "$INSTALLED" ] && [ -d "$INSTALLED" ]; then
        cp "$SRC/project.toml" "$INSTALLED/project.toml"
    fi
fi
# Retire the other versions of this library. The store never silently picks
# between same-name multi-version installs: with a second version still
# active the load is refused outright, so the whole library goes silent
# (every interface binding degrades to a plain pin alias - the E3110
# sweep). Publishing a new version therefore ends the previous one.
#
# The store keys a copy by its alias (`mcode@0.4`) while the project file
# spells the version in full (`0.4.0`), so the two are compared in one
# shape: without that, the loop retires the copy it has just installed.
normalize_version() {
    printf '%s\n' "$1" | awk -F. '{ printf "%s.%s.%s", $1, ($2 == "" ? 0 : $2), ($3 == "" ? 0 : $3) }'
}
CURRENT="$(normalize_version "$LIB_VERSION")"
mcc lib list 2>/dev/null | awk '$1 ~ /^mcode@/ { sub(/^mcode@/, "", $1); print $1 }' | while read -r ver; do
    [ "$(normalize_version "$ver")" = "$CURRENT" ] && continue
    mcc lib uninstall "mcode@$ver" --global --force >/dev/null 2>&1 || true
done
