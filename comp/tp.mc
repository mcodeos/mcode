# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

# Test Point — industry standard "TP" (TP1, TP2 ... on schematics/PCB)
#
# A test point is a single pin: one instance per net tap.
#   TP1::TP()   -> one test point
component TP()
{
    name = "Test Point"
    description = "Electrical test point for circuit debugging"

    pins = [
        1 = TP
    ]
}

# Usage Examples:
# TP() probe_3v3
# vcc_3v3 -> probe_3v3.TP
# TP() probe_gnd
