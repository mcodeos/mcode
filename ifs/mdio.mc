# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// MDIO - Ethernet PHY Serial Management Bus Interface Standard Definition
// Core Rule: Two-wire management control plane for PHYs: the manager
//            sources a non-periodic clock (MDC, data latched to its
//            rising edge) and the PHY answers on an open-drain
//            bidirectional data line (MDIO, pull-up required); one
//            management station addresses PHYs by port address.
// Device Definition: MANAGER = station management entity (MAC side),
//                    PHY = managed physical layer device.

interface MDIO(role)
{
    topology = "multi-point"  // one management station addresses up to 32 PHYs on the pair
    mode = ["half duplex"]  // MDIO is shared, half-duplex by construction
    maxdistance = 0.1m  // PCB trace only
    maxspeed = [2.5MHz@0.1m]  // MDC period >= 400ns
    voltage = [1.8V, 2.5V, 3.3V]  // I/O ring follows VDDIO

    pins = [
        1 = MDC @class(digital), "Management Clock (manager drives)"   // non-periodic, data latched to rising edge
        2 = MDIO @class(digital), "Management Data I/O"                // open-drain at the PHY; pull-up required
    ]

    role MANAGER {
        name = "Station Management Entity"
        pins = [
            out 1 = MDC @class(digital), "Management Clock (manager drives)"  // The manager sources the clock
            io 2 = MDIO @class(digital), "Management Data I/O"                // issues frames, reads responses
        ]
        peer = PHY
    }

    role PHY {
        name = "Managed PHY"
        pins = [
            in 1 = MDC @class(digital), "Management Clock (manager drives)"
            io 2 = MDIO @class(digital), "Management Data I/O"                // open-drain driver; latches to MDC rising edge
        ]
        peer = MANAGER
    }
}
