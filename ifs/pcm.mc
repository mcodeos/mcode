# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// PCM - Pulse Code Modulation Audio Interface Standard Definition
// Core Rule: Digital audio link between audio CODECs and processors: bit
//            clock (CLK), frame sync (SYNC), and a data pair that flips
//            per side (ordinal k on the two sides is the same wire — one
//            side's IN is the other's OUT).
// Device Definition: TRANSMITTER = sends audio data (drives OUT,
//                    listens on IN),
//                    RECEIVER = receives audio data.

interface PCM(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 2m
    maxspeed = [32Mbps@2m, 64Mbps@1m]
    voltage = [1.8V,3.3V,5V]

    // Role-less conductor view: 5 named lanes, ordinal = wire identity
    // (every name is the same on both sides). No direction words here: the
    // role tables below carry the directed views, and the data pair flips
    // per side.
    pins = [
        1 = CLK @class(digital), "Bit Clock"        // Bit clock signal
        2 = SYNC @class(digital), "Frame Sync"      // Frame synchronization signal
        3 = IN @class(digital), "Audio Input"       // Audio data line
        4 = OUT @class(digital), "Audio Output"     // Audio output line
        5 = GND, "Ground"           // Ground
    ]

    role TRANSMITTER {  // PCM Transmitter - Sends audio data
        name = "PCM Transmitter"
        pins = [
            1 = CLK @class(digital), "Bit Clock"        // Bit clock signal
            2 = SYNC @class(digital), "Frame Sync"      // Frame synchronization signal
            in 3 = IN @class(digital), "Audio Input"    // Audio data input (my side listens)
            out 4 = OUT @class(digital), "Audio Output" // Audio data output (my side drives)
            5 = GND, "Ground"           // Ground
        ]
        peer = RECEIVER
    }
    role RECEIVER {  // PCM Receiver - Receives audio data
        name = "PCM Receiver"
        pins = [
            1 = CLK @class(digital), "Bit Clock"        // Bit clock signal
            2 = SYNC @class(digital), "Frame Sync"      // Frame synchronization signal
            out 3 = IN @class(digital), "Audio Input"   // Same wire as the transmitter's input
            in 4 = OUT @class(digital), "Audio Output"  // Same wire as the transmitter's output
            5 = GND, "Ground"           // Ground
        ]
        peer = TRANSMITTER
    }
}
