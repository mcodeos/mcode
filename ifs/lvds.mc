# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// LVDS - Low-Voltage Differential Signaling Link Interface Standard Definition
// Core Rule: Generic low-voltage differential link: one clock pair plus
//            four data pairs; use a subset and leave the rest
//            unconnected. Every pair is positive-first (P/N naming
//            convention). The ground reference is shared through the
//            power supply (DC interface) — no ground member here.
// Device Definition: DRIVER = serializer/driver driving every pair,
//                    RECEIVER = deserializer sampling them.

interface LVDS(role)
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 0.5m
    maxspeed = [400Mbps@0.5m, 1.6Gbps@0.1m]  // per pair, distance-limited
    voltage = [1.8V, 2.5V, 3.3V]  // LVDS swing is ~350mV around this common-mode

    pins = [
        1 = CLK_P @pair(clk) @class(digital), "Differential clock positive"
        2 = CLK_N @pair(clk) @class(digital), "Differential clock negative"
        3 = D0_P @pair(d0) @class(digital), "Data pair 0 positive"
        4 = D0_N @pair(d0) @class(digital), "Data pair 0 negative"
        5 = D1_P @pair(d1) @class(digital), "Data pair 1 positive"
        6 = D1_N @pair(d1) @class(digital), "Data pair 1 negative"
        7 = D2_P @pair(d2) @class(digital), "Data pair 2 positive"
        8 = D2_N @pair(d2) @class(digital), "Data pair 2 negative"
        9 = D3_P @pair(d3) @class(digital), "Data pair 3 positive"
        10 = D3_N @pair(d3) @class(digital), "Data pair 3 negative"
    ]

    role DRIVER {
        name = "LVDS Driver"
        pins = [
            out 1 = CLK_P @pair(clk) @class(digital), "Differential clock positive"  // The serializer drives every pair
            out 2 = CLK_N @pair(clk) @class(digital), "Differential clock negative"
            out 3 = D0_P @pair(d0) @class(digital), "Data pair 0 positive"
            out 4 = D0_N @pair(d0) @class(digital), "Data pair 0 negative"
            out 5 = D1_P @pair(d1) @class(digital), "Data pair 1 positive"
            out 6 = D1_N @pair(d1) @class(digital), "Data pair 1 negative"
            out 7 = D2_P @pair(d2) @class(digital), "Data pair 2 positive"
            out 8 = D2_N @pair(d2) @class(digital), "Data pair 2 negative"
            out 9 = D3_P @pair(d3) @class(digital), "Data pair 3 positive"
            out 10 = D3_N @pair(d3) @class(digital), "Data pair 3 negative"
        ]
        peer = RECEIVER
    }
    role RECEIVER {
        name = "LVDS Receiver"
        pins = [
            in 1 = CLK_P @pair(clk) @class(digital), "Differential clock positive"   // The deserializer samples them
            in 2 = CLK_N @pair(clk) @class(digital), "Differential clock negative"
            in 3 = D0_P @pair(d0) @class(digital), "Data pair 0 positive"
            in 4 = D0_N @pair(d0) @class(digital), "Data pair 0 negative"
            in 5 = D1_P @pair(d1) @class(digital), "Data pair 1 positive"
            in 6 = D1_N @pair(d1) @class(digital), "Data pair 1 negative"
            in 7 = D2_P @pair(d2) @class(digital), "Data pair 2 positive"
            in 8 = D2_N @pair(d2) @class(digital), "Data pair 2 negative"
            in 9 = D3_P @pair(d3) @class(digital), "Data pair 3 positive"
            in 10 = D3_N @pair(d3) @class(digital), "Data pair 3 negative"
        ]
        peer = DRIVER
    }
}
