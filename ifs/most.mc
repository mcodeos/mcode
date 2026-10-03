# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// MOST - Media Oriented Systems Transport Ring Interface Standard Definition
// Core Rule: Ring-topology multimedia network: frames circulate past
//            every node and each node relays in and out; one of the two
//            media members (optical or electrical) is in use.
// Device Definition: MASTER = ring timing master / control node,
//                    SLAVE = audio/video node on the ring.

interface MOST(role)
{
    topology = "ring"
    mode = ["full duplex"]
    maxdistance = 40m
    maxspeed = [22.5Mbps, 50Mbps, 150Mbps]
    voltage = 3.3V

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
