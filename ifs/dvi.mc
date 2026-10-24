# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// DVI.D - Digital Visual Interface, digital-only variant Standard Definition
// Core Rule: TMDS differential pairs carry the video stream one way - data
//            2 / 1 / 0 plus the clock for a single link, data 3 / 4 / 5
//            joining them for a dual link. A DDC I2C pair carries the EDID
//            channel and a sink-driven hot-plug detect completes the link.
//            The shield contacts, the analog ground and the +5V feed are
//            not link members: the shields are in-shell members with no
//            far-end counterpart, and the power rides the DC face.
// Device Definition: SOURCE = the transmitter (the display output),
//                    SINK = the receiver (the display panel).
// Pin map: the 24-contact grid - 1 = data 2-, 2 = data 2+, 3 = data 2/4
//            shield, 4 = data 4-, 5 = data 4+, 6 = DDC clock, 7 = DDC
//            data, 8 = analog vertical sync, 9 = data 1-, 10 = data 1+,
//            11 = data 1/3 shield, 12 = data 3-, 13 = data 3+, 14 = +5V,
//            15 = ground, 16 = hot-plug detect, 17 = data 0-,
//            18 = data 0+, 19 = data 0/5 shield, 20 = data 5-,
//            21 = data 5+, 22 = clock shield, 23 = clock+, 24 = clock-.
//            The member table is the wire identity (the line order), not
//            the shell contact numbers. The variant contact sets: this
//            digital-only variant is 18+1 or 24+1 with a narrow ground
//            blade only, so the analog blade contacts are absent and the
//            analog vertical sync contact stays unconnected; the
//            analog-only variant is 12+4 and wires only the DDC pair, the
//            analog vertical sync, the ground and the hot-plug detect on
//            the grid, with the TMDS contacts left unwired; the
//            integrated variant is 18+5 or 24+5 with the full grid plus
//            the full analog blade. A single link leaves contacts 4, 5,
//            12, 13, 20 and 21 unconnected - the face carries the
//            dual-link members so one face serves both link types.

interface DVI.D(role)
{
    topology = "point to point"
    mode = ["full duplex"]  // TMDS is one-way; the DDC pair is bidirectional

    pins = [
        1 = TMDS_D2P @sig.pair(d2) @id.class(digital), "TMDS data 2 positive"
        2 = TMDS_D2N @sig.pair(d2) @id.class(digital), "TMDS data 2 negative"
        3 = TMDS_D1P @sig.pair(d1) @id.class(digital), "TMDS data 1 positive"
        4 = TMDS_D1N @sig.pair(d1) @id.class(digital), "TMDS data 1 negative"
        5 = TMDS_D0P @sig.pair(d0) @id.class(digital), "TMDS data 0 positive"
        6 = TMDS_D0N @sig.pair(d0) @id.class(digital), "TMDS data 0 negative"
        7 = TMDS_CKP @sig.pair(clk) @id.class(digital), "TMDS clock positive"
        8 = TMDS_CKN @sig.pair(clk) @id.class(digital), "TMDS clock negative"
        9 = TMDS_D3P @sig.pair(d3) @id.class(digital), "TMDS data 3 positive"
        10 = TMDS_D3N @sig.pair(d3) @id.class(digital), "TMDS data 3 negative"
        11 = TMDS_D4P @sig.pair(d4) @id.class(digital), "TMDS data 4 positive"
        12 = TMDS_D4N @sig.pair(d4) @id.class(digital), "TMDS data 4 negative"
        13 = TMDS_D5P @sig.pair(d5) @id.class(digital), "TMDS data 5 positive"
        14 = TMDS_D5N @sig.pair(d5) @id.class(digital), "TMDS data 5 negative"
        15 = DDC_SCL @sig.drive(od) @id.class(digital), "DDC serial clock"
        16 = DDC_SDA @sig.drive(od) @id.class(digital), "DDC serial data"
        17 = HPD @id.class(digital), "Hot plug detect"
    ]

