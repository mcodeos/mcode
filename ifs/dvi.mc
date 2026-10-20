# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// DVI - Digital Visual Interface Standard Definition
// Core Rule: TMDS differential pairs carry the video stream one way - data
//            2 / 1 / 0 plus the clock for a single link, data 3 / 4 / 5
//            joining them for a dual link. A DDC I2C pair (SCL / SDA)
//            carries the EDID channel and a sink-driven hot-plug detect
//            completes the link. The four shield contacts and the +5V feed
//            with its return are not link members: the shields are in-shell
//            members with no far-end counterpart, and the power rides the
//            DC face. The DDC pair is a dedicated member here, not a
//            generic I2C instance - it runs on the +5V rail of this link
//            and is open-drain with the link's own pullups.
// Device Definition: SOURCE = the transmitter (GPU / SoC display output),
//                    SINK = the receiver (display panel).
// Pin map: the standard DVI-D 24-contact assignment - 1 = data 2-, 2 =
//            data 2+, 3 = data 2/4 shield, 4 = data 4-, 5 = data 4+, 6 =
//            DDC clock, 7 = DDC data, 8 = reserved (analog vertical sync
//            on the analog variants), 9 = data 1-, 10 = data 1+, 11 =
//            data 1/3 shield, 12 = data 3-, 13 = data 3+, 14 = +5V, 15 =
//            ground, 16 = hot-plug detect, 17 = data 0-, 18 = data 0+, 19 =
//            data 0/5 shield, 20 = data 5-, 21 = data 5+, 22 = clock
//            shield, 23 = clock+, 24 = clock-. The member table is the
//            wire identity (line order), not the shell's contact numbers:
//            the shield contacts and the reserved contact stay out of the
//            interface. A single-link DVI-D leaves contacts 4, 5, 12, 13,
//            20 and 21 unconnected; the face carries the dual-link members
//            so one face serves both link types.

interface DVI(role)
{
    topology = "point to point"
    mode = ["full duplex"]  // TMDS is one-way; the DDC pair is bidirectional

    pins = [
        1 = TMDS_D2P @pair(d2) @class(digital), "TMDS data 2 positive"
        2 = TMDS_D2N @pair(d2) @class(digital), "TMDS data 2 negative"
        3 = TMDS_D1P @pair(d1) @class(digital), "TMDS data 1 positive"
        4 = TMDS_D1N @pair(d1) @class(digital), "TMDS data 1 negative"
        5 = TMDS_D0P @pair(d0) @class(digital), "TMDS data 0 positive"
        6 = TMDS_D0N @pair(d0) @class(digital), "TMDS data 0 negative"
        7 = TMDS_CKP @pair(clk) @class(digital), "TMDS clock positive"
        8 = TMDS_CKN @pair(clk) @class(digital), "TMDS clock negative"
        9 = TMDS_D3P @pair(d3) @class(digital), "TMDS data 3 positive"
        10 = TMDS_D3N @pair(d3) @class(digital), "TMDS data 3 negative"
        11 = TMDS_D4P @pair(d4) @class(digital), "TMDS data 4 positive"
        12 = TMDS_D4N @pair(d4) @class(digital), "TMDS data 4 negative"
        13 = TMDS_D5P @pair(d5) @class(digital), "TMDS data 5 positive"
        14 = TMDS_D5N @pair(d5) @class(digital), "TMDS data 5 negative"
        15 = DDC_SCL @drive(od) @class(digital), "DDC serial clock"
        16 = DDC_SDA @drive(od) @class(digital), "DDC serial data"
        17 = HPD @class(digital), "Hot plug detect"
    ]

    role SOURCE {
        name = "DVI Source"
        pins = [
            out 1 = TMDS_D2P @pair(d2) @class(digital), "TMDS data 2 positive"  // The source drives the stream
            out 2 = TMDS_D2N @pair(d2) @class(digital), "TMDS data 2 negative"
            out 3 = TMDS_D1P @pair(d1) @class(digital), "TMDS data 1 positive"
            out 4 = TMDS_D1N @pair(d1) @class(digital), "TMDS data 1 negative"
            out 5 = TMDS_D0P @pair(d0) @class(digital), "TMDS data 0 positive"
            out 6 = TMDS_D0N @pair(d0) @class(digital), "TMDS data 0 negative"
            out 7 = TMDS_CKP @pair(clk) @class(digital), "TMDS clock positive"
            out 8 = TMDS_CKN @pair(clk) @class(digital), "TMDS clock negative"
            out 9 = TMDS_D3P @pair(d3) @class(digital), "TMDS data 3 positive"
            out 10 = TMDS_D3N @pair(d3) @class(digital), "TMDS data 3 negative"
            out 11 = TMDS_D4P @pair(d4) @class(digital), "TMDS data 4 positive"
            out 12 = TMDS_D4N @pair(d4) @class(digital), "TMDS data 4 negative"
            out 13 = TMDS_D5P @pair(d5) @class(digital), "TMDS data 5 positive"
            out 14 = TMDS_D5N @pair(d5) @class(digital), "TMDS data 5 negative"
            out 15 = DDC_SCL @drive(od) @class(digital), "DDC serial clock"  // The source masters the DDC bus
            io 16 = DDC_SDA @drive(od) @class(digital), "DDC serial data"     // The source reads the sink EDID
            in 17 = HPD @class(digital), "Hot plug detect"                    // The sink asserts the plug
        ]
        peer = SINK(1)
    }
    role SINK {
        name = "DVI Sink"
        pins = [
            in 1 = TMDS_D2P @pair(d2) @class(digital), "TMDS data 2 positive"   // The sink receives the stream
            in 2 = TMDS_D2N @pair(d2) @class(digital), "TMDS data 2 negative"
            in 3 = TMDS_D1P @pair(d1) @class(digital), "TMDS data 1 positive"
            in 4 = TMDS_D1N @pair(d1) @class(digital), "TMDS data 1 negative"
            in 5 = TMDS_D0P @pair(d0) @class(digital), "TMDS data 0 positive"
            in 6 = TMDS_D0N @pair(d0) @class(digital), "TMDS data 0 negative"
            in 7 = TMDS_CKP @pair(clk) @class(digital), "TMDS clock positive"
            in 8 = TMDS_CKN @pair(clk) @class(digital), "TMDS clock negative"
            in 9 = TMDS_D3P @pair(d3) @class(digital), "TMDS data 3 positive"
            in 10 = TMDS_D3N @pair(d3) @class(digital), "TMDS data 3 negative"
            in 11 = TMDS_D4P @pair(d4) @class(digital), "TMDS data 4 positive"
            in 12 = TMDS_D4N @pair(d4) @class(digital), "TMDS data 4 negative"
            in 13 = TMDS_D5P @pair(d5) @class(digital), "TMDS data 5 positive"
            in 14 = TMDS_D5N @pair(d5) @class(digital), "TMDS data 5 negative"
            in 15 = DDC_SCL @drive(od) @class(digital), "DDC serial clock"
            io 16 = DDC_SDA @drive(od) @class(digital), "DDC serial data"       // The sink holds the EDID
            out 17 = HPD @class(digital), "Hot plug detect"                     // The sink drives the detect line
        ]
        peer = SOURCE(1)
    }
}
