# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// MOST (Media Oriented Systems Transport)
interface MOST(role)
{
    topology = "ring"
    mode = ["full duplex"]
    maxdistance = 40m
    maxspeed = [22.5Mbps, 50Mbps, 150Mbps]
    voltage = 3.3V

    // MOST Standard Definition
    // Core Rule: High-speed multimedia network for in-vehicle entertainment systems
    // MOST Level Spec: Optical or electrical signaling
    // Device Definition: MASTER = Controls the bus, SLAVE = Audio/Video device
    // Applications: In-car infotainment, navigation, audio/video distribution

    pins = [
        1 = OPT @class(digital), "Optical"    // Optical fiber connection
        2 = ELE @class(digital), "Electrical" // Electrical connection (alternative)
    ]
    
    role MASTER {
        name = "MOST Master"
        pins = [
            io 1 = OPT @class(digital), "Optical"     // A ring circulates frames past every node —
            io 2 = ELE @class(digital), "Electrical"  // each node relays in and out (one medium in use)
        ]
        peer = SLAVE
    }

    role SLAVE {
        name = "MOST Slave"
        pins = [
            io 1 = OPT @class(digital), "Optical"     // A ring circulates frames past every node —
            io 2 = ELE @class(digital), "Electrical"  // each node relays in and out (one medium in use)
        ]
        peer = MASTER
    }
}
