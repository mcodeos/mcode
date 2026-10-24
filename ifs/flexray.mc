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

    // Corpus verdict (carriers are all MCU communication controllers:
    // Infineon AURIX TC27x E-Ray, TI Hercules TMS570, ST SPC5 -- zero
    // FlexRay transceiver/PHY document exists corpus-wide, so the bus
    // electrical face has no witnesses at all): all three retired rows
    // carried no interface-level contract. Distance: zero witnesses
    // corpus-wide (folklore). Speed: the protocol identity -- FlexRay
    // V2.1 runs 2.5/5/8/10 Mbit/s per channel; the per-part module rate
    // rows live on the MCU datasheet faces (TMS570 "10 Mbps, 2
    // channels"; SPC58 RM lists the four rates). Voltage: zero
    // witnesses -- no bus driver document states levels on this face.
    // No .ELEC book: zero all-sample keys exist, and the electrical
    // population is empty (half-device law has nothing to judge).

    pins = [
        1 = CH_A\+ @sig.pair(cha) @id.class(digital), "Channel A Positive"    // Positive differential signal for channel A
        2 = CH_A\- @sig.pair(cha) @id.class(digital), "Channel A Negative"    // Negative differential signal for channel A
        3 = CH_B\+ @sig.pair(chb) @id.class(digital), "Channel B Positive"    // Positive differential signal for channel B
        4 = CH_B\- @sig.pair(chb) @id.class(digital), "Channel B Negative"    // Negative differential signal for channel B
        5 = GND, "Ground"                  // Signal reference ground
    ]
    
    role NODE {
        name = "FlexRay Node"
        pins = [
            io 1 = CH_A\+ @sig.pair(cha) @id.class(digital), "Channel A Positive"  // TDMA time-share: a node drives its own slot
            io 2 = CH_A\- @sig.pair(cha) @id.class(digital), "Channel A Negative"  // and listens on every other slot
            io 3 = CH_B\+ @sig.pair(chb) @id.class(digital), "Channel B Positive"
            io 4 = CH_B\- @sig.pair(chb) @id.class(digital), "Channel B Negative"
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

    // Corpus verdict (consumer = the AURIX tc27x family bindings; the
    // link is a board-level controller-to-transceiver digital face):
    // the retired rows carried no interface-level contract. Distance
    // (0.5 m) and the rate-at-distance spelling are board-routing
    // folklore -- zero witnesses corpus-wide; the bit-stream rate is the
    // bus face's protocol rate, never a length function. Voltage:
    // logic levels ride each controller/transceiver's own supply
    // (GPIO EC inheritance), no interface-level list exists. No .ELEC
    // book: zero all-sample keys on this face.

    // Role-less conductor view: 4 anonymous lanes, ordinal = wire identity
    pins = [
        1 = _ @id.class(digital) // TXD_A <-> TXD_A
        2 = _ @id.class(digital) // RXD_A <-> RXD_A
        3 = _ @id.class(digital) // TXD_B <-> TXD_B
        4 = _ @id.class(digital) // RXD_B <-> RXD_B
    ]

    role CTRL {
        name = "FLEXRAY.TTL Controller"
        pins = [
            out 1 = TXD_A @id.class(digital), "Channel A transmit bit stream"
            in 2 = RXD_A @id.class(digital), "Channel A receive bit stream"
            out 3 = TXD_B @id.class(digital), "Channel B transmit bit stream"
            in 4 = RXD_B @id.class(digital), "Channel B receive bit stream"
        ]
        peer = XCVR
    }

    role XCVR {
        name = "FLEXRAY.TTL Transceiver"
        pins = [
            in 1 = TXD_A @id.class(digital), "Channel A transmit bit stream"
            out 2 = RXD_A @id.class(digital), "Channel A receive bit stream"
            in 3 = TXD_B @id.class(digital), "Channel B transmit bit stream"
            out 4 = RXD_B @id.class(digital), "Channel B receive bit stream"
        ]
        peer = CTRL
    }
}
