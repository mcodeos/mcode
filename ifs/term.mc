# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// TERM - Passive Two-Terminal Interface Standard Definition
// Core Rule: the symmetric passive two-terminal face (resistor, capacitor,
//            inductor, ferrite bead, fuse, varistor, jumper, net-tie). Two
//            classless network nodes (class rides the host net's identity,
//            not the iface — a passive on a power rail is still a passive;
//            a passive on analog signal is still a passive), no role
//            distinction and no direction words: the terminals are
//            interchangeable for every adopter.
//            Polarity never rides this face - a polarized part declares its
//            terminals on its own face (PCAP's sign words for the polarized
//            passives, DIO's anode/cathode for the diode leaf), never by
//            pad position. No peer adopter - the far end is a network node,
//            not a face adopter.
// Note: the members are numbered, not named - a generic passive lands in
//       signal networks as often as power networks, so the face carries no
//       role vocabulary (hot/ret was power-rail speech and read wrong on a
//       coupling cap or a divider resistor). Position is the only contract:
//       pad 1 is the first terminal; adopting rows map pads by position
//       ([1,2]::TERM()) and never rely on names.

interface TERM
{
    topology = "point to point"

    pins = [
        1 = 1                  // terminal 1 (first pad) — classless: class rides the host net, not the iface
        2 = 2                  // terminal 2
    ]
}
