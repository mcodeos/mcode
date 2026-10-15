# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// DC - DC Power Supply Interface Standard Definition
// Core Rule: Unidirectional direct-current power over a positive rail and
//            ground. The positive row's name is computed from the bound
//            voltage: "VCC" + the canonical rail text of volt (one fixed
//            decimal, the decimal point read as V, a negative value
//            marked N: 3.3V -> VCC3V3, 12V -> VCC12V0, -5V -> VCC5V0N); a
//            voltage that binds to no single number keeps the generic
//            name VCC. Source/sink direction rides the adopting
//            terminal's direction word (psrc / psnk / psbi), not a
//            parameter of this face.
// Note: the head formal is the instance-binding hook of the data face —
//       every adoption site binds its own rail nominal (::DC(3.3V) class;
//       the retired body rows were folklore: distance stated by zero
//       documents, the nominal is not definition data). The body keeps
//       structure only; the electrical contract rides the .ELEC recipes.

interface DC(volt::UV.VOLT) // DC Power Supply Interface
{
    topology = "point to point"
    mode = ["unidirectional"]

    if (volt < 0V)
        pins = [
            1 = "VCC" + canon(volt), "DC power negative"
            2 = GND, "DC power ground"
        ]
    else if (volt > 0V)
        pins = [
            1 = "VCC" + canon(volt), "DC power positive"
            2 = GND, "DC power ground"
        ]
    else
        pins = [
            1 = VCC, "DC power positive"
            2 = GND, "DC power ground"
        ]

}
