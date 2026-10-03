# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// LIN - Local Interconnect Network Bus Interface Standard Definition
// Core Rule: Low-cost single-wire (plus ground) multi-point bus at 12V
//            for vehicle body electronics; the master controls the
//            schedule and both sides time-share the wire, either one
//            driving a response slot.
// Device Definition: MASTER = controls the bus schedule,
//                    SLAVE = body-electronics node.

interface LIN(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 40m
    maxspeed = [20kbps]
    voltage = 12V

    pins = [
        1 = LIN @class(digital), "Data"    // Single wire data line
        2 = GND, "Ground"  // Signal reference ground
    ]
    
    role MASTER {
        name = "LIN Master"
        pins = [
            io 1 = LIN @class(digital), "Data"  // Master and slaves time-share the wire — either side may drive a response
            2 = GND, "Ground"   // Signal reference ground
        ]
        peer = SLAVE
    }

    role SLAVE {
        name = "LIN Slave"
        pins = [
            io 1 = LIN @class(digital), "Data"  // Master and slaves time-share the wire — either side may drive a response
            2 = GND, "Ground"   // Signal reference ground
        ]
        peer = MASTER
    }
}
