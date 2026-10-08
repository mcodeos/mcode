# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// FET - Field-Effect Transistor Terminal Interface Standard Definition
// Core Rule: Three-terminal voltage-controlled leaf (gate, source,
//            drain). MOSFET and JFET share the terminal set - the
//            control-law difference (insulated gate vs junction diode,
//            enhancement vs depletion) rides the adopting slice's
//            fields, not the face. JFET drain and source are physically
//            interchangeable (symmetric channel): the D/S spellings are
//            the naming convention, the face carries no direction on the
//            channel. Polarity (N/P channel) is a conditional axis on
//            the component fields. No direction words and no peer
//            adopter - the recipe-side `io` word carries the
//            bidirectional sense.
// Device Definition: DISCRETE = the transistor body (MOSFET or JFET).

interface FET
{
    topology = "point to point"

    pins = [
        1 = G @class(analog)   // Gate - control terminal (MOSFET: insulated, JFET: junction)
        2 = D @class(analog)   // Drain
        3 = S @class(analog)   // Source (JFET: interchangeable with drain)
    ]
}
