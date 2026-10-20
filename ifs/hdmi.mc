# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// HDMI - High-Definition Multimedia Interface Standard Definition
// Core Rule: Three TMDS differential data pairs (data 2 / 1 / 0) plus a TMDS
//            clock pair carry the video and audio stream one way; a
//            one-wire CEC line, a DDC I2C pair (SCL / SDA) for the EDID
//            and HDCP control channel, and a sink-driven hot-plug detect
//            complete the link. The +5V feed and its return ride the DC
//            face, not this one.
// Device Definition: SOURCE = the transmitter (GPU / SoC display output),
//                    SINK = the receiver (display panel).
// Pin map: the standard HDMI Type-A assignment - 1 = data 2+, 2 = data 2
//            shield, 3 = data 2-, 4 = data 1+, 5 = data 1 shield,
//            6 = data 1-, 7 = data 0+, 8 = data 0 shield, 9 = data 0-,
//            10 = clock+, 11 = clock shield, 12 = clock-, 13 = CEC,
//            14 = utility, 15 = DDC SCL, 16 = DDC SDA, 17 = DDC/CEC
//            ground, 18 = +5V, 19 = HPD. The member table is the wire
//            identity (line order), not the shell's contact numbers: the
//            three shield contacts and the utility contact are in-shell
//            members with no counterpart on the far end, so they stay out
//            of the interface. The DDC pair is a dedicated member here,
//            not a generic I2C instance - it runs on the +5V rail of this
//            link and is open-drain with the link's own pullups.

interface HDMI(role)
{
    topology = "point to point"
    mode = ["full duplex"]  // TMDS is one-way; CEC and DDC are bidirectional

    pins = [
        1 = TMDS_D2P @pair(d2) @class(digital), "TMDS data 2 positive"
        2 = TMDS_D2N @pair(d2) @class(digital), "TMDS data 2 negative"
        3 = TMDS_D1P @pair(d1) @class(digital), "TMDS data 1 positive"
        4 = TMDS_D1N @pair(d1) @class(digital), "TMDS data 1 negative"
        5 = TMDS_D0P @pair(d0) @class(digital), "TMDS data 0 positive"
        6 = TMDS_D0N @pair(d0) @class(digital), "TMDS data 0 negative"
        7 = TMDS_CKP @pair(clk) @class(digital), "TMDS clock positive"
        8 = TMDS_CKN @pair(clk) @class(digital), "TMDS clock negative"
        9 = CEC @drive(od) @class(digital), "Consumer electronics control"
        10 = DDC_SCL @drive(od) @class(digital), "DDC serial clock"
        11 = DDC_SDA @drive(od) @class(digital), "DDC serial data"
        12 = HPD @class(digital), "Hot plug detect"
    ]

    role SOURCE {
        name = "HDMI Source"
        pins = [
            out 1 = TMDS_D2P @pair(d2) @class(digital), "TMDS data 2 positive"  // The source drives the stream
            out 2 = TMDS_D2N @pair(d2) @class(digital), "TMDS data 2 negative"
            out 3 = TMDS_D1P @pair(d1) @class(digital), "TMDS data 1 positive"
            out 4 = TMDS_D1N @pair(d1) @class(digital), "TMDS data 1 negative"
            out 5 = TMDS_D0P @pair(d0) @class(digital), "TMDS data 0 positive"
            out 6 = TMDS_D0N @pair(d0) @class(digital), "TMDS data 0 negative"
            out 7 = TMDS_CKP @pair(clk) @class(digital), "TMDS clock positive"
            out 8 = TMDS_CKN @pair(clk) @class(digital), "TMDS clock negative"
            io 9 = CEC @drive(od) @class(digital), "Consumer electronics control"  // Either side may initiate
            io 10 = DDC_SCL @drive(od) @class(digital), "DDC serial clock"   // The source reads the sink EDID
            io 11 = DDC_SDA @drive(od) @class(digital), "DDC serial data"
            in 12 = HPD @class(digital), "Hot plug detect"                  // The sink asserts the plug
        ]
        peer = SINK(1)
    }
    role SINK {
        name = "HDMI Sink"
        pins = [
            in 1 = TMDS_D2P @pair(d2) @class(digital), "TMDS data 2 positive"   // The sink receives the stream
            in 2 = TMDS_D2N @pair(d2) @class(digital), "TMDS data 2 negative"
            in 3 = TMDS_D1P @pair(d1) @class(digital), "TMDS data 1 positive"
            in 4 = TMDS_D1N @pair(d1) @class(digital), "TMDS data 1 negative"
            in 5 = TMDS_D0P @pair(d0) @class(digital), "TMDS data 0 positive"
            in 6 = TMDS_D0N @pair(d0) @class(digital), "TMDS data 0 negative"
            in 7 = TMDS_CKP @pair(clk) @class(digital), "TMDS clock positive"
            in 8 = TMDS_CKN @pair(clk) @class(digital), "TMDS clock negative"
            io 9 = CEC @drive(od) @class(digital), "Consumer electronics control"
            io 10 = DDC_SCL @drive(od) @class(digital), "DDC serial clock"    // The sink holds the EDID
            io 11 = DDC_SDA @drive(od) @class(digital), "DDC serial data"
            out 12 = HPD @class(digital), "Hot plug detect"                  // The sink drives the detect line
        ]
        peer = SOURCE(1)
    }
}
