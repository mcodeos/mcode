# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// SPDIF - Consumer Digital Audio Serial Link Interface Standard Definition
// Core Rule: Single-wire unidirectional biphase-mark coded digital audio.
//            Physical media is 75 Ohm coax (ground shared through the
//            power interface) or optical (the optical module sits on the
//            device face; this interface stays electrical).
// Device Definition: TRANSMITTER = the audio source driving the link,
//                    RECEIVER = the audio sink decoding it.

interface SPDIF(role)
{
    topology = "point to point"
    mode = ["unidirectional"]

    // Corpus verdict (8 transceivers / integrated receivers: DIX9211/
    // DIR9001/DIX4192/CS8416/AK4118A/WM8804/WM8805/CS42516): this is the
    // one audio digital link with a real spec-level contract - every
    // carrying device cites the same standard set (IEC 60958 + JEITA
    // CPR-1205 + AES3 + EBU Tech 3250) and the contract rows it mandates
    // are keyed in ELEC.SPDIF: the 75 ohm consumer termination (receiver
    // impedance 75 ohm +/-5%, quoted verbatim by CS8416; the AES3 110 ohm
    // professional face is a different class) and the receiver
    // sensitivity window (150~500 mVpp across the six receivers; the
    // values ride the part faces). Retired rows: maxdistance (10 m) is
    // folklore - zero numeric witnesses corpus-wide, the cable face
    // belongs to the standard; maxspeed (12.3 Mbps) is standard-derived
    // (192 kHz x 64fs biphase mark) and per-part fs ranges ride the book's
    // option fs; the logic voltage list dies - the coax face is described
    // in Vpp windows, the 5 V logic tolerance is a single-part face.

    pins = [
        1 = SIG @id.class(digital), "Serial digital audio signal"
    ]

    role TRANSMITTER {
        name = "S/PDIF Transmitter"
        pins = [
            out 1 = SIG @id.class(digital), "Serial digital audio signal"  // The transmitter drives the link
        ]
        peer = RECEIVER(1)
    }
    role RECEIVER {
        name = "S/PDIF Receiver"
        pins = [
            in 1 = SIG @id.class(digital), "Serial digital audio signal"   // The receiver decodes it
        ]
        peer = TRANSMITTER(1)
    }
}
