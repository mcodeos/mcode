# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// RST (Reset) Interface Standard Definition
// Core Rule: reset / power-on-reset control line between a reset source
// (supervisor, RC timer, debugger, pushbutton driver) and reset bodies
// (MCU NRST, peripheral RESET inputs). Active-low on most parts; polarity
// stays a datasheet fact of the adopting pin's description, not the face.
// Identity comes from adoption only (no name inference): a `TRST`-style pin
// inside a debug port belongs to the DBG family boundary, not here, and the
// `@barrier(reset)` of RELAY.LATCH is a relay-coil role, same word different
// family (mcd/doc/ee/reset-intent-design.md -- this face is that doc's
// "first domino", the library-side reset role pair).
// Pairing law: a reset net is one source driving N bodies, so the SOURCE
// peer declaration is count-less (`peer = ROLE`, unrestricted -- the
// ADC.SINGLE / DAC / CAN precedent); the RECEIVER side carries the
// exact-one bound (`peer = SOURCE(1)`) -- the undershoot half of the
// pairing law, live since b4511.
// Judges anchored on these roles (reset-intent-design §2), both live as of
// b4550: overshoot is the exclusive-peer/role-peer/connection-time trio
// (E6054/E6061/E4121, the exact-one bound is what arms them); the orphan
// undershoot is E6063 IFACE_PEER_UNREACHED -- a RECEIVER whose whole merged
// conductor holds no SOURCE endpoint and no non-family terminal at all (an
// RC-only reset network is a legal reset source: its resistor and
// capacitor terminals are the structure witness). POR-supervisor existence
// rides the same code at conductor grain; a per-domain census waits for
// domain objects. The SUP/SUP.WDG supervisor family (mclibs/power/sup.mc)
// is the SOURCE side's first corpus.
// Applications: MCU NRST/RESET pins, supervisor/watchdog outputs, manual
// reset circuits, shared reset buses

interface RST(role)
{
    topology = "point to point"
    mode = ["input", "output"]
    maxdistance = 0.5m
    voltage = [1.8V, 3.3V, 5V]

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
// Supervisor / reset-controller side (see mclibs/power/sup.mc):
//     out 2 = RST::RST(SOURCE), ["RESET"]
