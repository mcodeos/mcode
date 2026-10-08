# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// BJT - Bipolar Junction Transistor Terminal Interface Standard Definition
// Core Rule: Three-terminal current-controlled leaf (base, collector,
//            emitter). Every terminal is an analog network node - the base
//            is the control terminal, collector/emitter carry the
//            controlled current. No Transmitter/Receiver wording and no
//            direction words: the recipe-side `io` word carries the
//            bidirectional sense, and no peer device adopts this face
//            (the far end is a network node, not a face adopter).
//            Polarity (NPN/PNP) is a conditional axis on the adopting
//            component's fields, not a face property - the terminal set
//            and the current path are isomorphic. Darlington composites
//            ride the same face: their base stage is internal, so the
//            terminal set is identical (the variant is visible only in
//            the fields, e.g. min-only hFE without grade tiers).
// Device Definition: DISCRETE = the transistor body (single BJT or
//                    Darlington composite).

interface BJT
{
    topology = "point to point"

    pins = [
        1 = B @class(analog)   // Base - control terminal
        2 = C @class(analog)   // Collector
        3 = E @class(analog)   // Emitter
    ]
}
