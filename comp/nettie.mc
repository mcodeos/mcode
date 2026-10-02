# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// ---------------------------------------------------------------------------------------------
// NETTIE — net bridge (two pads shorted by copper; keeps two nets distinct on
// paper while forcing them to the same copper, e.g. power sampling points,
// controlled net merging). The short is physical, not a connection statement:
// the two terminals stay separately addressable.
// ---------------------------------------------------------------------------------------------

component NETTIE()
{
    name = "Net Tie"
    description = "Two-terminal net bridge, pads shorted on the part"

    spec = [
        current = _ // [1A, 2A]
        style = _ // [inline, s-bend]
        mount = _ // [surface-mount]
    ]

    pins = [
        1 = A, "Net A side"
        2 = B, "Net B side"
    ]
}

# Usage Examples:
# NETTIE() tie1
# reg_out -> tie1.A
# tie1.B -> sample_point
