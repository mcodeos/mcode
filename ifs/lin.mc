# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// LIN (Local Interconnect Network)
interface LIN(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 40m
    maxspeed = [20kbps]
    voltage = 12V

    // LIN Standard Definition
    // Core Rule: Low-cost, low-speed serial communication for automotive body electronics
    // LIN Level Spec: Single wire with ground reference
    // Device Definition: MASTER = Controls the bus, SLAVE = Body electronics module
    // Applications: Power windows, door locks, seat controls, lighting

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
