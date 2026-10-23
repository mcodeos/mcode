#!/usr/bin/env python3
# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

"""Group-membership gate for the scoped enums of this library.

An enum whose members fall into logical groups carries a judgement: a
dielectric code is not a construction, and a safety class is neither.  When
that judgement lives in a comment, no gate can read it -- and a judgement
no gate can read is a judgement nobody enforces.

So the grouping lives in a machine file next to the enum
(`mcode/tables/cap.groups.json`, `mcode/tables/conn.groups.json`), and this gate
holds it against the enum and against the assignments the library writes:

  G1 membership   every group member is an enum member
  G2 coverage     every enum member belongs to at least one group
  G3 key face     every declared spec key exists in the component spec face
  G4 assignment   every spec value on a declared key belongs to that key's
                  group -- a cross-group assignment is a finding
  G5 parameter    every declared parameter's default value belongs to the
                  group the parameter is declared for

Usage
    python3 scripts/check-enum-groups.py

Exit code 0 = the grouping, the enum and the assignments agree; 1 = a finding.
"""

import json
import os
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from tracked import tracked_files

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
COMP = os.path.join(ROOT, "comp")

DECL_RX = re.compile(r"\benum\s+([A-Z][A-Za-z0-9_]*)\s*\{")
IDENT_RX = re.compile(r"[A-Za-z_][A-Za-z0-9_]*")
SPEC_LINE_RX = re.compile(r"^\s*([a-z_][a-z0-9_]*)\s*=\s*([A-Za-z_][A-Za-z0-9_.]*)")
GROUP_FILES = "tables/*.groups.json"


def enum_members(path, name):
    """The members of the named enum in the given file."""
    text = open(path, encoding="utf-8").read()
    text = re.sub(r"/\*.*?\*/", " ", text, flags=re.S)
    text = re.sub(r"//[^\n]*", " ", text)
    m = DECL_RX.search(text)
    if not m or m.group(1) != name:
        raise SystemExit(f"check-enum-groups: enum {name} not found in {path}")
    body = text[m.end():]
    depth = 1
    i = 0
    while i < len(body) and depth:
        if body[i] == "{":
            depth += 1
        elif body[i] == "}":
            depth -= 1
        i += 1
    inner = body[:i - 1]
    out = []
    for chunk in re.split(r"[,\n]", inner):
        ident = IDENT_RX.search(chunk)
        if ident:
            out.append(ident.group(0))
    return out


def spec_assignments(path, keys):
    """The assignments made on the given spec keys, in file order.

    Only the literal values are collected: a value that names a component
    parameter is checked through the parameter default instead, so that the
    parameter's own group is the one that answers.
    """
    text = open(path, encoding="utf-8").read()
    text = re.sub(r"//[^\n]*", "", text)
    text = re.sub(r"/\*.*?\*/", " ", text, flags=re.S)
    out = []
    for line in text.splitlines():
        m = SPEC_LINE_RX.match(line)
        if not m:
            continue
        key, value = m.group(1), m.group(2)
        if key not in keys:
            continue
        out.append((key, value))
    return out


def param_defaults(path, names, enum_name):
    """The default values of the named component parameters."""
    text = open(path, encoding="utf-8").read()
    text = re.sub(r"//[^\n]*", "", text)
    text = re.sub(r"/\*.*?\*/", " ", text, flags=re.S)
    rx = re.compile(r"\b([a-z_][a-z0-9_]*)\s*=\s*" + re.escape(enum_name)
                    + r"\.([A-Z][A-Z0-9_]*)")
    out = []
    for m in rx.finditer(text):
        if m.group(1) in names:
            out.append((m.group(1), m.group(2)))
    return out


def check(path, findings):
    data = json.load(open(path, encoding="utf-8"))
    enum_name = data["enum"]
    source = os.path.join(ROOT, data["source"])
    members = enum_members(source, enum_name)
    member_set = set(members)
    groups = data["groups"]
    keys = data.get("keys", {})
    params = data.get("params", {})

    # G1 / G2: the groups and the enum cover each other.
    owner = {}
    for group, names in groups.items():
        for name in names:
            if name not in member_set:
                findings.append(f"{data['id']}: group member {name} is not an enum member")
            owner.setdefault(name, set()).add(group)
    for name in members:
        if name not in owner:
            findings.append(f"{data['id']}: enum member {name} belongs to no group")

    # G3: every declared key is a real spec key of the library.
    seen_keys = {k for k, _ in spec_assignments(source, set(keys))}
    for key, group in keys.items():
        if group not in groups:
            findings.append(f"{data['id']}: key {key} names an unknown group {group}")
        if key not in seen_keys:
            findings.append(f"{data['id']}: spec key {key} is not used in {data['source']}")

    # G4: no cross-group assignment.
    for key, value in spec_assignments(source, set(keys)):
        group = keys.get(key)
        bare = value.split(".")[-1]
        if bare not in member_set:
            continue  # a parameter reference or another vocabulary
        if group not in groups:
            continue
        if bare not in groups[group]:
            findings.append(
                f"{data['id']}: {key} = {value} crosses groups "
                f"({bare} is not in the {group} group)")

    # G5: a declared parameter's default value belongs to its group.
    for name, value in param_defaults(source, set(params), enum_name):
        group = params.get(name)
        if group not in groups:
            continue
        if value not in groups[group]:
            findings.append(
                f"{data['id']}: parameter {name} defaults to {value}, "
                f"which is not in the {group} group")


def main():
    findings = []
    files = list(tracked_files(ROOT, GROUP_FILES))
    if not files:
        print("check-enum-groups: no group files, nothing to check")
        return 0
    for path in files:
        check(path, findings)
    if findings:
        for f in findings:
            print(f"check-enum-groups: {f}")
        return 1
    print(f"check-enum-groups: {len(files)} group file(s), no cross-group assignment")
    return 0


if __name__ == "__main__":
    sys.exit(main())
