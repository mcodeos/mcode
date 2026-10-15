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
// Note: the members are numbered, not named - a generic passive lands in
//       signal networks as often as power networks, so the face carries no
//       role vocabulary (hot/ret was power-rail speech and read wrong on a
//       coupling cap or a divider resistor). Position is the only contract:
//       pad 1 is the first terminal (a polarized part lands its anode there
//       per its own polarity flag); adopting rows map pads by position
//       ([1,2]::TERM()) and never rely on names.

interface TERM
{
    topology = "point to point"

    pins = [
        1 = 1 @class(analog)   // terminal 1 (first pad; polarized anode lands here)
        2 = 2 @class(analog)   // terminal 2
    ]
}
