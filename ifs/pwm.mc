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
    // Electrical contract data rides the recipe face: ELEC.PWM carries the
    // receiver logic-input windows (the one face the corpus carries -- the
    // gate-driver / motor-driver input tables). The transmitting side is
    // the GPIO EC inheritance law (alternate-function I/O rows only, zero
    // PWM-named electrical rows in any checked MCU datasheet) and rides
    // GPIO.ELEC. The distance row carried zero corpus statements and is
    // retired; the 1 MHz tier was peripheral-function text, not a link
    // limit; supply tiers ride the DC faces.

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
    // Same recipe face as the single lane: ELEC.PWM serves the six-lane
    // three-phase face as a variant rider (six independent logic lanes of
    // one bridge; per-lane electrical character = the same receiver
    // logic-input face; deadtime lives in the driver, not in the lane
    // pair). The retired envelope rows share the single-lane corpus
    // verdict above.

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
            out 1 = UH @drive(pp) @class(digital) @cross(RECEIVER.INHA) // Phase U high-side control
            out 2 = UL @drive(pp) @class(digital) @cross(RECEIVER.INLA) // Phase U low-side control
            out 3 = VH @drive(pp) @class(digital) @cross(RECEIVER.INHB) // Phase V high-side control
            out 4 = VL @drive(pp) @class(digital) @cross(RECEIVER.INLB) // Phase V low-side control
            out 5 = WH @drive(pp) @class(digital) @cross(RECEIVER.INHC) // Phase W high-side control
            out 6 = WL @drive(pp) @class(digital) @cross(RECEIVER.INLC) // Phase W low-side control
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // PWM sink: three-phase gate driver
        name = "Three-phase PWM Receiver"
        pins = [
            in 1 = INHA @drive(pp) @class(digital) @cross(TRANSMITTER.UH) // Phase U high-side control (driver input)
            in 2 = INLA @drive(pp) @class(digital) @cross(TRANSMITTER.UL) // Phase U low-side control (driver input)
            in 3 = INHB @drive(pp) @class(digital) @cross(TRANSMITTER.VH) // Phase V high-side control (driver input)
            in 4 = INLB @drive(pp) @class(digital) @cross(TRANSMITTER.VL) // Phase V low-side control (driver input)
            in 5 = INHC @drive(pp) @class(digital) @cross(TRANSMITTER.WH) // Phase W high-side control (driver input)
            in 6 = INLC @drive(pp) @class(digital) @cross(TRANSMITTER.WL) // Phase W low-side control (driver input)
        ]
        peer = TRANSMITTER
    }
}
