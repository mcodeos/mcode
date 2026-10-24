#!/bin/bash
# bump.sh — the auto-version law.
#
# The version series starts at 0.90 and advances one hundredth per content
# change (0.90 -> 0.91 -> 0.92 ...): the version answers "which content is
# this?" without a human counting. The bump rides the commit -- the
# pre-commit hook runs this in staged mode, so the raised version is what
# lands. A version the human edited in the same commit is honored and never
# touched: the human owns the whole number.
#
# Usage:
#   bump.sh              # worktree mode: bump after any content change
#   bump.sh --staged     # staged mode: for the pre-commit hook; re-stages
#                        # the version file so the bump rides the commit
set -euo pipefail
cd "$(dirname "$0")"

MODE="${1:-}"
if [ "$MODE" = "--staged" ]; then
    NAMES="$(git diff --cached --name-only)"
else
    NAMES="$( (git diff --name-only HEAD; git ls-files --others --exclude-standard) )"
fi

# The version faces of this repository (root level only).
VERSION_FILES="pack.toml project.toml Cargo.toml"

export BUMP_MODE="$MODE" BUMP_NAMES="$NAMES" BUMP_FILES="$VERSION_FILES"
python3 - <<'EOF'
import os, re, subprocess, sys

mode = os.environ.get("BUMP_MODE", "")
staged = mode == "--staged"
files = os.environ["BUMP_FILES"].split()
names = [n for n in os.environ["BUMP_NAMES"].split("\n") if n]

if not [n for n in names if n not in files]:
    sys.exit(0)                      # no content change: the version stands

def head_version(path):
    try:
        old = subprocess.run(["git", "show", f"HEAD:{path}"],
                             capture_output=True, text=True, check=True).stdout
    except subprocess.CalledProcessError:
        return None
    m = re.search(r'^version = "([^"]+)"$', old, re.M)
    return m.group(1) if m else None

for path in files:
    if not os.path.isfile(path):
        continue
    s = open(path, encoding="utf-8").read()
    m = re.search(r'^version = "(\d+)\.(\d+)(?:\.(\d+))?"$', s, re.M)
    if not m:
        print(f"SKIP {path}: no version line", file=sys.stderr)
        continue
    cur = m.group(1) + "." + m.group(2) + ("." + m.group(3) if m.group(3) else "")
    hv = head_version(path)
    if hv is not None and cur != hv:
        print(f"honored manual version {path}: {hv} -> {cur}")
        if staged:
            subprocess.run(["git", "add", path], check=True)
        continue
    if m.group(3) is None:
        new = f"{m.group(1)}.{int(m.group(2)) + 1}"
    else:
        new = f"{m.group(1)}.{m.group(2)}.{int(m.group(3)) + 1}"
    s = s[:m.start()] + f'version = "{new}"' + s[m.end():]
    open(path, "w", encoding="utf-8").write(s)
    print(f"bumped {path}: {cur} -> {new}")
    if staged:
        subprocess.run(["git", "add", path], check=True)
EOF
