# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// MOST.OPT - MOST Optical Fiber Ring Interface Standard Definition
// Core Rule: Ring-topology multimedia network over plastic optical fiber:
//            frames circulate past every node in one direction and each
//            node relays in and out - one fiber per lane, the receive and
//            transmit fibers of one transceiver face. Carries all three
//            speed generations (22.5 / 50 / 150 Mbps).
// Device Definition: MASTER = ring timing master / control node,
//                    SLAVE = audio/video node on the ring,
//                    RELAY = the cable conductor view (fiber jumper).

interface MOST.OPT(role)
{
    topology = "ring"
    mode = ["full duplex"]
    maxdistance = 40m
    maxspeed = [22.5Mbps, 50Mbps, 150Mbps]
    voltage = 3.3V

    pins = [
        1 = TX @class(digital), "Optical transmit"    // fiber out to the downstream node
        2 = RX @class(digital), "Optical receive"     // fiber in from the upstream node
    ]

    role MASTER {
        name = "MOST Master"
        pins = [
            out 1 = TX @class(digital), "Optical transmit"    // relays the circulating frame stream out
            in 2 = RX @class(digital), "Optical receive"      // and in from the upstream node
        ]
        peer = SLAVE
    }

    role SLAVE {
        name = "MOST Slave"
        pins = [
            out 1 = TX @class(digital), "Optical transmit"    // relays the circulating frame stream out
            in 2 = RX @class(digital), "Optical receive"      // and in from the upstream node
        ]
        peer = MASTER
    }

    // Relay face: the cable's conductor view - inherits the table above
    // (two fibers) and selects no endpoint role. A jumper module binds
    // `io a::MOST.OPT(RELAY)` on each end and states its straight join
    // in the body; the TX <-> RX crossing comes from the endpoint roles.
    role RELAY {
        name = "MOST Optical Relay"
    }
}

// MOST.ELE - MOST Electrical Twisted-Pair Ring Interface Standard Definition
// Core Rule: Ring-topology multimedia network over the MOST50 electrical
//            physical layer: differential transmission on balanced twisted
//            pair, one pair per direction - the ring relays in and out.
//            50 Mbps generation.
// Device Definition: MASTER = ring timing master / control node,
//                    SLAVE = audio/video node on the ring,
//                    RELAY = the cable conductor view (twisted-pair segment).

interface MOST.ELE(role)
{
    topology = "ring"
    mode = ["full duplex"]
    maxdistance = 40m
    maxspeed = [50Mbps]
    voltage = 3.3V

    pins = [
        1 = TX\+ @pair(tx) @class(digital), "Transmit Positive"    // differential pair, fiber-out equivalent
        2 = TX\- @pair(tx) @class(digital), "Transmit Negative"
        3 = RX\+ @pair(rx) @class(digital), "Receive Positive"     // differential pair, fiber-in equivalent
        4 = RX\- @pair(rx) @class(digital), "Receive Negative"
    ]

    role MASTER {
        name = "MOST Master"
        pins = [
            out 1 = TX\+ @pair(tx) @class(digital), "Transmit Positive"    // relays the circulating frame stream out
            out 2 = TX\- @pair(tx) @class(digital), "Transmit Negative"
            in 3 = RX\+ @pair(rx) @class(digital), "Receive Positive"      // and in from the upstream node
            in 4 = RX\- @pair(rx) @class(digital), "Receive Negative"
        ]
        peer = SLAVE
    }

    role SLAVE {
        name = "MOST Slave"
        pins = [
            out 1 = TX\+ @pair(tx) @class(digital), "Transmit Positive"    // relays the circulating frame stream out
            out 2 = TX\- @pair(tx) @class(digital), "Transmit Negative"
            in 3 = RX\+ @pair(rx) @class(digital), "Receive Positive"      // and in from the upstream node
            in 4 = RX\- @pair(rx) @class(digital), "Receive Negative"
        ]
        peer = MASTER
    }

    // Relay face: the cable's conductor view - inherits the table above
    // (two differential pairs) and selects no endpoint role. A segment
    // module binds `io a::MOST.ELE(RELAY)` on each end and states its
    // straight join in the body; the TX <-> RX crossing comes from the
    // endpoint roles.
    role RELAY {
        name = "MOST Electrical Relay"
    }
}

// MOST.COAX - MOST Coaxial Ring Interface Standard Definition
// Core Rule: Ring-topology multimedia network over the MOST150 electrical
//            physical layer on coaxial cable: single-ended lanes, one per
//            direction, the shield return rides the power domain (no GND
//            member on the face). 150 Mbps generation.
// Device Definition: MASTER = ring timing master / control node,
//                    SLAVE = audio/video node on the ring,
//                    RELAY = the cable conductor view (coax segment).

interface MOST.COAX(role)
{
    topology = "ring"
    mode = ["full duplex"]
    maxdistance = 40m
    maxspeed = [150Mbps]
    voltage = 3.3V

    pins = [
        1 = TX @class(digital), "Coaxial transmit"    // out to the downstream node
        2 = RX @class(digital), "Coaxial receive"     // in from the upstream node
    ]

    role MASTER {
        name = "MOST Master"
        pins = [
            out 1 = TX @class(digital), "Coaxial transmit"    // relays the circulating frame stream out
            in 2 = RX @class(digital), "Coaxial receive"      // and in from the upstream node
        ]
        peer = SLAVE
    }

    role SLAVE {
        name = "MOST Slave"
        pins = [
            out 1 = TX @class(digital), "Coaxial transmit"    // relays the circulating frame stream out
            in 2 = RX @class(digital), "Coaxial receive"      // and in from the upstream node
        ]
        peer = MASTER
    }

    // Relay face: the cable's conductor view - inherits the table above
    // (two coax lanes) and selects no endpoint role. A segment module
    // binds `io a::MOST.COAX(RELAY)` on each end and states its straight
    // join in the body; the TX <-> RX crossing comes from the endpoint
    // roles.
    role RELAY {
        name = "MOST Coaxial Relay"
    }
}
