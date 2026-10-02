# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// GPIO (General Purpose Input/Output) Standard Definition
// Core Rule: General purpose digital input/output pins
// GPIO Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
// Device Definition: Provider = the side that offers the line (MCU/SoC),
//                    Consumer = the side that uses it (any digital device)
// Applications: LEDs, buttons, relays, digital sensors
//
// A GPIO unit is a single pin: one instance per general-purpose line.
//   GPIO3::GPIO(PROVIDER)      -> one GPIO line
//   GPIO[3, 4]::GPIO(PROVIDER) -> members GPIO3, GPIO4, one pin each
interface GPIO(role)
{
    topology = "point to point"
    mode = ["input", "output", "bidirectional"]
    maxdistance = 0.1m
    maxspeed = [100MHz]
    voltage = [1.8V,3.3V,5V]

    // @drive(pp) — the member row's electrical nature (candidate A of
    // interface-member-config-design.md §2): a general-purpose GPIO pin is
    // push-pull by default. A device that drives a GPIO line open-drain
    // states `@drive(od)` (and `@pull` where it relies on one) on its own
    // adoption row, which overrides this lib-side default per pin.
    pins = [
        1 = _ @drive(pp) @class(digital)
    ]

    role PROVIDER {  // offers the line: MCU/SoC GPIO block
        name = "GPIO Provider"
        peer = CONSUMER
    }

    role CONSUMER {  // uses the line: any digital device
        name = "GPIO Consumer"
        peer = PROVIDER
    }
}
