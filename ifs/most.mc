# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// MOST.OPT - MOST Optical Fiber Ring Interface Standard Definition
// Core Rule: Ring-topology multimedia network over optical fiber: frames
//            circulate past every node and each node relays in and out;
//            this face is the optical-medium attachment of the MOST family.
// Device Definition: MASTER = ring timing master / control node,
//                    SLAVE = audio/video node on the ring.

interface MOST.OPT(role)
{
    topology = "ring"
    mode = ["full duplex"]
    maxdistance = 40m
    maxspeed = [22.5Mbps, 50Mbps, 150Mbps]
    voltage = 3.3V

    pins = [
        1 = OPT @class(digital), "Optical"    // Optical fiber attachment
    ]

    role MASTER {
        name = "MOST Master"
        pins = [
            io 1 = OPT @class(digital), "Optical"  // each node relays in and out
        ]
        peer = SLAVE
    }

    role SLAVE {
        name = "MOST Slave"
        pins = [
            io 1 = OPT @class(digital), "Optical"  // each node relays in and out
        ]
        peer = MASTER
    }
}

// MOST.ELE - MOST Electrical Ring Interface Standard Definition
// Core Rule: Ring-topology multimedia network over the electrical physical
//            layer: frames circulate past every node and each node relays
//            in and out; this face is the electrical-medium attachment of
//            the MOST family.
// Device Definition: MASTER = ring timing master / control node,
//                    SLAVE = audio/video node on the ring.

interface MOST.ELE(role)
{
    topology = "ring"
    mode = ["full duplex"]
    maxdistance = 40m
    maxspeed = [22.5Mbps, 50Mbps, 150Mbps]
    voltage = 3.3V

    pins = [
        1 = ELE @class(digital), "Electrical"    // Electrical attachment
    ]

    role MASTER {
        name = "MOST Master"
        pins = [
            io 1 = ELE @class(digital), "Electrical"  // each node relays in and out
        ]
        peer = SLAVE
    }

    role SLAVE {
        name = "MOST Slave"
        pins = [
            io 1 = ELE @class(digital), "Electrical"  // each node relays in and out
        ]
        peer = MASTER
    }
}
