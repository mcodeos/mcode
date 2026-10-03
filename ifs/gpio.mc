# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// GPIO - General Purpose Input/Output Interface Standard Definition
// Core Rule: One general-purpose digital line, push-pull by default
//            (high = VCC, low = GND). A device that drives the line
//            open-drain states @drive(od) (and @pull where it relies on
//            one) on its own adoption row, which overrides this default.
// Device Definition: PROVIDER = the side that offers the line (MCU/SoC),
//                    CONSUMER = the side that uses it (any digital
//                    device).
// Note: a GPIO unit is a single pin, one instance per general-purpose
//       line (GPIO[3, 4]::GPIO(PROVIDER) binds one pin per member).

interface GPIO(role)
{
    topology = "point to point"
    mode = ["input", "output", "bidirectional"]
    maxdistance = 0.1m
    maxspeed = [100MHz]
    voltage = [1.8V,3.3V,5V]

    // Member row electrical nature: a general-purpose GPIO pin is
    // push-pull by default; a device that drives a GPIO line open-drain
    // states `@drive(od)` on its own adoption row, which overrides this
    // library default per pin.
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
