# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// DP - DisplayPort Main Link Interface Standard Definition
// Core Rule: Packetized video/audio main link of 1 / 2 / 4 AC-coupled
//            differential lanes (2.7 / 5.4 / 8.1 Gbps per lane) plus a
//            bidirectional half-duplex auxiliary (AUX) pair and a
//            single-ended, sink-driven hot-plug detect (HPD). All pairs
//            are positive-first (P/N naming convention).
// Device Definition: SOURCE = GPU / SoC display output,
//                    SINK = display panel receiver.

interface DP(role)
{
    topology = "point to point"
    mode = ["full duplex"]  // main link unidirectional, AUX bidirectional
    maxdistance = 3m
    maxspeed = [2.7Gbps@2m, 5.4Gbps@2m, 8.1Gbps@1m]  // RBR / HBR / HBR2+ per lane
    voltage = [1.8V, 3.3V]

    pins = [
        1 = ML0_P @pair(ml0) @class(digital), "Main link lane 0 positive"
        2 = ML0_N @pair(ml0) @class(digital), "Main link lane 0 negative"
        3 = ML1_P @pair(ml1) @class(digital), "Main link lane 1 positive"
        4 = ML1_N @pair(ml1) @class(digital), "Main link lane 1 negative"
        5 = ML2_P @pair(ml2) @class(digital), "Main link lane 2 positive"
        6 = ML2_N @pair(ml2) @class(digital), "Main link lane 2 negative"
        7 = ML3_P @pair(ml3) @class(digital), "Main link lane 3 positive"
        8 = ML3_N @pair(ml3) @class(digital), "Main link lane 3 negative"
        9 = AUX_P @pair(aux) @class(digital), "Auxiliary channel positive"
        10 = AUX_N @pair(aux) @class(digital), "Auxiliary channel negative"
        11 = HPD @class(digital), "Hot plug detect"
    ]

    role SOURCE {
        name = "DP Source"
        pins = [
            out 1 = ML0_P @pair(ml0) @class(digital), "Main link lane 0 positive"  // The source drives the main link
            out 2 = ML0_N @pair(ml0) @class(digital), "Main link lane 0 negative"
            out 3 = ML1_P @pair(ml1) @class(digital), "Main link lane 1 positive"
            out 4 = ML1_N @pair(ml1) @class(digital), "Main link lane 1 negative"
            out 5 = ML2_P @pair(ml2) @class(digital), "Main link lane 2 positive"
            out 6 = ML2_N @pair(ml2) @class(digital), "Main link lane 2 negative"
            out 7 = ML3_P @pair(ml3) @class(digital), "Main link lane 3 positive"
            out 8 = ML3_N @pair(ml3) @class(digital), "Main link lane 3 negative"
            io 9 = AUX_P @pair(aux) @class(digital), "Auxiliary channel positive"   // AUX is bidirectional half duplex
            io 10 = AUX_N @pair(aux) @class(digital), "Auxiliary channel negative"
            in 11 = HPD @class(digital), "Hot plug detect"               // The sink drives HPD
        ]
        peer = SINK(1)
    }
    role SINK {
        name = "DP Sink"
        pins = [
            in 1 = ML0_P @pair(ml0) @class(digital), "Main link lane 0 positive"    // The sink receives the main link
            in 2 = ML0_N @pair(ml0) @class(digital), "Main link lane 0 negative"
            in 3 = ML1_P @pair(ml1) @class(digital), "Main link lane 1 positive"
            in 4 = ML1_N @pair(ml1) @class(digital), "Main link lane 1 negative"
            in 5 = ML2_P @pair(ml2) @class(digital), "Main link lane 2 positive"
            in 6 = ML2_N @pair(ml2) @class(digital), "Main link lane 2 negative"
            in 7 = ML3_P @pair(ml3) @class(digital), "Main link lane 3 positive"
            in 8 = ML3_N @pair(ml3) @class(digital), "Main link lane 3 negative"
            io 9 = AUX_P @pair(aux) @class(digital), "Auxiliary channel positive"   // AUX is bidirectional half duplex
            io 10 = AUX_N @pair(aux) @class(digital), "Auxiliary channel negative"
            out 11 = HPD @class(digital), "Hot plug detect"              // The sink asserts hot plug
        ]
        peer = SOURCE(1)
    }
}
