# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// DIO - Diode Interface Standard Definition
// Core Rule: the polarized two-terminal diode leaf (rectifier, Schottky,
//            zener, TVS, photodiode, indicator LED). The member pair
//            carries the anode/cathode vocabulary: A is the anode (pad 1,
//            the first-named node), K is the cathode. Conduction direction
//            is the adopting device's model law, not a face property - the
//            face carries no direction words and no peer adopter. Whether
//            a device is physically polarized and which way it works in
//            circuit ride the adopting component's fields (polarity flag;
//            working-direction answer), not this face.
// Note: symmetric two-terminal passives (resistor, capacitor, inductor,
//       fuse, varistor) adopt TERM, not this face - the anode/cathode
//       vocabulary is the split line between the two faces.

interface DIO
{
    topology = "point to point"

    pins = [
        1 = A @class(analog)   // anode (pad 1, first-named node)
        2 = K @class(analog)   // cathode
    ]
}
