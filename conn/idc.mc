# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// IDC - Two-row insulation-displacement socket for flat ribbon cable Component Definition
// Core Rule: Physical face = counted plain pins, no interface binding: the
// contact is a physical socket, not an electrical signal face. Contact
// numbering follows the ribbon: odd row 1..n, even row n+1..2n as printed on
// standard ribbon shrouds.

component IDC(pincnt::INT)
{
    name = "IDC Ribbon Cable Socket"
    description = "Two-row insulation-displacement ribbon cable socket"

    spec = [
        pin_count = pincnt // [10, 14, 16, 20, 26, 34, 40, 50, 64]
        pitch = 2.54mm
        keying = _ // [shrouded box, notch, key slot]
        rohs = _
    ]

    pins = [
        1:pin_count = 1:pin_count
    ]
}

// Usage Examples:
// 1. 2x5 ribbon socket (10 way)
// IDC(10)
//
// 2. 2x10 ribbon socket (20 way)
// IDC(20)
