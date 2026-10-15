# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// TERM - Passive Two-Terminal Interface Standard Definition
// Core Rule: the symmetric passive two-terminal face (resistor, capacitor,
//            inductor, ferrite bead, fuse, varistor, jumper, net-tie). Two
//            analog network nodes, no role distinction and no direction
//            words: the terminals are interchangeable for every adopter
//            whose polarity flag is false. Polarity itself is a
//            conditional axis on the adopting component's fields, not a
//            face property (the face has no vocabulary for it - the
//            diode's anode/cathode words are why diodes have their own
//            face). No peer adopter - the far end is a network node, not
//            a face adopter.
// Note: the member names are the positional convention, not roles - pad 1
//       is the first-named node (a polarized part lands its anode there
//       per its own polarity flag); adopting rows rename by position and
//       never rely on these names.

interface TERM
{
    topology = "point to point"

    pins = [
        1 = hot @class(analog)   // entry node 1 (first-named node)
        2 = ret @class(analog)   // entry node 2 (return)
    ]
}
