# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// CLK.DIFF - Differential Clock Pair Interface Standard Definition
// Core Rule: Two-wire differential clock for reference/system clocking;
//            the two rows tagged @sig.pair(clk) are the two legs of one pair
//            (P/N naming convention). The ground reference is shared
//            through the power supply (DC interface) — no ground member
//            here.
// Device Definition: TRANSMITTER = clock generator or oscillator,
//                    RECEIVER = clock consumer (SoC, FPGA).

interface CLK.DIFF(role)
{
    topology = "point to point"
    mode = ["unidirectional"]
    // Electrical contract data rides the recipe face: the differential
    // pair rides ELEC.CLK.DIFF -- input swing / common-mode /
    // max frequency / supply-domain keys; the single-ended clock face
    // rides CLK.ELEC. The distance row carries zero corpus statements
    // and is retired (rows without datasheet backing stay retired).

    pins = [
        1 = CLK_P @sig.pair(clk) @id.class(digital) // Positive differential clock
        2 = CLK_N @sig.pair(clk) @id.class(digital) // Negative differential clock
    ]

    role TRANSMITTER {  // CLK.DIFF Transmitter - Clock generator or oscillator
        name = "CLK.DIFF Transmitter"
        pins = [
            out 1 = CLK_P @sig.pair(clk) @id.class(digital) // The generator sources the pair
            out 2 = CLK_N @sig.pair(clk) @id.class(digital)
        ]
        peer = RECEIVER
    }
    role RECEIVER {  // CLK.DIFF Receiver - SoC, FPGA, or clock consumer
        name = "CLK.DIFF Receiver"
        pins = [
            in 1 = CLK_P @sig.pair(clk) @id.class(digital) // The consumer reads the pair
            in 2 = CLK_N @sig.pair(clk) @id.class(digital)
        ]
        peer = TRANSMITTER
    }
}
