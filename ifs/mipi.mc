# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Both faces share the D-PHY shape: one differential clock pair plus data
// pairs; 1 / 2 / 4 data lanes are used and the rest stay unconnected.
// Every pair is positive-first (P/N convention, same as CLK.DIFF); the
// ground reference rides the power supply (DC interface), no ground member.

// MIPI.DSI - Display Serial Interface (D-PHY) Standard Definition
// Core Rule: One differential clock pair plus 1 / 2 / 4 data lanes from
//            host to display (video mode; command-mode replies ride the
//            same lanes inbound).
// Device Definition: HOST = SoC display controller driving every lane,
//                    DISPLAY = display panel receiving.

interface MIPI.DSI(role)
{
    topology = "point to point"
    mode = ["unidirectional"]  // video mode; command mode replies ride DSI read packets
    maxdistance = 0.3m  // PCB traces / short flex
    maxspeed = [500Mbps@0.3m, 1.5Gbps@0.1m]  // per lane
    voltage = [1.8V, 1.2V]  // D-PHY supply domain

    pins = [
        1 = CLK_P @class(digital), "D-PHY clock pair positive"
        2 = CLK_N @class(digital), "D-PHY clock pair negative"
        3 = D0_P @class(digital), "Data lane 0 positive"
        4 = D0_N @class(digital), "Data lane 0 negative"
        5 = D1_P @class(digital), "Data lane 1 positive"
        6 = D1_N @class(digital), "Data lane 1 negative"
        7 = D2_P @class(digital), "Data lane 2 positive"
        8 = D2_N @class(digital), "Data lane 2 negative"
        9 = D3_P @class(digital), "Data lane 3 positive"
        10 = D3_N @class(digital), "Data lane 3 negative"
    ]

    role HOST {
        name = "DSI Host (SoC display controller)"
        pins = [
            out 1 = CLK_P @class(digital), "D-PHY clock pair positive"  // The host drives every lane
            out 2 = CLK_N @class(digital), "D-PHY clock pair negative"  // (video mode; command-mode replies
            out 3 = D0_P @class(digital), "Data lane 0 positive"        // ride the same lanes inbound)
            out 4 = D0_N @class(digital), "Data lane 0 negative"
            out 5 = D1_P @class(digital), "Data lane 1 positive"
            out 6 = D1_N @class(digital), "Data lane 1 negative"
            out 7 = D2_P @class(digital), "Data lane 2 positive"
            out 8 = D2_N @class(digital), "Data lane 2 negative"
            out 9 = D3_P @class(digital), "Data lane 3 positive"
            out 10 = D3_N @class(digital), "Data lane 3 negative"
        ]
        peer = DISPLAY(1)
    }
    role DISPLAY {
        name = "DSI Peripheral (display panel)"
        pins = [
            in 1 = CLK_P @class(digital), "D-PHY clock pair positive"   // The panel receives
            in 2 = CLK_N @class(digital), "D-PHY clock pair negative"
            in 3 = D0_P @class(digital), "Data lane 0 positive"
            in 4 = D0_N @class(digital), "Data lane 0 negative"
            in 5 = D1_P @class(digital), "Data lane 1 positive"
            in 6 = D1_N @class(digital), "Data lane 1 negative"
            in 7 = D2_P @class(digital), "Data lane 2 positive"
            in 8 = D2_N @class(digital), "Data lane 2 negative"
            in 9 = D3_P @class(digital), "Data lane 3 positive"
            in 10 = D3_N @class(digital), "Data lane 3 negative"
        ]
        peer = HOST(1)
    }
}

// MIPI.CSI - Camera Serial Interface (D-PHY) Standard Definition
// Core Rule: One differential clock pair plus 1 / 2 / 4 data lanes from
//            camera sensor to host ISP, the same D-PHY shape as MIPI.DSI.
// Device Definition: SENSOR = camera sensor driving every lane,
//                    HOST = SoC ISP sampling them.

interface MIPI.CSI(role)
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 0.3m
    maxspeed = [500Mbps@0.3m, 2.5Gbps@0.1m]  // per lane
    voltage = [1.8V, 1.2V]

    pins = [
        1 = CLK_P @class(digital), "D-PHY clock pair positive"
        2 = CLK_N @class(digital), "D-PHY clock pair negative"
        3 = D0_P @class(digital), "Data lane 0 positive"
        4 = D0_N @class(digital), "Data lane 0 negative"
        5 = D1_P @class(digital), "Data lane 1 positive"
        6 = D1_N @class(digital), "Data lane 1 negative"
        7 = D2_P @class(digital), "Data lane 2 positive"
        8 = D2_N @class(digital), "Data lane 2 negative"
        9 = D3_P @class(digital), "Data lane 3 positive"
        10 = D3_N @class(digital), "Data lane 3 negative"
    ]

    role SENSOR {
        name = "CSI Transmitter (camera sensor)"
        pins = [
            out 1 = CLK_P @class(digital), "D-PHY clock pair positive"  // The sensor drives every lane
            out 2 = CLK_N @class(digital), "D-PHY clock pair negative"
            out 3 = D0_P @class(digital), "Data lane 0 positive"
            out 4 = D0_N @class(digital), "Data lane 0 negative"
            out 5 = D1_P @class(digital), "Data lane 1 positive"
            out 6 = D1_N @class(digital), "Data lane 1 negative"
            out 7 = D2_P @class(digital), "Data lane 2 positive"
            out 8 = D2_N @class(digital), "Data lane 2 negative"
            out 9 = D3_P @class(digital), "Data lane 3 positive"
            out 10 = D3_N @class(digital), "Data lane 3 negative"
        ]
        peer = HOST(1)
    }
    role HOST {
        name = "CSI Receiver (SoC ISP)"
        pins = [
            in 1 = CLK_P @class(digital), "D-PHY clock pair positive"   // The ISP samples them
            in 2 = CLK_N @class(digital), "D-PHY clock pair negative"
            in 3 = D0_P @class(digital), "Data lane 0 positive"
            in 4 = D0_N @class(digital), "Data lane 0 negative"
            in 5 = D1_P @class(digital), "Data lane 1 positive"
            in 6 = D1_N @class(digital), "Data lane 1 negative"
            in 7 = D2_P @class(digital), "Data lane 2 positive"
            in 8 = D2_N @class(digital), "Data lane 2 negative"
            in 9 = D3_P @class(digital), "Data lane 3 positive"
            in 10 = D3_N @class(digital), "Data lane 3 negative"
        ]
        peer = SENSOR(1)
    }
}
