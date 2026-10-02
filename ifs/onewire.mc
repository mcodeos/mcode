# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// 1-Wire Standard Definition
// Core Rule: Single wire communication with parasitic power
// 1-Wire Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
// Device Definition: MASTER = Initiates communication, SLAVE = Responds to master
// Applications: Temperature sensors (DS18B20), EEPROM, iButton
//
// A 1-Wire bus tap is a single pin (the anonymous data line, DQ in the
// datasheets): one instance per bus.
//   OW0::ONEWIRE(MASTER)      -> one bus tap
//   OW0[1:2]::ONEWIRE(MASTER) -> members OW0.1, OW0.2, one pin each
interface ONEWIRE(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 100m
    maxspeed = [16kbps]
    voltage = [1.8V,3.3V,5V]

    // @drive(od): the 1-Wire bus is open-drain with an external pullup — every
    // node releases the line by driving high. A push-pull driver states
    // `@drive(pp)` on its own adoption row, which overrides this default.
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
