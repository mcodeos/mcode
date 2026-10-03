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
// Pairing law: a reset net is one source driving N bodies, so the peer
// declarations are count-less (`peer = ROLE`, unrestricted -- the
// ADC.SINGLE / DAC / CAN precedent). Inline per-role cardinality
// (`peer = SOURCE(1)` on bodies) lands with the iface-peer-cardinality
// inline form (CIMP U351); tighten there, not here, when it lands.
// Future judges anchored on these roles (reset-intent-design §2, candidates):
// chain reachability (every body reaches exactly one source) and POR
// supervisor existence. There is no supervisor/POR component family in the
// libraries yet -- a SOURCE adopter does not exist in the corpus.
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
// Supervisor / reset-controller side (when such parts join the libraries):
//     out 2 = RST::RST(SOURCE), ["RESET"]
