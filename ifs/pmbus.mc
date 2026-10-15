# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// PMBUS - Power Management Bus Interface Standard Definition
// Core Rule: Power-management bus on an SMBus-shaped base (open-drain,
//            multi-point, external pullups) with the power additions: the
//            ALERT line slaves use to request attention, and the CONTROL
//            line that enables / sequences power converters.
// Device Definition: HOST = system manager (sources SCL, sequences the
//                    converters),
//                    SLAVE = power device (converter, hot-swap
//                    controller) reporting telemetry.

interface PMBUS(role)
{
    topology = "multi-point"
    mode = ["half duplex"]

    // Electrical contract data rides the PMBUS.ELEC recipe face (302 3.2):
    // the SMBus fixed family with a PMBus-specific clock face (10k-400k on
    // the 1.1-era parts, to 1 MHz on the 1.3 claimants), fixed-absolute
    // VIL 0.8 V, three-band VIH (2.1 V SMBus-literal vs lowered low-rail
    // values), and sink tier tracking the claimed SMBus DC section -
    // six-sample corpus on file. No distance key exists anywhere on the
    // recipe face (zero of six sheets state one; the retired
    // maxspeed/maxdistance tiers were folklore, forensics log). Supply
    // tiers ride the DC supply faces; pull-up sizing is a system
    // convention, not a device EC face.

    pins = [
        1 = SCL @class(digital), "Serial Clock"
        2 = SDA @class(digital), "Serial Data"
        3 = ALERT @class(digital), "PMBus Alert (SMBALERT)"
        4 = CONTROL @class(digital), "Enable / sequencing control line"
    ]

    role HOST {
        name = "PMBus Host (system manager)"
        pins = [
            out 1 = SCL @class(digital), "Serial Clock"                  // The host sources the clock
            io 2 = SDA @class(digital), "Serial Data"                    // Either side drives the data line
            in 3 = ALERT @class(digital), "PMBus Alert (SMBALERT)"       // Slaves assert alert
            out 4 = CONTROL @class(digital), "Enable / sequencing control line"  // The host sequences converters
        ]
        peer = SLAVE
    }
    role SLAVE {
        name = "PMBus Slave (power device)"
        pins = [
            in 1 = SCL @class(digital), "Serial Clock"                   // Clock stretching holds SCL low; the host stays the clock source
            io 2 = SDA @class(digital), "Serial Data"                    // Either side drives the data line
            out 3 = ALERT @class(digital), "PMBus Alert (SMBALERT)"      // A slave asks for the bus
            in 4 = CONTROL @class(digital), "Enable / sequencing control line"   // The slave is enabled by it
        ]
        peer = HOST
    }
}
