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
# One repository carries two version faces (the pack file and the project
# file). The pack file is the authority: it is bumped, and the project file
# follows it, so the two faces never drift.
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

export BUMP_MODE="$MODE" BUMP_NAMES="$NAMES"
python3 - <<'EOF'
import os, re, subprocess, sys

mode = os.environ.get("BUMP_MODE", "")
staged = mode == "--staged"
names = [n for n in os.environ["BUMP_NAMES"].split("\n") if n]

FACES = ["pack.toml", "project.toml", "Cargo.toml"]
faces = [f for f in FACES if os.path.isfile(f)]
if not faces:
    sys.exit(0)
authority = faces[0]           # pack.toml > project.toml > Cargo.toml

if not [n for n in names if n not in FACES]:
    sys.exit(0)                # no content change: the version stands

def read_version(path):
    s = open(path, encoding="utf-8").read()
    m = re.search(r'^version = "(\d+)\.(\d+)(?:\.(\d+))?"$', s, re.M)
    if not m:
        return None
    cur = m.group(1) + "." + m.group(2) + ("." + m.group(3) if m.group(3) else "")
    return s, m, cur

def head_version(path):
    try:
        old = subprocess.run(["git", "show", f"HEAD:{path}"],
                             capture_output=True, text=True, check=True).stdout
    except subprocess.CalledProcessError:
        return None
    m = re.search(r'^version = "([^"]+)"$', old, re.M)
    return m.group(1) if m else None

def write_version(path, m, new):
    s = open(path, encoding="utf-8").read()
    s = s[:m.start()] + f'version = "{new}"' + s[m.end():]
    open(path, "w", encoding="utf-8").write(s)
    if staged:
        subprocess.run(["git", "add", path], check=True)

parsed = {}
for f in faces:
    r = read_version(f)
    if r:
        parsed[f] = r

if authority not in parsed:
    sys.exit(0)
_, am, acur = parsed[authority]

if head_version(authority) not in (None, acur):
    print(f"honored manual version {authority}: {head_version(authority)} -> {acur}")
    new = acur
else:
    if am.group(3) is None:
        new = f"{am.group(1)}.{int(am.group(2)) + 1}"
    else:
        new = f"{am.group(1)}.{am.group(2)}.{int(am.group(3)) + 1}"
    print(f"bumped {authority}: {acur} -> {new}")
    write_version(authority, am, new)

# The other face follows the authority, unless a human owns its number.
for f in faces:
    if f == authority or f not in parsed:
        continue
    _, fm, fcur = parsed[f]
    hv = head_version(f)
    if hv is not None and fcur != hv:
        print(f"honored manual version {f}: {hv} -> {fcur}")
        continue
    write_version(f, fm, new)
    print(f"synced {f}: {fcur} -> {new}")
EOF
