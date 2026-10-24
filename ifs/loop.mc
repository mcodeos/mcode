# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// LOOP - Analog Current Loop Interface Standard Definition (4-20mA class)
// Core Rule: One analog current signal carried as a series circuit: the
//            transmitter regulates the loop current between the family
//            ranges (canonical 4mA live zero to 20mA full scale; 0-20mA
//            and 5-25mA variants exist), and the receiver drops that
//            current on its sense resistance and reads a voltage. The
//            two conductors are supply/return of one circuit, not a
//            differential pair, so no @sig.pair tag. The live-zero current
//            powers 2-wire loop-powered transmitters (they harvest their
//            supply from the loop); 3-wire/4-wire variants bind a DC face
//            for the separate supply and bind this face for the signal.
// Device Definition: TRANSMITTER = the loop current source (the field
//                    transmitter; 2-wire loop-powered or externally
//                    powered),
//                    RECEIVER = the sense side (sense resistor plus level
//                    shift, e.g. a 4-20mA to 0-5V converter).
// Note: HART rides this face as a low-level AC overlay on the same two
//       conductors; it is not a member of this face. The lanes share no
//       ground terminal through this face (the return is a current-carrying
//       circuit conductor, not earth).

interface LOOP(role) // Analog current loop interface (4-20mA class)
{
    topology = "point to point"
    mode = ["unidirectional"]

    // Electrical contract data (loop supply windows, distance/speed caps,
    // family range numbers) rides the interface electrical recipe face;
    // this definition carries structure only.

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    pins = [
        1 = _ @id.class(analog) // loop current conductor
        2 = _ @id.class(analog) // loop return conductor
    ]

    role TRANSMITTER {  // the loop current source (series element)
        name = "LOOP Transmitter"
        pins = [
            out 1 = I, "Loop current out (regulated to the family range; 2-wire loop-powered transmitters harvest their supply from the live-zero current)"
            in 2 = RTN, "Loop return (series path back to the loop supply)"
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // the sense side (current to voltage conversion)
        name = "LOOP Receiver"
        pins = [
            in 1 = I, "Loop current in (dropped on the sense resistance; e.g. internal 4-20mA to 0-5V conversion)"
            out 2 = RTN, "Loop return continuation (the series circuit closes through the transmitter)"
        ]
        peer = TRANSMITTER
    }
}
