#!/bin/bash
# Install mcode through the mcc content-addressed store (the copy face is
# retired; the store walk applies the working-tree exclusions itself).
# mcode installs into the global data root, so this runs from anywhere.
#
# After install we also seed project.toml into the installed root. The store
# install face refuses project.toml by design, but subdir files inside
# `comp/*.mc` carry `use ../ifs/<iface>` — without project.toml to anchor
# the lib root the use resolver falls back to file-relative and trips on
# `<root>/comp/ifs/<iface>` (mcc WARN: McCode::new failed), and every
# TERM/PCAP/DIO/XTAL interface binding degrades to "treating '[1, 2]' as
# plain pin alias" (E3110 sweep). The source tree already carries project.toml
# (b5582); this seed closes the symmetric gap on the installed copy that
# the LSP / mcc check consume under ~/.mcode/mcode@<ver>/. b5585.
SRC="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# `lib install` refuses a re-install of the same version; we treat that as a
# no-op (the lib is in place; cp.sh's only side effect is the project.toml
# seed below, which is idempotent).
INSTALL_OUT="$(mcc lib install mcode --from "$SRC" 2>&1)" || {
    case "$INSTALL_OUT" in
        *already*installed*) : ;;
        *) printf '%s\n' "$INSTALL_OUT" >&2; exit 1 ;;
    esac
}
if [ -f "$SRC/project.toml" ]; then
    INSTALLED="$(mcc lib list 2>/dev/null | awk '
        /^  mcode@0\.0[[:space:]]+global[[:space:]]+\// { print $3; exit }
    ')"
    if [ -n "$INSTALLED" ] && [ -d "$INSTALLED" ]; then
        cp "$SRC/project.toml" "$INSTALLED/project.toml"
    fi
fi
