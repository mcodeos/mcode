# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ENC - Incremental Quadrature Encoder Interface Standard Definition
// Core Rule: Two independent pulse trains (A/B) with a fixed phase
//            relationship; the reader decodes the position delta from
//            edge count and the rotation direction from which phase
//            leads. The lanes are one synchronous pair but independent
//            signal lanes, so no @pair tag (pairing is a decode
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
    maxdistance = 0.3m
    maxspeed = [100kHz]   // generic face cap; mechanical encoders sit far
                          // below it (family-typical: 15 pulses/rev, 3ms chatter mask)
    voltage = [1.8V,3.3V,5V]

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    pins = [
        1 = _ @class(digital) // A
        2 = _ @class(digital) // B
    ]

    role TRANSMITTER {  // the encoder: contact pair against the element common
        name = "ENC Transmitter"
        pins = [
            out 1 = A @class(digital), "Quadrature phase A"
            out 2 = B @class(digital), "Quadrature phase B (phase-delayed from A; B lags A in the clockwise direction)"
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // the reader: quadrature decode (edge count + direction)
        name = "ENC Receiver"
        pins = [
            in 1 = A @class(digital), "Quadrature phase A"
            in 2 = B @class(digital), "Quadrature phase B"
        ]
        peer = TRANSMITTER
    }
}
