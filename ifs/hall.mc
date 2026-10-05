# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// HALL - Three-Wire Position Sensor Interface Standard Definition
// Core Rule: Three digital position lines from a hall or contact-based
//            position sensor (three switching elements at spaced mechanical
//            angles); the receiver decodes shaft angle from the 3-bit
//            Gray-like sequence the lines walk per electrical revolution.
//            Sensor power is a supply pin, not a member of this face.
// Device Definition: TRANSMITTER = the sensor (drives the three lines),
//                    RECEIVER = the position decoder.

interface HALL(role)
{
    topology = "point to point"

    pins = [
        1 = H1 @class(digital), "Position line 1"
        2 = H2 @class(digital), "Position line 2"
        3 = H3 @class(digital), "Position line 3"
    ]

    role TRANSMITTER {
        name = "HALL Sensor"
        pins = [
            out 1 = H1 @class(digital), "Position line 1"
            out 2 = H2 @class(digital), "Position line 2"
            out 3 = H3 @class(digital), "Position line 3"
        ]
        peer = RECEIVER
    }

    role RECEIVER {
        name = "HALL Decoder"
        pins = [
            in 1 = H1 @class(digital), "Position line 1"
            in 2 = H2 @class(digital), "Position line 2"
            in 3 = H3 @class(digital), "Position line 3"
        ]
        peer = TRANSMITTER
    }
}
