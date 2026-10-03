# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Galvanic-isolation barrier face (reinforced/basic insulation barrier
// between two logic domains). The family carries the physical barrier
// pins of an isolator body: channel legs per side, the enable, and the
// two side-referenced returns (GND1/GND2 are physical pins of the
// barrier body -- the A3 exception for bodies whose ground is part of
// the isolation geometry, like connector shells).
//
// Members:
//   IN[A,B,C,D]  -- logic-side channel legs (@barrier(side1))
//   OUT[A,B,C,D] -- field-side channel legs (@barrier(side2))
//   EN2          -- default-output select (field side)
//   GND1/GND2    -- side returns, one per barrier face
//
// Sides are the pairing identity: a transceiver/isolator body adopts
// CONSUMER on the logic face and PROVIDER on the field face; the ERC
// pairs them across the barrier.

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

# =============================================================================
# Usage Examples:
# -----------------------------------------------------------------------------
# component MY_ISOLATOR : ISOLATION          // barrier body takes the face table
#     in [3:6] = IN[A,B,C,D]::GPIO(CONSUMER)  // logic side adopts its own view
#     out [14:11] = OUT[A,B,C,D]::GPIO(PROVIDER)
# =============================================================================
