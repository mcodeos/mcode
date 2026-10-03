# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// FlexRay
interface FLEXRAY(role)
{
    topology = "star"
    mode = ["full duplex"]
    maxdistance = 10m
    maxspeed = [10Mbps]
    voltage = 5V

    // FlexRay Standard Definition
    // Core Rule: Deterministic, fault-tolerant communication for automotive applications
    // FlexRay Level Spec: Differential signaling, dual-channel redundancy
    // Device Definition: Node = Any device on the FlexRay bus
    // Applications: Automotive drive-by-wire systems, brake-by-wire, steering systems

    pins = [
        1 = CH_A\+ @class(digital), "Channel A Positive"    // Positive differential signal for channel A
        2 = CH_A\- @class(digital), "Channel A Negative"    // Negative differential signal for channel A
        3 = CH_B\+ @class(digital), "Channel B Positive"    // Positive differential signal for channel B
        4 = CH_B\- @class(digital), "Channel B Negative"    // Negative differential signal for channel B
        5 = GND, "Ground"                  // Signal reference ground
    ]
    
    role NODE {
        name = "FlexRay Node"
        pins = [
            io 1 = CH_A\+ @class(digital), "Channel A Positive"  // TDMA time-share: a node drives its own slot
            io 2 = CH_A\- @class(digital), "Channel A Negative"  // and listens on every other slot
            io 3 = CH_B\+ @class(digital), "Channel B Positive"
            io 4 = CH_B\- @class(digital), "Channel B Negative"
            5 = GND, "Ground"                    // Signal reference ground
        ]
        peer = NODE
    }
}
