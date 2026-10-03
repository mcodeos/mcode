# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// CLK.DIFF - Differential Clock Pair Interface Standard Definition
// Core Rule: Two-wire differential clock for reference/system clocking;
//            the two rows tagged @pair(clk) are the two legs of one pair
//            (P/N naming convention). The ground reference is shared
//            through the power supply (DC interface) — no ground member
//            here.
// Device Definition: TRANSMITTER = clock generator or oscillator,
//                    RECEIVER = clock consumer (SoC, FPGA).

interface CLK.DIFF(role)
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 0.5m
    maxspeed = [200MHz@0.5m, 800MHz@0.1m]
    voltage = [1.8V, 2.5V, 3.3V]

    pins = [
        1 = CLK_P @pair(clk) @class(digital) // Positive differential clock
        2 = CLK_N @pair(clk) @class(digital) // Negative differential clock
    ]

    role TRANSMITTER {  // CLK.DIFF Transmitter - Clock generator or oscillator
        name = "CLK.DIFF Transmitter"
        pins = [
            out 1 = CLK_P @pair(clk) @class(digital) // The generator sources the pair
            out 2 = CLK_N @pair(clk) @class(digital)
        ]
        peer = RECEIVER
    }
    role RECEIVER {  // CLK.DIFF Receiver - SoC, FPGA, or clock consumer
        name = "CLK.DIFF Receiver"
        pins = [
            in 1 = CLK_P @pair(clk) @class(digital) // The consumer reads the pair
            in 2 = CLK_N @pair(clk) @class(digital)
        ]
        peer = TRANSMITTER
    }
}
