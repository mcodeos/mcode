# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// RST - Reset Control Interface Standard Definition
// Core Rule: Reset / power-on-reset control line between reset sources
//            (supervisor, RC timer, debugger, pushbutton driver) and reset
//            bodies (MCU NRST, peripheral RESET inputs). A reset net is
//            one source driving N bodies: the SOURCE peer declaration is
//            count-less (`peer = RECEIVER`, unrestricted); the RECEIVER
//            side carries the exact-one bound (`peer = SOURCE(1)`).
//            Active-low on most parts; polarity stays a datasheet fact of
//            the adopting pin's description, not the face. Identity comes
//            from adoption only (no name inference): a `TRST`-style pin
//            inside a debug port belongs to the debug family, not here,
//            and the `@barrier(reset)` of a relay coil is a relay-coil
//            role, same word different family.
// Device Definition: SOURCE = reset source (supervisor, RC timer,
//                    debugger, pushbutton driver),
//                    RECEIVER = reset body (MCU NRST, peripheral RESET
//                    input).

interface RST(role)
{
    topology = "point to point"
    mode = ["input", "output"]
    maxdistance = 0.5m
    voltage = [1.8V, 3.3V, 5V]

    // ERC anchors on these roles: overshoot is checked by the
    // exclusive-peer/role-peer/connection-time trio (the exact-one bound
    // arms them); a RECEIVER whose whole merged conductor holds no SOURCE
    // endpoint and no non-family terminal at all is an orphan. An RC-only
    // reset network is a legal reset source: its resistor and capacitor
    // terminals are the non-family terminals that count.
    pins = [
        1 = RST @class(digital)   // Reset line (datasheet nRST/RESET/NRST)
    ]

    role SOURCE {  // drives the reset line: supervisor, RC, debugger, button
        name = "RST Source"
        pins = [
            out 1 = RST @class(digital)   // The source pulls/drives the line
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // reset body: MCU NRST, peripheral RESET input
        name = "RST Receiver"
        pins = [
            io 1 = RST @class(digital)   // Bodies may also drive reset (e.g. MCU NRST is bidirectional)
        ]
        peer = SOURCE(1)
    }
}

// Example usage:
// MCU side (dedicated bidirectional reset pin):
//     io 7 = RST::RST(RECEIVER), ["NRST"]
// Supervisor / reset-controller side:
//     out 2 = RST::RST(SOURCE), ["RESET"]
