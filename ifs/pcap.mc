# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// PCAP - Polarized Passive Interface Standard Definition
// Core Rule: the explicitly polarized two-terminal passive leaf (electrolytic
//            / tantalum / niobium / supercap capacitors). The member pair
//            carries the sign vocabulary: \+ is the positive terminal
//            (anode, pad 1), \- is the negative terminal (cathode, pad 2) -
//            the escape lands as the bare sign, the same spelling the
//            datasheets print on the part. Polarity is declared by the face,
//            never by pad position: adopting rows bind the pads through the
//            group form (PCAP{\+, \-}) and the wiring/judgment consumers
//            read the sign members directly.
// Note: the sign members are the same words the polarity ERC (B9) reads on
//       bare pin names (+/ANODE, -/CATHODE) - this face is the group-exposed
//       carrier of that vocabulary for parts whose pads are named by their
//       adopting family, not by the datasheet words.
// Note: symmetric two-terminal passives (resistor, capacitor, inductor,
//       fuse, varistor) adopt TERM (numbered members, no vocabulary); the
//       diode leaf adopts DIO (anode/cathode words, conduction-direction
//       family). This face exists for the polarized-passive split: a part
//       whose polarity is a construction fact declared at the model layer.

interface PCAP
{
    topology = "point to point"

    pins = [
        1 = \+ @id.class(analog)   // positive terminal (anode, pad 1)
        2 = \- @id.class(analog)   // negative terminal (cathode, pad 2)
    ]
}
