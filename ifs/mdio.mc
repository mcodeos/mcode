# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ---------------------------------------------------------------------------------------------
// MDIO — PHY management bus (IEEE 802.3 clause 22 serial management, clause 45 extended)
// ---------------------------------------------------------------------------------------------

interface MDIO(role)
{
    topology = "multi-point"  // one management station addresses up to 32 PHYs on the pair
    mode = ["half duplex"]  // MDIO is shared, half-duplex by construction
    maxdistance = 0.1m  // PCB trace only
    maxspeed = [2.5MHz@0.1m]  // MDC period >= 400ns (DS00002164B §3.5 p.27)
    voltage = [1.8V, 2.5V, 3.3V]  // I/O ring follows VDDIO; variable 1.6V-3.6V per DS00002164B p.13

    // IEEE 802.3 serial management interface (SMI) — the two-wire control
    // plane of every MII/RMII PHY: a station-management entity (in the MAC)
    // clocks register reads/writes to one or more PHY addresses.
    // Core Rule: MDC is a non-periodic clock sourced by the manager;
    // MDIO is bidirectional with an open-drain driver at the PHY (VOD8,
    // DS00002164B p.14) — the pair needs a pull-up on MDIO.
    // Device Definition: MANAGER = station management entity (MAC side),
    // PHY = managed physical layer device (address via PHYAD[2:0] straps).

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
