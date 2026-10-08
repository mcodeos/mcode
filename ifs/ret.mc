# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// RET - Resistor-Equipped Transistor Terminal Interface Standard Definition
// Core Rule: Digital-input transistor leaf with built-in biasing
//            resistors (a BJT plus one or two internal resistors in one
//            package: R1 in series with the base drive, R2 base-emitter).
//            IN is a logic-level drive terminal, OUT is the open
//            collector, GND is the common return. Polarity (NPN/PNP
//            pre-biased) and the inverted drive sense (PNP RETs turn on
//            with IN pulled low) ride the component fields - the
//            terminal set is isomorphic across variants. The internal
//            resistors are not terminals: they live in the adopting
//            slice's fields (R1 tier family, R2 ratio window). No
//            direction words and no peer adopter.
// Device Definition: DISCRETE = the resistor-equipped transistor body
//                    (single digital transistor, e.g. PDTA/PTRD, DTC/DTA
//                    families).

interface RET
{
    topology = "point to point"

    pins = [
        1 = I   @class(analog)   // IN - logic drive through internal R1
        2 = GND @class(analog)   // Common return (internal R2 base-emitter node)
        3 = O   @class(analog)   // OUT - open collector
    ]
}
