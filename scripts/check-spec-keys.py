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

"""Spec-key vocabulary gate for the mcode library (U185).

One concept one spelling, enforced on the three quantity axes that had
drifted (audit log 9.22.mcode-public-library-audit.md section B):

    withstand voltage ... voltage          (never voltage_rated)
    continuous power ..... power_rated     (never power_rating / power;
                                            peak_power is a distinct quantity)
    thermal current ...... rated_current   (never rating / maximum_current)

plus the constructor-formal rule (README "decision record 3" section 2): a
formal never duplicates its spec key. The gate locks exactly the shapes the
audit named (output_type / sensitivity / response_time / accuracy /
channel_count / type); the single-word identity idiom (pin_count = pin_count,
gain = gain, ...) is a separate open item and deliberately not flagged here.

Exit 0 = clean, 1 = findings. Lines are reported as `file:line: message`.
"""

import re
import sys
from pathlib import Path

BANNED_KEYS = {
    "voltage_rated": "use `voltage`",
    "power_rating": "use `power_rated`",
    "maximum_current": "use `rated_current`",
    "rating": "use `rated_current`",
    "power": "use `power_rated` (peak_power is a distinct quantity)",
}

# Keys whose `key = key` formal self-copy the audit named and this batch
# fixed; a re-appearance is a regression.
NO_SELF_COPY = {
    "output_type",
    "sensitivity",
    "response_time",
    "accuracy",
    "channel_count",
    "type",
    "rating",
    "voltage_rated",
    "power_rating",
    "maximum_current",
    "power",
}

SPEC_LINE = re.compile(r"^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=")
SELF_COPY = re.compile(r"^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*([A-Za-z_][A-Za-z0-9_]*)\s*(//|#|$)")
SPEC_OPEN = re.compile(r"^\s*spec\s*=\s*\[")

CODE_RE = re.compile(r"//.*?$|#.*?$")


def strip_comment(line):
    """Drop the trailing // or # comment (none of the library's spec values
    contain those markers inside strings)."""
    return CODE_RE.sub("", line).strip()


def spec_key_lines(text):
    """Yield (lineno, line) for the entry lines inside a `spec = [ ... ]`
    table only. Interface headers also carry short-word property rows
    (`voltage = [...]`, `power = [...]` - legal there), so an unscoped scan
    would misfire on them; bracket depth decides what a spec table spans."""
    depth = 0
    for lineno, line in enumerate(text.splitlines(), 1):
        code = strip_comment(line)
        if depth == 0:
            if SPEC_OPEN.match(code):
                depth = 1
            continue
        if not code:
            continue
        yield lineno, line
        depth += code.count("[") - code.count("]")
        if depth <= 0:
            depth = 0


def check_file(path):
    findings = []
    for lineno, line in spec_key_lines(path.read_text(encoding="utf-8")):
        code = strip_comment(line)
        m = SPEC_LINE.match(code)
        if not m:
            continue
        key = m.group(1)
        if key in BANNED_KEYS:
            findings.append(f"{path}:{lineno}: spec key `{key}` is retired - {BANNED_KEYS[key]}")
            continue
        c = SELF_COPY.match(code)
        if c and c.group(1) == c.group(2) and c.group(1) in NO_SELF_COPY:
            findings.append(
                f"{path}:{lineno}: formal duplicates its spec key `{key} = {key}` - give the formal a merged alias"
            )
    return findings


def main():
    root = Path(__file__).resolve().parent.parent
    findings = []
    for path in sorted(root.rglob("*.mc")):
        findings.extend(check_file(path))
    for f in findings:
        print(f)
    print(f"check-spec-keys: {len(findings)} findings")
    return 1 if findings else 0


if __name__ == "__main__":
    sys.exit(main())
