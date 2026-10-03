# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ---------------------------------------------------------------------------------------------
// DC Power Supply Interface
// ---------------------------------------------------------------------------------------------

interface DC(volt::UV.VOLT) // DC Power Supply Interface
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 3m
    voltage = volt

    // DC Power Supply Standard Definition
    // Core Rule: Unidirectional direct current power supply
    // Naming law (U216, ruled 2026-09-23): one computed rule replaces the
    //   fourteen voltage branches — "VCC" + the canonical rail text of volt
    //   (canon: one fixed decimal, the decimal point read as `V`, a negative
    //   value marked `N`; 3.3V → VCC3V3, 12V → VCC12V0, -5V → VCC5V0N). A
    //   voltage that binds to no single number keeps the sign-aware generic
    //   name: VCC (the ELSE branch is also what the declared family table —
    //   the boundary face, U141 — spells).
    // Energy direction is not a DC parameter (role slot removed 2026-09-07):
    // source/sink rides on the adopting terminal's direction word
    // (psrc = source / psnk = sink / psbi = bidir) at the pin/port level.
    // Applications: Powering electronic circuits and devices

    if (volt < 0V)
        pins = [
            1 = "VCC" + canon(volt), "DC power negative", voltage:volt
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt > 0V)
        pins = [
            1 = "VCC" + canon(volt), "DC power positive", voltage:volt
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else
        pins = [
            1 = VCC, "DC power positive", voltage:volt
            2 = GND, "DC power ground", voltage:0.0V
        ]

}
