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
    // No interface electrical book: Clause 22 defines the management
    // frames and the clocking ceiling only -- the 2.5 MHz MDC ceiling
    // (period >= 400 ns, carried by the pin row) is a spec-derived
    // timing constant, not a link-rate contract. Levels are per-part
    // VDDIO-classed CMOS on the same ring as the MAC bus (keyed at the
    // family altitude, DEV.TRANS.ETH supply.v_ddio; the open-drain pull-up
    // rides that ring). The retired 0.1 m row was board practice with
    // zero spec witnesses -- same verdict as the MII/RMII bus face.

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