    role SOURCE {
        name = "DVI Source"
        pins = [
            out 1 = TMDS_D2P @sig.pair(d2) @id.class(digital), "TMDS data 2 positive"  // the source drives the stream
            out 2 = TMDS_D2N @sig.pair(d2) @id.class(digital), "TMDS data 2 negative"
            out 3 = TMDS_D1P @sig.pair(d1) @id.class(digital), "TMDS data 1 positive"
            out 4 = TMDS_D1N @sig.pair(d1) @id.class(digital), "TMDS data 1 negative"
            out 5 = TMDS_D0P @sig.pair(d0) @id.class(digital), "TMDS data 0 positive"
            out 6 = TMDS_D0N @sig.pair(d0) @id.class(digital), "TMDS data 0 negative"
            out 7 = TMDS_CKP @sig.pair(clk) @id.class(digital), "TMDS clock positive"
            out 8 = TMDS_CKN @sig.pair(clk) @id.class(digital), "TMDS clock negative"
            out 9 = TMDS_D3P @sig.pair(d3) @id.class(digital), "TMDS data 3 positive"
            out 10 = TMDS_D3N @sig.pair(d3) @id.class(digital), "TMDS data 3 negative"
            out 11 = TMDS_D4P @sig.pair(d4) @id.class(digital), "TMDS data 4 positive"
            out 12 = TMDS_D4N @sig.pair(d4) @id.class(digital), "TMDS data 4 negative"
            out 13 = TMDS_D5P @sig.pair(d5) @id.class(digital), "TMDS data 5 positive"
            out 14 = TMDS_D5N @sig.pair(d5) @id.class(digital), "TMDS data 5 negative"
            out 15 = DDC_SCL @sig.drive(od) @id.class(digital), "DDC serial clock"  // the source masters the DDC bus
            io 16 = DDC_SDA @sig.drive(od) @id.class(digital), "DDC serial data"     // the source reads the sink EDID
            in 17 = HPD @id.class(digital), "Hot plug detect"                    // the sink asserts the plug
        ]
        peer = SINK(1)
    }
    role SINK {
        name = "DVI Sink"
        pins = [
            in 1 = TMDS_D2P @sig.pair(d2) @id.class(digital), "TMDS data 2 positive"   // the sink receives the stream
            in 2 = TMDS_D2N @sig.pair(d2) @id.class(digital), "TMDS data 2 negative"
            in 3 = TMDS_D1P @sig.pair(d1) @id.class(digital), "TMDS data 1 positive"
            in 4 = TMDS_D1N @sig.pair(d1) @id.class(digital), "TMDS data 1 negative"
            in 5 = TMDS_D0P @sig.pair(d0) @id.class(digital), "TMDS data 0 positive"
            in 6 = TMDS_D0N @sig.pair(d0) @id.class(digital), "TMDS data 0 negative"
            in 7 = TMDS_CKP @sig.pair(clk) @id.class(digital), "TMDS clock positive"
            in 8 = TMDS_CKN @sig.pair(clk) @id.class(digital), "TMDS clock negative"
            in 9 = TMDS_D3P @sig.pair(d3) @id.class(digital), "TMDS data 3 positive"
            in 10 = TMDS_D3N @sig.pair(d3) @id.class(digital), "TMDS data 3 negative"
            in 11 = TMDS_D4P @sig.pair(d4) @id.class(digital), "TMDS data 4 positive"
            in 12 = TMDS_D4N @sig.pair(d4) @id.class(digital), "TMDS data 4 negative"
            in 13 = TMDS_D5P @sig.pair(d5) @id.class(digital), "TMDS data 5 positive"
            in 14 = TMDS_D5N @sig.pair(d5) @id.class(digital), "TMDS data 5 negative"
            in 15 = DDC_SCL @sig.drive(od) @id.class(digital), "DDC serial clock"
            io 16 = DDC_SDA @sig.drive(od) @id.class(digital), "DDC serial data"       // the sink holds the EDID
            out 17 = HPD @id.class(digital), "Hot plug detect"                     // the sink drives the detect line
        ]
        peer = SOURCE(1)
    }
}

// DVI.A - Digital Visual Interface, analog-only variant Standard Definition
// Core Rule: the analog raster (red / green / blue plus the two sync
//            lines) rides the flat blade while the DDC pair and the
//            hot-plug detect ride the grid; the TMDS contacts are not
//            wired on this variant, so no digital member appears. The
//            analog ground is a shell member, not an interface member.
// Device Definition: SOURCE = the video source, SINK = the display.
// Note: the blade contacts carry C1 = analog red, C2 = analog green,
//       C3 = analog blue, C4 = analog horizontal sync, C5 = analog
//       ground; the grid carries the DDC pair, the analog vertical sync,
//       the ground and the hot-plug detect.

interface DVI.A(role)
{
    topology = "point to point"
    mode = ["full duplex"]  // the color and sync lines are one-way; the DDC pair is bidirectional

    pins = [
        1 = RED @id.class(analog), "Analog red video"
        2 = GREEN @id.class(analog), "Analog green video"
        3 = BLUE @id.class(analog), "Analog blue video"
        4 = HSYNC @id.class(digital), "Horizontal sync"
        5 = VSYNC @id.class(digital), "Vertical sync"
        6 = DDC_SCL @sig.drive(od) @id.class(digital), "DDC serial clock"
        7 = DDC_SDA @sig.drive(od) @id.class(digital), "DDC serial data"
        8 = HPD @id.class(digital), "Hot plug detect"
    ]

