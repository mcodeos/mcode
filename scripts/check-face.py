#!/usr/bin/env python3
# Copyright 2026 MCode
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Pin-face gate for the mcode library (b3843; checklist doc/library/mcode-authoring-checklist.md section 7).

Two rules are gated (exit 1 on findings). The gate locks exactly the shapes
this batch fixed, per the check-spec-keys precedent: a gate lands together
with its fixes, never over a red corpus.

  R1 usage-block    a file that declares components carries a trailing
                    `Usage Examples` block (b3793). Interface files (ifs/)
                    and pure `pub use` aggregators are out of scope.
  R2 conn book-names under conn/ a pin row never names the pin with its own
                    number (`1 = 1, "..."`); connector faces name pins from
                    the datasheet pin book (b3838). Root-primitive terminal
                    counting stays legal outside conn/ (U193 faces, R/C/L
                    terminals, POT/ARRAY/CMC).

Two rules are reported but not gated - they are campaign worklists, not
violations of landed law (gating them today would ship a red gate):

  R3 direction words   files whose components declare no in/out/io row at
                       all; direction-driven ERC stays dark for them (U208).
  R4 DC-face coverage  power-named pin rows that bind no ::DC; the known
                       residuals are POWER.ATX rails (one member one pin
                       count law), SIM VPP, USB.SOCK_C (U205③).

Exit 0 = gated rules clean, 1 = findings. Lines are reported as
`file:line: message`.
"""

import re
import sys
from pathlib import Path

COMPONENT_RE = re.compile(r"^(abstract\s+)?component\b")
USAGE_RE = re.compile(r"usage example", re.IGNORECASE)
NUMBER_NAME_RE = re.compile(r"^\s*([0-9]+)\s*=\s*\1\b")
DIRECTION_RE = re.compile(r"^\s*(in|out|io|psrc|psnk|psbi)\b")
POWER_NAME_RE = re.compile(r"(VCC|VDD|VBUS|VPP|PWR|POWER|P\dV|N\dV|\d+V)", re.IGNORECASE)


def check_file(path, in_conn):
    """Return (gated, report) findings for one file."""
    gated, report = [], []
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines()

    has_component = any(COMPONENT_RE.match(ln) for ln in lines)
    if has_component and not USAGE_RE.search(text):
        gated.append(f"{path}:0: file declares components but carries no Usage Examples block (b3793)")

    has_direction = False
    for lineno, ln in enumerate(lines, 1):
        if in_conn and NUMBER_NAME_RE.match(ln):
            gated.append(
                f"{path}:{lineno}: conn face names a pin with its own number - use the datasheet pin book name (b3838)"
            )
        if DIRECTION_RE.match(ln):
            has_direction = True
        # report-only: a power-looking pin row with no ::DC binding
        if NUMBER_NAME_RE.match(ln) or re.match(r"^\s*[0-9]+\s*=", ln):
            if POWER_NAME_RE.search(ln) and "::DC" not in ln:
                report.append(f"{path}:{lineno}: power-named pin row binds no ::DC (worklist)")
    if has_component and not has_direction:
        report.append(f"{path}:0: no direction word in the whole file - direction ERC stays dark (U208 worklist)")
    return gated, report


def main():
    root = Path(__file__).resolve().parent.parent
    gated, report = [], []
    for path in sorted(root.rglob("*.mc")):
        rel = path.relative_to(root).as_posix()
        if rel.startswith("ifs/"):
            continue
        g, r = check_file(path, rel.startswith("conn/"))
        gated.extend(g)
        report.extend(r)
    for f in gated:
        print(f)
    if report:
        print("-- worklist (report-only, not gated) --")
        for f in report:
            print(f)
    print(f"check-face: {len(gated)} findings, {len(report)} worklist items")
    return 1 if gated else 0


if __name__ == "__main__":
    sys.exit(main())
