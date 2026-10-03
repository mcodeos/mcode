# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// PWM (Pulse Width Modulation) Standard Definition
// Core Rule: Digital signal with adjustable duty cycle
// PWM Level Spec: High = VCC, Low = GND
// Device Definition: TRANSMITTER = PWM source (MCU timer output, driver IC),
//                    RECEIVER = PWM sink (motor driver input, LED, MOSFET gate)
// Applications: Motor speed control, LED dimming, servo position control
//
// A PWM channel is a single pin: one instance per channel.
//   PWM0::PWM(TRANSMITTER)      -> one PWM channel
//   PWM0[1:4]::PWM(TRANSMITTER) -> members PWM0.1 .. PWM0.4, one pin each
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

interface PWM.H6(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [1MHz]
    voltage = [1.8V,3.3V,5V]

    // Three-phase complementary PWM (interface inventory B6): the six gate
    // control lanes of one three-phase bridge, phase-major with the high side
    // first -- UH, UL, VH, VL, WH, WL. UH/UL drive the same half bridge
    // complementary, but they are two independent control signals (the
    // deadtime lives in the driver, not in the lane pair), so the lanes carry
    // no @pair tag -- unlike the CAN_H/CAN_L legs of one differential signal.
    // Shape witness: DRV8304H INHA/INLA/INHB/INLB/INHC/INLC six control
    // inputs (TI ZHCSI91B p.3 package drawing; real part mcpub motor/drv8304).

    // Role-less conductor view: 6 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _ @class(digital) // UH <-> INHA
        2 = _ @class(digital) // UL <-> INLA
        3 = _ @class(digital) // VH <-> INHB
        4 = _ @class(digital) // VL <-> INLB
        5 = _ @class(digital) // WH <-> INHC
        6 = _ @class(digital) // WL <-> INLC
    ]

    role TRANSMITTER {  // PWM source: MCU advanced timer with complementary outputs
        name = "Three-phase PWM Transmitter"
        pins = [
            out 1 = UH @class(digital) // Phase U high-side control
            out 2 = UL @class(digital) // Phase U low-side control
            out 3 = VH @class(digital) // Phase V high-side control
            out 4 = VL @class(digital) // Phase V low-side control
            out 5 = WH @class(digital) // Phase W high-side control
            out 6 = WL @class(digital) // Phase W low-side control
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // PWM sink: three-phase gate driver
        name = "Three-phase PWM Receiver"
        pins = [
            in 1 = UH @class(digital) // Phase U high-side control
            in 2 = UL @class(digital) // Phase U low-side control
            in 3 = VH @class(digital) // Phase V high-side control
            in 4 = VL @class(digital) // Phase V low-side control
            in 5 = WH @class(digital) // Phase W high-side control
            in 6 = WL @class(digital) // Phase W low-side control
        ]
        peer = TRANSMITTER
    }
}
