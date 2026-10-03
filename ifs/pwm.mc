# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// PWM - Pulse Width Modulation Interface Standard Definition
// Core Rule: Single digital channel with adjustable duty cycle; a PWM
//            output stage is push-pull by default, and a device that
//            drives the line open-drain states @drive(od) on its own
//            adoption row, which overrides this default.
// Device Definition: TRANSMITTER = PWM source (MCU timer output, driver
//                    IC),
//                    RECEIVER = PWM sink (motor driver input, LED,
//                    MOSFET gate).
// Note: a PWM channel is a single pin, one instance per channel
//       (PWM0[1:4]::PWM(TRANSMITTER) binds one pin per member).

interface PWM(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [1MHz]
    voltage = [1.8V,3.3V,5V]

    // @drive(pp): a PWM output stage is push-pull by default, same library
    // default as GPIO. A device that drives the line open-drain states
    // `@drive(od)` on its own adoption row, which overrides this default.
    pins = [
        1 = _ @drive(pp) @class(digital)
    ]

    role TRANSMITTER {  // PWM source: MCU timer output, driver IC
        name = "PWM Transmitter"
        pins = [
            out 1 = _ @drive(pp) @class(digital) // The source drives the channel
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // PWM sink: motor driver input, LED, MOSFET gate
        name = "PWM Receiver"
        pins = [
            in 1 = _ @drive(pp) @class(digital) // The sink reads it
        ]
        peer = TRANSMITTER
    }
}

// PWM.H6 - Three-Phase Complementary PWM Interface Standard Definition
// Core Rule: The six gate-control lanes of one three-phase bridge,
//            phase-major with the high side first (UH, UL, VH, VL, WH,
//            WL). UH/UL drive the same half bridge complementary but are
//            two independent control signals — the deadtime lives in the
//            driver, not in the lane pair — so the lanes carry no @pair
//            tag (unlike the legs of one differential signal).
// Device Definition: TRANSMITTER = MCU advanced timer with complementary
//                    outputs,
//                    RECEIVER = three-phase gate driver.

interface PWM.H6(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [1MHz]
    voltage = [1.8V,3.3V,5V]

    // Role-less conductor view: 6 anonymous lanes, ordinal = wire identity
    //
    pins = [
        1 = _ @drive(pp) @class(digital) // UH <-> INHA
        2 = _ @drive(pp) @class(digital) // UL <-> INLA
        3 = _ @drive(pp) @class(digital) // VH <-> INHB
        4 = _ @drive(pp) @class(digital) // VL <-> INLB
        5 = _ @drive(pp) @class(digital) // WH <-> INHC
        6 = _ @drive(pp) @class(digital) // WL <-> INLC
    ]

    role TRANSMITTER {  // PWM source: MCU advanced timer with complementary outputs
        name = "Three-phase PWM Transmitter"
        pins = [
            out 1 = UH @drive(pp) @class(digital) // Phase U high-side control
            out 2 = UL @drive(pp) @class(digital) // Phase U low-side control
            out 3 = VH @drive(pp) @class(digital) // Phase V high-side control
            out 4 = VL @drive(pp) @class(digital) // Phase V low-side control
            out 5 = WH @drive(pp) @class(digital) // Phase W high-side control
            out 6 = WL @drive(pp) @class(digital) // Phase W low-side control
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // PWM sink: three-phase gate driver
        name = "Three-phase PWM Receiver"
        pins = [
            in 1 = UH @drive(pp) @class(digital) // Phase U high-side control
            in 2 = UL @drive(pp) @class(digital) // Phase U low-side control
            in 3 = VH @drive(pp) @class(digital) // Phase V high-side control
            in 4 = VL @drive(pp) @class(digital) // Phase V low-side control
            in 5 = WH @drive(pp) @class(digital) // Phase W high-side control
            in 6 = WL @drive(pp) @class(digital) // Phase W low-side control
        ]
        peer = TRANSMITTER
    }
}