    role SOURCE {
        name = "DVI Analog Source"
        pins = [
            out 1 = RED @id.class(analog), "Analog red video"        // the source drives the raster
            out 2 = GREEN @id.class(analog), "Analog green video"
            out 3 = BLUE @id.class(analog), "Analog blue video"
            out 4 = HSYNC @id.class(digital), "Horizontal sync"
            out 5 = VSYNC @id.class(digital), "Vertical sync"
            out 6 = DDC_SCL @sig.drive(od) @id.class(digital), "DDC serial clock"  // the source masters the DDC bus
            io 7 = DDC_SDA @sig.drive(od) @id.class(digital), "DDC serial data"    // the source reads the sink EDID
            in 8 = HPD @id.class(digital), "Hot plug detect"                    // the sink asserts the plug
        ]
        peer = SINK(1)
    }
    role SINK {
        name = "DVI Analog Sink"
        pins = [
            in 1 = RED @id.class(analog), "Analog red video"         // the sink samples the raster
            in 2 = GREEN @id.class(analog), "Analog green video"
            in 3 = BLUE @id.class(analog), "Analog blue video"
            in 4 = HSYNC @id.class(digital), "Horizontal sync"
            in 5 = VSYNC @id.class(digital), "Vertical sync"
            in 6 = DDC_SCL @sig.drive(od) @id.class(digital), "DDC serial clock"
            io 7 = DDC_SDA @sig.drive(od) @id.class(digital), "DDC serial data"    // the sink holds the EDID
            out 8 = HPD @id.class(digital), "Hot plug detect"                  // the sink drives the detect line
        ]
        peer = SOURCE(1)
    }
}

// DVI.I - Digital Visual Interface, integrated variant Standard Definition
// Core Rule: the digital grid and the analog blade in one face - the
//            digital-only members plus the analog members, the same
//            member law as the two source variants, spelled out again
//            because the interface layer has no inheritance. The analog
//            ground is a shell member, not an interface member.
// Device Definition: SOURCE = the video source, SINK = the display.
// Note: the blade contacts carry C1 = analog red, C2 = analog green,
//       C3 = analog blue, C4 = analog horizontal sync, C5 = analog
//       ground.

interface DVI.I(role)
{
    topology = "point to point"
    mode = ["full duplex"]  // TMDS and the color lines are one-way; the DDC pair is bidirectional

    pins = [
        1 = TMDS_D2P @sig.pair(d2) @id.class(digital), "TMDS data 2 positive"
        2 = TMDS_D2N @sig.pair(d2) @id.class(digital), "TMDS data 2 negative"
        3 = TMDS_D1P @sig.pair(d1) @id.class(digital), "TMDS data 1 positive"
        4 = TMDS_D1N @sig.pair(d1) @id.class(digital), "TMDS data 1 negative"
        5 = TMDS_D0P @sig.pair(d0) @id.class(digital), "TMDS data 0 positive"
        6 = TMDS_D0N @sig.pair(d0) @id.class(digital), "TMDS data 0 negative"
        7 = TMDS_CKP @sig.pair(clk) @id.class(digital), "TMDS clock positive"
        8 = TMDS_CKN @sig.pair(clk) @id.class(digital), "TMDS clock negative"
        9 = TMDS_D3P @sig.pair(d3) @id.class(digital), "TMDS data 3 positive"
        10 = TMDS_D3N @sig.pair(d3) @id.class(digital), "TMDS data 3 negative"
        11 = TMDS_D4P @sig.pair(d4) @id.class(digital), "TMDS data 4 positive"
        12 = TMDS_D4N @sig.pair(d4) @id.class(digital), "TMDS data 4 negative"
        13 = TMDS_D5P @sig.pair(d5) @id.class(digital), "TMDS data 5 positive"
        14 = TMDS_D5N @sig.pair(d5) @id.class(digital), "TMDS data 5 negative"
        15 = DDC_SCL @sig.drive(od) @id.class(digital), "DDC serial clock"
        16 = DDC_SDA @sig.drive(od) @id.class(digital), "DDC serial data"
        17 = HPD @id.class(digital), "Hot plug detect"
        18 = RED @id.class(analog), "Analog red video"
        19 = GREEN @id.class(analog), "Analog green video"
        20 = BLUE @id.class(analog), "Analog blue video"
        21 = HSYNC @id.class(digital), "Horizontal sync"
        22 = VSYNC @id.class(digital), "Vertical sync"
    ]

