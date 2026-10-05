# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// FLEXRAY - FlexRay Automotive Bus Interface Standard Definition
// Core Rule: Deterministic, fault-tolerant time-triggered automotive bus
//            over two redundant differential channels (A/B); nodes
//            time-share the medium, driving their own slot and listening
//            on every other slot.
// Device Definition: NODE = any FlexRay node (peer-equal time-share).

interface FLEXRAY(role)
{
    topology = "star"
    mode = ["full duplex"]
    maxdistance = 10m
    maxspeed = [10Mbps]
    voltage = 5V

    pins = [
        1 = CH_A\+ @pair(cha) @class(digital), "Channel A Positive"    // Positive differential signal for channel A
        2 = CH_A\- @pair(cha) @class(digital), "Channel A Negative"    // Negative differential signal for channel A
        3 = CH_B\+ @pair(chb) @class(digital), "Channel B Positive"    // Positive differential signal for channel B
        4 = CH_B\- @pair(chb) @class(digital), "Channel B Negative"    // Negative differential signal for channel B
        5 = GND, "Ground"                  // Signal reference ground
    ]
    
    role NODE {
        name = "FlexRay Node"
        pins = [
            io 1 = CH_A\+ @pair(cha) @class(digital), "Channel A Positive"  // TDMA time-share: a node drives its own slot
            io 2 = CH_A\- @pair(cha) @class(digital), "Channel A Negative"  // and listens on every other slot
            io 3 = CH_B\+ @pair(chb) @class(digital), "Channel B Positive"
            io 4 = CH_B\- @pair(chb) @class(digital), "Channel B Negative"
            5 = GND, "Ground"                    // Signal reference ground
        ]
        peer = NODE
    }
}

// FLEXRAY.TTL - FlexRay Controller/Transceiver Link (TTL levels) Standard
// Definition
// Core Rule: Point-to-point serial links between one FlexRay communication
//            controller and its transceiver, one pair per redundant
//            channel (A/B): the controller hands the transmit bit stream
//            to the transceiver (TXD) and takes the bus bit stream back
//            (RXD). TDMA scheduling stays in the controller; the
//            transceiver only translates levels. The bus face (CH_A/CH_B
//            differential pairs) is the FLEXRAY interface, not this link.
// Device Definition: CTRL = FlexRay communication controller,
//                    XCVR = bus transceiver (level translation only).

interface FLEXRAY.TTL(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [10Mbps@0.5m]
    voltage = [3.3V, 5V]

    // Role-less conductor view: 4 anonymous lanes, ordinal = wire identity
    pins = [
        1 = _ @class(digital) // TXD_A <-> TXD_A
        2 = _ @class(digital) // RXD_A <-> RXD_A
        3 = _ @class(digital) // TXD_B <-> TXD_B
        4 = _ @class(digital) // RXD_B <-> RXD_B
    ]

    role CTRL {
        name = "FLEXRAY.TTL Controller"
        pins = [
            out 1 = TXD_A @class(digital), "Channel A transmit bit stream"
            in 2 = RXD_A @class(digital), "Channel A receive bit stream"
            out 3 = TXD_B @class(digital), "Channel B transmit bit stream"
            in 4 = RXD_B @class(digital), "Channel B receive bit stream"
        ]
        peer = XCVR
    }

    role XCVR {
        name = "FLEXRAY.TTL Transceiver"
        pins = [
            in 1 = TXD_A @class(digital), "Channel A transmit bit stream"
            out 2 = RXD_A @class(digital), "Channel A receive bit stream"
            in 3 = TXD_B @class(digital), "Channel B transmit bit stream"
            out 4 = RXD_B @class(digital), "Channel B receive bit stream"
        ]
        peer = CTRL
    }
}
