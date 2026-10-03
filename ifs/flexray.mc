# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// FLEXRAY - FlexRay Automotive Bus Interface Standard Definition
// Core Rule: Deterministic, fault-tolerant time-triggered automotive bus
//            over two redundant differential channels (A/B); nodes
//            time-share the medium, driving their own slot and listening
//            on every other slot.
// Device Definition: NODE = any FlexRay node (peer-equal time-share).

interface FLEXRAY(role)
{
    topology = "star"
    mode = ["full duplex"]
    maxdistance = 10m
    maxspeed = [10Mbps]
    voltage = 5V

    pins = [
        1 = CH_A\+ @pair(cha) @class(digital), "Channel A Positive"    // Positive differential signal for channel A
        2 = CH_A\- @pair(cha) @class(digital), "Channel A Negative"    // Negative differential signal for channel A
        3 = CH_B\+ @pair(chb) @class(digital), "Channel B Positive"    // Positive differential signal for channel B
        4 = CH_B\- @pair(chb) @class(digital), "Channel B Negative"    // Negative differential signal for channel B
        5 = GND, "Ground"                  // Signal reference ground
    ]
    
    role NODE {
        name = "FlexRay Node"
        pins = [
            io 1 = CH_A\+ @pair(cha) @class(digital), "Channel A Positive"  // TDMA time-share: a node drives its own slot
            io 2 = CH_A\- @pair(cha) @class(digital), "Channel A Negative"  // and listens on every other slot
            io 3 = CH_B\+ @pair(chb) @class(digital), "Channel B Positive"
            io 4 = CH_B\- @pair(chb) @class(digital), "Channel B Negative"
            5 = GND, "Ground"                    // Signal reference ground
        ]
        peer = NODE
    }
}
