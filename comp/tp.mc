# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// TP - Single-Pin Test Point Component Definition
// Core Rule: one instance per net tap; the single pin is a pure measurement
// tap and carries no electrical function of its own.

component TP()
{
    name = "Test Point"
    description = "Electrical test point for circuit debugging"

    pins = [
        1 = TP
    ]
}

// Usage Examples:
// TP() probe_3v3
// vcc_3v3 -> probe_3v3.TP
// TP() probe_gnd
