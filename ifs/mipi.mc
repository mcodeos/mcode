# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Both faces share the D-PHY shape: one differential clock pair plus data
// pairs; 1 / 2 / 4 data lanes are used and the rest stay unconnected.
// Every pair is positive-first (P/N convention, same as CLK.DIFF); the
// ground reference rides the power supply (DC interface), no ground member.

// MIPI.DPHY - MIPI D-PHY Interface (family base view) Standard Definition
// Core Rule: The D-PHY base view — one differential clock pair plus the
//            data lane pairs. The lane count is the member dimension
//            (MIPI.DSI carries up to four data lanes, MIPI.CSI two); the
//            family base states the lanes every member shares. Every pair
//            is positive-first (P/N convention, same as CLK.DIFF); the
//            ground reference rides the power supply (DC interface), no
//            ground member.
// Device Definition: HOST = the side driving the clock and data lanes,
//                    DEVICE = the side receiving them.

interface MIPI.DPHY(role)
{
    topology = "point to point"
    mode = ["unidirectional"]

    // Electrical contract data (PHY supply window, the per-lane HS rate
    // span, the low-swing HS class) rides the ELEC.MIPI.DPHY recipe face
    // (302 3.2); this definition carries structure only.

    pins = [
        1 = CLK_P @pair(clk) @class(digital), "D-PHY clock pair positive"
        2 = CLK_N @pair(clk) @class(digital), "D-PHY clock pair negative"
        3 = D0_P @pair(d0) @class(digital), "Data lane 0 positive"
        4 = D0_N @pair(d0) @class(digital), "Data lane 0 negative"
    ]

    role HOST {
        name = "D-PHY Host"
        pins = [
            out 1 = CLK_P @pair(clk) @class(digital), "D-PHY clock pair positive"
            out 2 = CLK_N @pair(clk) @class(digital), "D-PHY clock pair negative"
            out 3 = D0_P @pair(d0) @class(digital), "Data lane 0 positive"
            out 4 = D0_N @pair(d0) @class(digital), "Data lane 0 negative"
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "D-PHY Device"
        pins = [
            in 1 = CLK_P @pair(clk) @class(digital), "D-PHY clock pair positive"
            in 2 = CLK_N @pair(clk) @class(digital), "D-PHY clock pair negative"
            in 3 = D0_P @pair(d0) @class(digital), "Data lane 0 positive"
            in 4 = D0_N @pair(d0) @class(digital), "Data lane 0 negative"
        ]
        peer = HOST(1)
    }
}

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
    // Electrical contract data rides the recipe face: ELEC.MIPI.DPHY
    // carries the D-PHY lane contract (PHY supply window, the per-lane HS
    // rate span with its 80 Mbps spec floor and version-dependent ceiling,
    // the low-swing HS class) and serves this face and MIPI.CSI alike --
    // same PHY, same contract. The retired distance row (0.3 m) and the
    // rate-at-distance spellings were board practice coupled into the rows
    // (folklore forms of the per-lane rate); the spec states electrical
    // and timing limits only.

    pins = [
        1 = CLK_P @pair(clk) @class(digital), "D-PHY clock pair positive"
        2 = CLK_N @pair(clk) @class(digital), "D-PHY clock pair negative"
        3 = D0_P @pair(d0) @class(digital), "Data lane 0 positive"
        4 = D0_N @pair(d0) @class(digital), "Data lane 0 negative"
        5 = D1_P @pair(d1) @class(digital), "Data lane 1 positive"
        6 = D1_N @pair(d1) @class(digital), "Data lane 1 negative"
        7 = D2_P @pair(d2) @class(digital), "Data lane 2 positive"
        8 = D2_N @pair(d2) @class(digital), "Data lane 2 negative"
        9 = D3_P @pair(d3) @class(digital), "Data lane 3 positive"
        10 = D3_N @pair(d3) @class(digital), "Data lane 3 negative"
    ]

