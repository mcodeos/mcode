# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// RF_DIFF - Differential RF Port Interface Standard Definition
// Core Rule: One bidirectional RF carrier signal carried as a
//            differential pair; the two rows tagged @pair(rf) are the
//            P/N legs of the pair (P/N naming convention). The port is
//            role-less: the duplex direction alternates on the same
//            pair (half duplex) or splits by band (full duplex), so
//            neither end holds a fixed source/sink identity, and
//            matching networks (balun, switch, PA) may interpose. The
//            ground reference is the circuit/board ground, not a face
//            member.

interface RF_DIFF // Differential RF port pair (transceiver / front-end / antenna side)
{
    topology = "point to point"
    mode = ["half duplex", "full duplex"]

    // Radio service data (band, air-data rate, sensitivity, output power
    // windows) rides the adopting recipe face; this definition carries
    // structure only.

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    pins = [
        1 = _ @pair(rf) @class(radio) // positive RF leg
        2 = _ @pair(rf) @class(radio) // negative RF leg
    ]
}
