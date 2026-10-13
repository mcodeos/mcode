# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// RF_SE - Single-Ended RF Port Interface Standard Definition
// Core Rule: One bidirectional RF carrier signal on a single conductor,
//            referenced to the circuit/board ground (no ground member
//            here). The port is role-less: the duplex direction
//            alternates on the same conductor (half duplex) or splits
//            by band (full duplex), so neither end holds a fixed
//            source/sink identity, and matching networks (balun,
//            switch, PA) may interpose. One instance per RF port; a
//            group with several members binds one port per member
//            (antenna-diversity paths are separate ports).

interface RF_SE // Single-ended RF port (transceiver / front-end / antenna side)
{
    topology = "point to point"
    mode = ["half duplex", "full duplex"]

    // Radio service data (band, air-data rate, sensitivity, output power
    // windows) rides the adopting recipe face; this definition carries
    // structure only.

    // Role-less conductor view: 1 anonymous lane, ordinal = wire identity
    pins = [
        1 = _ @class(radio) // the RF conductor
    ]
}