    role HOST {
        name = "DSI Host (SoC display controller)"
        pins = [
            out 1 = CLK_P @pair(clk) @class(digital), "D-PHY clock pair positive"  // The host drives every lane
            out 2 = CLK_N @pair(clk) @class(digital), "D-PHY clock pair negative"  // (video mode; command-mode replies
            out 3 = D0_P @pair(d0) @class(digital), "Data lane 0 positive"        // ride the same lanes inbound)
            out 4 = D0_N @pair(d0) @class(digital), "Data lane 0 negative"
            out 5 = D1_P @pair(d1) @class(digital), "Data lane 1 positive"
            out 6 = D1_N @pair(d1) @class(digital), "Data lane 1 negative"
            out 7 = D2_P @pair(d2) @class(digital), "Data lane 2 positive"
            out 8 = D2_N @pair(d2) @class(digital), "Data lane 2 negative"
            out 9 = D3_P @pair(d3) @class(digital), "Data lane 3 positive"
            out 10 = D3_N @pair(d3) @class(digital), "Data lane 3 negative"
        ]
        peer = DISPLAY(1)
    }
    role DISPLAY {
        name = "DSI Peripheral (display panel)"
        pins = [
            in 1 = CLK_P @pair(clk) @class(digital), "D-PHY clock pair positive"   // The panel receives
            in 2 = CLK_N @pair(clk) @class(digital), "D-PHY clock pair negative"
            in 3 = D0_P @pair(d0) @class(digital), "Data lane 0 positive"
            in 4 = D0_N @pair(d0) @class(digital), "Data lane 0 negative"
            in 5 = D1_P @pair(d1) @class(digital), "Data lane 1 positive"
            in 6 = D1_N @pair(d1) @class(digital), "Data lane 1 negative"
            in 7 = D2_P @pair(d2) @class(digital), "Data lane 2 positive"
            in 8 = D2_N @pair(d2) @class(digital), "Data lane 2 negative"
            in 9 = D3_P @pair(d3) @class(digital), "Data lane 3 positive"
            in 10 = D3_N @pair(d3) @class(digital), "Data lane 3 negative"
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
    // Same verdict as MIPI.DSI: the D-PHY lane contract rides the shared
    // ELEC.MIPI.DPHY book; the retired distance and rate-at-distance rows
    // were board practice, the supply domain rides the book's window.

    pins = [
        1 = CLK_P @pair(clk) @class(digital), "D-PHY clock pair positive"
        2 = CLK_N @pair(clk) @class(digital), "D-PHY clock pair negative"
        3 = D0_P @pair(d0) @class(digital), "Data lane 0 positive"
        4 = D0_N @pair(d0) @class(digital), "Data lane 0 negative"
        5 = D1_P @pair(d1) @class(digital), "Data lane 1 positive"
        6 = D1_N @pair(d1) @class(digital), "Data lane 1 negative"
        7 = D2_P @pair(d2) @class(digital), "Data lane 2 positive"
        8 = D2_N @pair(d2) @class(digital), "Data lane 2 negative"
        9 = D3_P @pair(d3) @class(digital), "Data lane 3 positive"
        10 = D3_N @pair(d3) @class(digital), "Data lane 3 negative"
    ]

    role SENSOR {
        name = "CSI Transmitter (camera sensor)"
        pins = [
            out 1 = CLK_P @pair(clk) @class(digital), "D-PHY clock pair positive"  // The sensor drives every lane
            out 2 = CLK_N @pair(clk) @class(digital), "D-PHY clock pair negative"
            out 3 = D0_P @pair(d0) @class(digital), "Data lane 0 positive"
            out 4 = D0_N @pair(d0) @class(digital), "Data lane 0 negative"
            out 5 = D1_P @pair(d1) @class(digital), "Data lane 1 positive"
            out 6 = D1_N @pair(d1) @class(digital), "Data lane 1 negative"
            out 7 = D2_P @pair(d2) @class(digital), "Data lane 2 positive"
            out 8 = D2_N @pair(d2) @class(digital), "Data lane 2 negative"
            out 9 = D3_P @pair(d3) @class(digital), "Data lane 3 positive"
            out 10 = D3_N @pair(d3) @class(digital), "Data lane 3 negative"
        ]
        peer = HOST(1)
    }
    role HOST {
        name = "CSI Receiver (SoC ISP)"
        pins = [
            in 1 = CLK_P @pair(clk) @class(digital), "D-PHY clock pair positive"   // The ISP samples them
            in 2 = CLK_N @pair(clk) @class(digital), "D-PHY clock pair negative"
            in 3 = D0_P @pair(d0) @class(digital), "Data lane 0 positive"
            in 4 = D0_N @pair(d0) @class(digital), "Data lane 0 negative"
            in 5 = D1_P @pair(d1) @class(digital), "Data lane 1 positive"
            in 6 = D1_N @pair(d1) @class(digital), "Data lane 1 negative"
            in 7 = D2_P @pair(d2) @class(digital), "Data lane 2 positive"
            in 8 = D2_N @pair(d2) @class(digital), "Data lane 2 negative"
            in 9 = D3_P @pair(d3) @class(digital), "Data lane 3 positive"
            in 10 = D3_N @pair(d3) @class(digital), "Data lane 3 negative"
        ]
        peer = SENSOR(1)
    }
}
