# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// VGA - Video Graphics Array Analog Video Interface Standard Definition
// Core Rule: Three single-ended analog color lines (red / green / blue) and
//            two sync lines (horizontal / vertical) carry the raster from
//            the source to the display, and a DDC I2C pair (SCL / SDA)
//            carries the EDID channel back to the source. The five ground
//            contacts (one common, one per color, one for sync) are the
//            analog returns of the color and sync lines, not link members;
//            they stay bare rows on the seat. The DDC pair is a dedicated
//            member here, not a generic I2C instance - it runs on the +5V
//            rail of this connector and is open-drain with the seat's own
//            pullups.
// Device Definition: SOURCE = the video source (graphics card / display
//                    controller),
//                    SINK = the display (monitor / projector).
// Pin map: the standard DE-15 assignment - 1 = red, 2 = green, 3 = blue,
//            4 = reserved, 5 = ground, 6 = red return, 7 = green return,
//            8 = blue return, 9 = key, 10 = sync ground, 11 = reserved,
//            12 = DDC data, 13 = horizontal sync, 14 = vertical sync,
//            15 = DDC clock. The member table is the wire identity (line
//            order), not the shell's contact numbers.

interface VGA(role)
{
    topology = "point to point"
    mode = ["full duplex"]  // the color and sync lines are one-way; the DDC pair is bidirectional

    pins = [
        1 = RED @class(analog), "Red video"
        2 = GREEN @class(analog), "Green video"
        3 = BLUE @class(analog), "Blue video"
        4 = HSYNC @class(digital), "Horizontal sync"
        5 = VSYNC @class(digital), "Vertical sync"
        6 = DDC_SCL @drive(od) @class(digital), "DDC serial clock"
        7 = DDC_SDA @drive(od) @class(digital), "DDC serial data"
    ]

    role SOURCE {
        name = "VGA Source"
        pins = [
            out 1 = RED @class(analog), "Red video"          // The source drives the raster
            out 2 = GREEN @class(analog), "Green video"
            out 3 = BLUE @class(analog), "Blue video"
            out 4 = HSYNC @class(digital), "Horizontal sync"
            out 5 = VSYNC @class(digital), "Vertical sync"
            out 6 = DDC_SCL @drive(od) @class(digital), "DDC serial clock"  // The source masters the DDC bus
            io 7 = DDC_SDA @drive(od) @class(digital), "DDC serial data"    // The source reads the sink EDID
        ]
        peer = SINK(1)
    }
    role SINK {
        name = "VGA Sink"
        pins = [
            in 1 = RED @class(analog), "Red video"           // The sink samples the raster
            in 2 = GREEN @class(analog), "Green video"
            in 3 = BLUE @class(analog), "Blue video"
            in 4 = HSYNC @class(digital), "Horizontal sync"
            in 5 = VSYNC @class(digital), "Vertical sync"
            in 6 = DDC_SCL @drive(od) @class(digital), "DDC serial clock"
            io 7 = DDC_SDA @drive(od) @class(digital), "DDC serial data"    // The sink holds the EDID
        ]
        peer = SOURCE(1)
    }
}
