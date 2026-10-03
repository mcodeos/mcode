# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ONEWIRE - 1-Wire Bus Interface Standard Definition
// Core Rule: Single-wire half-duplex multi-point bus, open-drain with an
//            external pullup — every node releases the line by driving
//            high (a push-pull driver states @drive(pp) on its own
//            adoption row). The ground reference is shared through the
//            power supply, so the face has no ground member; parasitic
//            power over the data line is the family's signature mode.
// Device Definition: MASTER = initiates and times every exchange,
//                    SLAVE = responds when addressed.
// Note: a bus tap is a single pin, one instance per bus
//       (OW0::ONEWIRE(MASTER); OW0[1:2] binds one pin per member).

interface ONEWIRE(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 100m
    maxspeed = [16kbps]
    voltage = [1.8V,3.3V,5V]

    pins = [
        1 = _ @drive(od) @class(digital)
    ]

    role MASTER {
        name = "1-Wire Master"
        peer = SLAVE
    }

    role SLAVE {
        name = "1-Wire Slave"
        peer = MASTER
    }
}
