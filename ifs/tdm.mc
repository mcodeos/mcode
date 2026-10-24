# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// TDM - Time-Division Multiplexed Audio Port Standard Definition
// Core Rule: Multi-lane digital audio port: one bit clock (BCLK), one
//            frame sync (FSYNC), and a fixed bank of directional data
//            lanes - four transmit lanes (TX0..TX3) and four receive
//            lanes (RX0..RX3). A link using fewer lanes binds a subset
//            and leaves the rest unconnected (the LVDS subset law);
//            a single-lane TDM link binds TX0/RX0 only. Which time
//            slots ride each lane is the protocol face - the slot map
//            is register/protocol configuration, never a wiring
//            contract (the PCM book's ruling: TDM is slot
//            programmability, not electrical).
// Device Definition: TRANSMITTER = drives its transmit lanes, listens
//                    on its receive lanes. RECEIVER = mirrored. Both
//                    roles are full duplex (the PCM IN/OUT law: each
//                    lane keeps its family name on both sides, the
//                    direction word flips). BCLK/FSYNC stay
//                    direction-less in the role views - either side
//                    can be the controller (the I2S SCK/WS law).

interface TDM(role) {
    topology = "point to point"
    mode     = ["full duplex"]

    // No interface electrical book: logic levels are proportional to
    // each chip's own supply and ride the DC faces (same verdict as
    // the I2S and PCM books); slot counts and formats are protocol
    // configuration, not electrical.

    pins = [
        1  = BCLK @id.class(digital), "Bit Clock"    // Serial bit clock, shared
        2  = FSYNC @id.class(digital), "Frame Sync"  // Frame synchronization, shared
        3  = TX0 @id.class(digital), "Transmit data lane 0"
        4  = TX1 @id.class(digital), "Transmit data lane 1"
        5  = TX2 @id.class(digital), "Transmit data lane 2"
        6  = TX3 @id.class(digital), "Transmit data lane 3"
        7  = RX0 @id.class(digital), "Receive data lane 0"
        8  = RX1 @id.class(digital), "Receive data lane 1"
        9  = RX2 @id.class(digital), "Receive data lane 2"
        10 = RX3 @id.class(digital), "Receive data lane 3"
    ]

    role TRANSMITTER {  // TDM Transmitter - drives the transmit lanes
        name = "TDM Transmitter"

        pins = [
            1     = BCLK @id.class(digital), "Bit Clock"            // Controller face — direction follows the controller
            2     = FSYNC @id.class(digital), "Frame Sync"          // Controller face — direction follows the controller
            out 3 = TX0 @id.class(digital), "Transmit data lane 0"  // My side drives the transmit lanes
            out 4 = TX1 @id.class(digital), "Transmit data lane 1"
            out 5 = TX2 @id.class(digital), "Transmit data lane 2"
            out 6 = TX3 @id.class(digital), "Transmit data lane 3"
            in 7  = RX0 @id.class(digital), "Receive data lane 0"   // and listens on the receive lanes
            in 8  = RX1 @id.class(digital), "Receive data lane 1"
            in 9  = RX2 @id.class(digital), "Receive data lane 2"
            in 10 = RX3 @id.class(digital), "Receive data lane 3"
        ]
        peer = RECEIVER
    }
    role RECEIVER {  // TDM Receiver - listens on the transmit lanes
        name = "TDM Receiver"

        pins = [
            1      = BCLK @id.class(digital), "Bit Clock"            // Controller face — direction follows the controller
            2      = FSYNC @id.class(digital), "Frame Sync"          // Controller face — direction follows the controller
            in 3   = TX0 @id.class(digital), "Transmit data lane 0"  // My side listens on the transmit lanes
            in 4   = TX1 @id.class(digital), "Transmit data lane 1"
            in 5   = TX2 @id.class(digital), "Transmit data lane 2"
            in 6   = TX3 @id.class(digital), "Transmit data lane 3"
            out 7  = RX0 @id.class(digital), "Receive data lane 0"   // and drives the receive lanes
            out 8  = RX1 @id.class(digital), "Receive data lane 1"
            out 9  = RX2 @id.class(digital), "Receive data lane 2"
            out 10 = RX3 @id.class(digital), "Receive data lane 3"
        ]
        peer = TRANSMITTER
    }
}
