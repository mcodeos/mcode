# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ISOLATION - Galvanic Isolation Barrier Interface Standard Definition
// Core Rule: The physical barrier face (reinforced/basic insulation
//            barrier between two logic domains) of an isolator body:
//            logic-side channel legs (@barrier(side1)), field-side
//            channel legs (@barrier(side2)), the default-output select
//            (EN2, field side), and the two side-referenced returns
//            GND1/GND2 — physical pins of the barrier body, the
//            exception for bodies whose ground is part of the isolation
//            geometry. Sides are the pairing identity: a body adopts
//            CONSUMER on the logic face and PROVIDER on the field face,
//            and the ERC pairs them across the barrier.

interface ISOLATION
{
    pins = [
        1:4 = IN[A,B,C,D] @barrier(side1)
        5:8 = OUT[A,B,C,D] @barrier(side2)
        9 = EN2
        10 = GND1 @barrier(side1)
        11 = GND2 @barrier(side2)
    ]
}

// =============================================================================
// Usage Examples:
// -----------------------------------------------------------------------------
// component MY_ISOLATOR : ISOLATION          // barrier body takes the face table
//     in [3:6] = IN[A,B,C,D]::GPIO(CONSUMER)  // logic side adopts its own view
//     out [14:11] = OUT[A,B,C,D]::GPIO(PROVIDER)
// =============================================================================
