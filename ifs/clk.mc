# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// CLK (Single-Ended Clock) Standard Definition
// Core Rule: One-wire unidirectional clock line
// 1 wire: the ground reference is shared through the power supply (DC
// interface), same as CLK.DIFF / ADC.SINGLE / UART.TTL (no ground member
// here).
// Family: CLK.DIFF (ifs/clkdiff.mc) covers the differential clock pair; CLK
// covers the single-ended line. Roles follow CLK.DIFF's Transmitter/Receiver
// naming -- this face is genuinely unidirectional, so the direction pair is
// the right pair here, unlike XTAL's circuit-identity pair (U200 §3).
// Applications: active oscillator module outputs (OSC), clock distribution,
// external clock input pins of SoCs / MCUs.

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