    role SOURCE {
        name = "DVI Integrated Source"
        pins = [
            out 1 = TMDS_D2P @sig.pair(d2) @id.class(digital), "TMDS data 2 positive"  // the source drives the stream
            out 2 = TMDS_D2N @sig.pair(d2) @id.class(digital), "TMDS data 2 negative"
            out 3 = TMDS_D1P @sig.pair(d1) @id.class(digital), "TMDS data 1 positive"
            out 4 = TMDS_D1N @sig.pair(d1) @id.class(digital), "TMDS data 1 negative"
            out 5 = TMDS_D0P @sig.pair(d0) @id.class(digital), "TMDS data 0 positive"
            out 6 = TMDS_D0N @sig.pair(d0) @id.class(digital), "TMDS data 0 negative"
            out 7 = TMDS_CKP @sig.pair(clk) @id.class(digital), "TMDS clock positive"
            out 8 = TMDS_CKN @sig.pair(clk) @id.class(digital), "TMDS clock negative"
            out 9 = TMDS_D3P @sig.pair(d3) @id.class(digital), "TMDS data 3 positive"
            out 10 = TMDS_D3N @sig.pair(d3) @id.class(digital), "TMDS data 3 negative"
            out 11 = TMDS_D4P @sig.pair(d4) @id.class(digital), "TMDS data 4 positive"
            out 12 = TMDS_D4N @sig.pair(d4) @id.class(digital), "TMDS data 4 negative"
            out 13 = TMDS_D5P @sig.pair(d5) @id.class(digital), "TMDS data 5 positive"
            out 14 = TMDS_D5N @sig.pair(d5) @id.class(digital), "TMDS data 5 negative"
            out 15 = DDC_SCL @sig.drive(od) @id.class(digital), "DDC serial clock"  // the source masters the DDC bus
            io 16 = DDC_SDA @sig.drive(od) @id.class(digital), "DDC serial data"     // the source reads the sink EDID
            in 17 = HPD @id.class(digital), "Hot plug detect"                    // the sink asserts the plug
            out 18 = RED @id.class(analog), "Analog red video"                  // the source drives the raster
            out 19 = GREEN @id.class(analog), "Analog green video"
            out 20 = BLUE @id.class(analog), "Analog blue video"
            out 21 = HSYNC @id.class(digital), "Horizontal sync"
            out 22 = VSYNC @id.class(digital), "Vertical sync"
        ]
        peer = SINK(1)
    }
    role SINK {
        name = "DVI Integrated Sink"
        pins = [
            in 1 = TMDS_D2P @sig.pair(d2) @id.class(digital), "TMDS data 2 positive"   // the sink receives the stream
            in 2 = TMDS_D2N @sig.pair(d2) @id.class(digital), "TMDS data 2 negative"
            in 3 = TMDS_D1P @sig.pair(d1) @id.class(digital), "TMDS data 1 positive"
            in 4 = TMDS_D1N @sig.pair(d1) @id.class(digital), "TMDS data 1 negative"
            in 5 = TMDS_D0P @sig.pair(d0) @id.class(digital), "TMDS data 0 positive"
            in 6 = TMDS_D0N @sig.pair(d0) @id.class(digital), "TMDS data 0 negative"
            in 7 = TMDS_CKP @sig.pair(clk) @id.class(digital), "TMDS clock positive"
            in 8 = TMDS_CKN @sig.pair(clk) @id.class(digital), "TMDS clock negative"
            in 9 = TMDS_D3P @sig.pair(d3) @id.class(digital), "TMDS data 3 positive"
            in 10 = TMDS_D3N @sig.pair(d3) @id.class(digital), "TMDS data 3 negative"
            in 11 = TMDS_D4P @sig.pair(d4) @id.class(digital), "TMDS data 4 positive"
            in 12 = TMDS_D4N @sig.pair(d4) @id.class(digital), "TMDS data 4 negative"
            in 13 = TMDS_D5P @sig.pair(d5) @id.class(digital), "TMDS data 5 positive"
            in 14 = TMDS_D5N @sig.pair(d5) @id.class(digital), "TMDS data 5 negative"
            in 15 = DDC_SCL @sig.drive(od) @id.class(digital), "DDC serial clock"
            io 16 = DDC_SDA @sig.drive(od) @id.class(digital), "DDC serial data"       // the sink holds the EDID
            out 17 = HPD @id.class(digital), "Hot plug detect"                     // the sink drives the detect line
            in 18 = RED @id.class(analog), "Analog red video"                      // the sink samples the raster
            in 19 = GREEN @id.class(analog), "Analog green video"
            in 20 = BLUE @id.class(analog), "Analog blue video"
            in 21 = HSYNC @id.class(digital), "Horizontal sync"
            in 22 = VSYNC @id.class(digital), "Vertical sync"
        ]
        peer = SOURCE(1)
    }
}
