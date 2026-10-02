# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Ethernet
interface ETHERNET(role)
{
    topology = "star"
    mode = ["full duplex"]
    maxdistance = 100m
    maxspeed = [10Mbps, 100Mbps, 1Gbps, 10Gbps]
    voltage = 3.3V

    // Ethernet Standard Definition
    // Core Rule: Twisted pair or fiber optic network interface
    // Ethernet Level Spec: Differential signaling over twisted pair, optical signaling over fiber
    // Device Definition: HOST = Network device, SWITCH = Network switch
    // Versions: 10BASE-T, 100BASE-TX, 1000BASE-T, 10GBASE-T

    pins = [
        1 = TD\+ @class(digital), "Transmit Data Positive"    // Positive transmit data
        2 = TD\- @class(digital), "Transmit Data Negative"    // Negative transmit data
        3 = RD\+ @class(digital), "Receive Data Positive"     // Positive receive data
        4 = BI4 @class(digital), "Bidirectional"              // Bidirectional line
        5 = BI5 @class(digital), "Bidirectional"              // Bidirectional line
        6 = RD\- @class(digital), "Receive Data Negative"     // Negative receive data
        7 = BI7 @class(digital), "Bidirectional"              // Bidirectional line
        8 = BI8 @class(digital), "Bidirectional"              // Bidirectional line
    ]
    
    role HOST {
        name = "Ethernet Host"
        pins = [
            out 1 = TD\+ @class(digital), "Transmit Data Positive"  // The host transmits on TD
            out 2 = TD\- @class(digital), "Transmit Data Negative"
            in 3 = RD\+ @class(digital), "Receive Data Positive"    // and receives on RD
            io 4 = BI4 @class(digital), "Bidirectional"             // Gigabit quad: all four pairs
            io 5 = BI5 @class(digital), "Bidirectional"             // are bidirectional
            in 6 = RD\- @class(digital), "Receive Data Negative"
            io 7 = BI7 @class(digital), "Bidirectional"
            io 8 = BI8 @class(digital), "Bidirectional"
        ]
        peer = SWITCH
    }

    role SWITCH {
        name = "Ethernet Switch"
        pins = [
            in 1 = TD\+ @class(digital), "Transmit Data Positive"   // The switch port receives the host's TD
            in 2 = TD\- @class(digital), "Transmit Data Negative"
            out 3 = RD\+ @class(digital), "Receive Data Positive"   // and transmits the host's RD
            io 4 = BI4 @class(digital), "Bidirectional"             // Gigabit quad: all four pairs
            io 5 = BI5 @class(digital), "Bidirectional"             // are bidirectional
            out 6 = RD\- @class(digital), "Receive Data Negative"
            io 7 = BI7 @class(digital), "Bidirectional"
            io 8 = BI8 @class(digital), "Bidirectional"
        ]
        peer = HOST
    }
}
