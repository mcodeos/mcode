# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// STEPDIR - STEP/DIR Stepper Control Interface Standard Definition
// Core Rule: Two independent motion-control lanes: STEP carries the step
//            pulse train (one rising edge advances the indexer one step),
//            DIR carries the static direction level, only sampled around
//            STEP edges. Independent signals, so no @pair tag.
// Device Definition: TRANSMITTER = pulse source (MCU timer/GPIO),
//                    RECEIVER = stepper driver indexer input.

interface STEPDIR(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [500kHz]
    voltage = [1.8V,3.3V,5V]

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    //
    pins = [
        1 = _ @drive(pp) @class(digital) // STEP
        2 = _ @drive(pp) @class(digital) // DIR
    ]

    role TRANSMITTER {  // pulse source: MCU timer/GPIO
        name = "STEPDIR Transmitter"
        pins = [
            out 1 = STEP @drive(pp) @class(digital), "Step pulse train (rising edge advances one step)"
            out 2 = DIR @drive(pp) @class(digital), "Direction level"
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // stepper driver indexer input
        name = "STEPDIR Receiver"
        pins = [
            in 1 = STEP @drive(pp) @class(digital), "Step pulse train (rising edge advances one step)"
            in 2 = DIR @drive(pp) @class(digital), "Direction level"
        ]
        peer = TRANSMITTER
    }
}
