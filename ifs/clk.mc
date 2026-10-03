# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// CLK - Single-Ended Clock Interface Standard Definition
// Core Rule: One-wire unidirectional clock line; the ground reference is
//            shared through the power supply (DC interface), so the face
//            has no ground member. This family covers the single-ended
//            line (the differential clock pair is CLK.DIFF); the face is
//            genuinely unidirectional, unlike the XTAL circuit-identity
//            pair.
// Device Definition: TRANSMITTER = clock generator (active oscillator
//                    module output or clock driver),
//                    RECEIVER = clock consumer (SoC, FPGA, or MCU clock
//                    input).

interface CLK(role)
{
    topology = "point to point"
    mode = ["unidirectional"]

    pins = [
        1 = CLK @class(digital) // Single-ended clock
    ]

    role TRANSMITTER {  // Clock generator: active oscillator module or clock driver
        name = "CLK Transmitter"
        pins = [
            out 1 = CLK @class(digital) // The generator sources the line
        ]
        peer = RECEIVER
    }
    role RECEIVER {  // Clock consumer: SoC, FPGA, or MCU clock input
        name = "CLK Receiver"
        pins = [
            in 1 = CLK @class(digital) // The consumer reads the line
        ]
        peer = TRANSMITTER
    }
}
