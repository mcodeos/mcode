#!/usr/bin/env python3
# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

"""The library face of this repository: the files a commit would carry.

A gate that scans the working tree also scans the wreckage.  A scratch
build tree holds copies of the library that nobody maintains, and a
finding inside one of them is noise that buries the finding that
matters -- a gate that cries wolf over its own garbage teaches the
reader to ignore it.

So the scan face is the tracked face: the files the repository tracks,
plus the untracked files that are not ignored.  Build scratch is ignored,
so it is not on this face.

Used by:
  scripts/check-face.py        -- the pin-face gate
  scripts/check-spec-keys.py   -- the spec-key vocabulary gate
"""

import subprocess
from pathlib import Path


def tracked_mc(root: Path):
    """Return the sorted `.mc` files of the repository's library face."""
    out = subprocess.run(
        ["git", "-C", str(root), "ls-files", "-z",
         "--cached", "--others", "--exclude-standard", "--", "*.mc"],
        capture_output=True, check=True, text=True,
    ).stdout
    names = [name for name in out.split("\0") if name]
    return sorted(root / name for name in names)
