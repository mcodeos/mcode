# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ENC - Incremental Quadrature Encoder Interface Standard Definition
// Core Rule: Two independent pulse trains (A/B) with a fixed phase
//            relationship; the reader decodes the position delta from
//            edge count and the rotation direction from which phase
//            leads. The lanes are one synchronous pair but independent
//            signal lanes, so no @sig.pair tag (pairing is a decode
//            convention, not a conductor property). Contact outputs carry
//            no drive transistor: the reader side expects pull-ups.
// Device Definition: TRANSMITTER = the encoder (contact pair against the
//                    element common),
//                    RECEIVER = the reader (MCU timer/GPIO quadrature
//                    decode).
// Note: the lanes share the encoder element common terminal, which lands
//       on the logic return through the component pin, not through this
//       face; the generic scope is the 2-phase A/B face — an index (Z)
//       lane and differential (+/-) pairs are not members.

interface ENC(role)
{
    topology = "point to point"
    mode = ["output"]

    // Corpus verdict (encoder modules HEDS-9200/HEDM optical, AS5040
    // magnetic, iC-TW8/iC-HE conditioners; MCU readers RM0364/HPM5300/
    // QEP -- the reader side is pure protocol, zero electrical rows):
    // the retired rows carried no interface-level contract. Distance:
    // zero witnesses corpus-wide (the only length figure is a iC-HE
    // Figure-2 test condition, not a spec row). Speed: per-part figures
    // span decades -- HEDS 100 kHz recommended, iC-TW8 8 MHz ABZ,
    // AS5040 stated in rpm -- never an interface envelope. Voltage: the
    // output classes split per-part (TTL open-collector + external
    // pull-up, CMOS push-pull, RS-422 differential driver) with no
    // receiver threshold stated for the differential class. No .ELEC
    // book: zero all-sample keys exist on this face.

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    pins = [
        1 = _ @id.class(digital) // A
        2 = _ @id.class(digital) // B
    ]

    role TRANSMITTER {  // the encoder: contact pair against the element common
        name = "ENC Transmitter"
        pins = [
            out 1 = A @id.class(digital), "Quadrature phase A"
            out 2 = B @id.class(digital), "Quadrature phase B (phase-delayed from A; B lags A in the clockwise direction)"
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // the reader: quadrature decode (edge count + direction)
        name = "ENC Receiver"
        pins = [
            in 1 = A @id.class(digital), "Quadrature phase A"
            in 2 = B @id.class(digital), "Quadrature phase B"
        ]
        peer = TRANSMITTER
    }
}
