# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ETHERNET - Ethernet Twisted-Pair Interface Standard Definition
// Core Rule: Four twisted pairs on the 8-pin face. At 10/100M the TD pair
//            and RD pair cross between host and switch port; at gigabit
//            and above all four pairs are bidirectional.
// Device Definition: HOST = network end device (MAC/PHY),
//                    SWITCH = switch port.

interface ETHERNET(role)
{
    topology = "star"
    mode = ["full duplex"]
    maxdistance = 100m
    maxspeed = [10Mbps, 100Mbps, 1Gbps, 10Gbps]
    voltage = 3.3V

    pins = [
        1 = TD\+ @pair(td) @class(digital), "Transmit Data Positive"    // Positive transmit data
        2 = TD\- @pair(td) @class(digital), "Transmit Data Negative"    // Negative transmit data
        3 = RD\+ @pair(rd) @class(digital), "Receive Data Positive"     // Positive receive data
        4 = BI4 @class(digital), "Bidirectional"              // Bidirectional line
        5 = BI5 @class(digital), "Bidirectional"              // Bidirectional line
        6 = RD\- @pair(rd) @class(digital), "Receive Data Negative"     // Negative receive data
        7 = BI7 @class(digital), "Bidirectional"              // Bidirectional line
        8 = BI8 @class(digital), "Bidirectional"              // Bidirectional line
    ]
    
    role HOST {
        name = "Ethernet Host"
        pins = [
            out 1 = TD\+ @pair(td) @class(digital), "Transmit Data Positive"  // The host transmits on TD
            out 2 = TD\- @pair(td) @class(digital), "Transmit Data Negative"
            in 3 = RD\+ @pair(rd) @class(digital), "Receive Data Positive"    // and receives on RD
            io 4 = BI4 @class(digital), "Bidirectional"             // Gigabit quad: all four pairs
            io 5 = BI5 @class(digital), "Bidirectional"             // are bidirectional
            in 6 = RD\- @pair(rd) @class(digital), "Receive Data Negative"
            io 7 = BI7 @class(digital), "Bidirectional"
            io 8 = BI8 @class(digital), "Bidirectional"
        ]
        peer = SWITCH
    }

    role SWITCH {
        name = "Ethernet Switch"
        pins = [
            in 1 = TD\+ @pair(td) @class(digital), "Transmit Data Positive"   // The switch port receives the host's TD
            in 2 = TD\- @pair(td) @class(digital), "Transmit Data Negative"
            out 3 = RD\+ @pair(rd) @class(digital), "Receive Data Positive"   // and transmits the host's RD
            io 4 = BI4 @class(digital), "Bidirectional"             // Gigabit quad: all four pairs
            io 5 = BI5 @class(digital), "Bidirectional"             // are bidirectional
            out 6 = RD\- @pair(rd) @class(digital), "Receive Data Negative"
            io 7 = BI7 @class(digital), "Bidirectional"
            io 8 = BI8 @class(digital), "Bidirectional"
        ]
        peer = HOST
    }
}
