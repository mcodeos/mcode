# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// CIF - Parallel Camera Interface Standard Definition
// Core Rule: Unidirectional parallel video capture: the camera streams
//            pixel data on a data bus qualified by a pixel clock and two
//            sync lines (frame/vertical, line/horizontal); the receiver
//            latches data on the clock edge and uses the syncs to find
//            frame and line starts. Data width is fixed by the face
//            (16 lines); narrower sensors leave the high lines unconnected.
// Device Definition: TRANSMITTER = the camera (drives clock, syncs, data),
//                    RECEIVER = the image processor (latches on clock).

interface CIF(role)
{
    topology = "point to point"
    mode = ["half duplex"]

    pins = [
        1 = CLK @class(digital), "Pixel clock (camera drives)"
        2 = VSNC @class(digital), "Frame sync (vertical)"
        3 = HSNC @class(digital), "Line sync (horizontal)"
        4 = D0 @class(digital), "Pixel data bit 0"
        5 = D1 @class(digital), "Pixel data bit 1"
        6 = D2 @class(digital), "Pixel data bit 2"
        7 = D3 @class(digital), "Pixel data bit 3"
        8 = D4 @class(digital), "Pixel data bit 4"
        9 = D5 @class(digital), "Pixel data bit 5"
        10 = D6 @class(digital), "Pixel data bit 6"
        11 = D7 @class(digital), "Pixel data bit 7"
        12 = D8 @class(digital), "Pixel data bit 8"
        13 = D9 @class(digital), "Pixel data bit 9"
        14 = D10 @class(digital), "Pixel data bit 10"
        15 = D11 @class(digital), "Pixel data bit 11"
        16 = D12 @class(digital), "Pixel data bit 12"
        17 = D13 @class(digital), "Pixel data bit 13"
        18 = D14 @class(digital), "Pixel data bit 14"
        19 = D15 @class(digital), "Pixel data bit 15"
    ]

    role TRANSMITTER {
        name = "CIF Camera"
        pins = [
            out 1 = CLK @class(digital), "Pixel clock"
            out 2 = VSNC @class(digital), "Frame sync (vertical)"
            out 3 = HSNC @class(digital), "Line sync (horizontal)"
            out 4 = D0 @class(digital), "Pixel data bit 0"
            out 5 = D1 @class(digital), "Pixel data bit 1"
            out 6 = D2 @class(digital), "Pixel data bit 2"
            out 7 = D3 @class(digital), "Pixel data bit 3"
            out 8 = D4 @class(digital), "Pixel data bit 4"
            out 9 = D5 @class(digital), "Pixel data bit 5"
            out 10 = D6 @class(digital), "Pixel data bit 6"
            out 11 = D7 @class(digital), "Pixel data bit 7"
            out 12 = D8 @class(digital), "Pixel data bit 8"
            out 13 = D9 @class(digital), "Pixel data bit 9"
            out 14 = D10 @class(digital), "Pixel data bit 10"
            out 15 = D11 @class(digital), "Pixel data bit 11"
            out 16 = D12 @class(digital), "Pixel data bit 12"
            out 17 = D13 @class(digital), "Pixel data bit 13"
            out 18 = D14 @class(digital), "Pixel data bit 14"
            out 19 = D15 @class(digital), "Pixel data bit 15"
        ]
        peer = RECEIVER
    }

    role RECEIVER {
        name = "CIF Image Processor"
        pins = [
            in 1 = CLK @class(digital), "Pixel clock"
            in 2 = VSNC @class(digital), "Frame sync (vertical)"
            in 3 = HSNC @class(digital), "Line sync (horizontal)"
            in 4 = D0 @class(digital), "Pixel data bit 0"
            in 5 = D1 @class(digital), "Pixel data bit 1"
            in 6 = D2 @class(digital), "Pixel data bit 2"
            in 7 = D3 @class(digital), "Pixel data bit 3"
            in 8 = D4 @class(digital), "Pixel data bit 4"
            in 9 = D5 @class(digital), "Pixel data bit 5"
            in 10 = D6 @class(digital), "Pixel data bit 6"
            in 11 = D7 @class(digital), "Pixel data bit 7"
            in 12 = D8 @class(digital), "Pixel data bit 8"
            in 13 = D9 @class(digital), "Pixel data bit 9"
            in 14 = D10 @class(digital), "Pixel data bit 10"
            in 15 = D11 @class(digital), "Pixel data bit 11"
            in 16 = D12 @class(digital), "Pixel data bit 12"
            in 17 = D13 @class(digital), "Pixel data bit 13"
            in 18 = D14 @class(digital), "Pixel data bit 14"
            in 19 = D15 @class(digital), "Pixel data bit 15"
        ]
        peer = TRANSMITTER
    }
}
