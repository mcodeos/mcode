# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// ---------------------------------------------------------------------------------------------
// Terminal Block (barrier block) Definitions
// ---------------------------------------------------------------------------------------------
// Screw-terminal wire-to-board family: one pole per position, numbered left to
// right as seen from the wire side. Physical face = counted plain pins, no
// interface binding (U193 physical-socket ruling).

// Screw Terminal Block
component TERM.BLOCK(positions::INT)
{
    name = "Screw Terminal Block"
    description = "Barrier screw terminal block, one pole per position"

    spec = [
        positions = positions // [2, 3, 4, 5, 6, 7, 8, 10, 12]
        pitch = _ // [2.54mm, 3.5mm, 3.81mm, 5.0mm, 5.08mm, 7.62mm]
        orientation = _ // [horizontal, vertical, 45deg]
        wire_gauge = _ // [28AWG ~ 12AWG typical]
        rohs = _
    ]

    pins = [
        1:positions = 1:positions
    ]
}

// Usage Examples:
// 1. 2-position power entry terminal
// TERM.BLOCK(2)
//
// 2. 6-position signal terminal
// TERM.BLOCK(6)
