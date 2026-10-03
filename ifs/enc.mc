# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// ENC (Incremental Quadrature Encoder) Standard Definition
// Core Rule: two-wire incremental position feedback -- the encoder emits
// two pulse trains (A/B) with a fixed phase relationship; the reader
// decodes both the position delta (edge count) and the rotation direction
// (which phase leads). The two lanes are one synchronous pair, so no
// @pair tag -- same ruling as STEPDIR / PWM.H6 (independent signal lanes,
// pairing is a decode convention, not a conductor property).
// Device Definition: TRANSMITTER = the encoder (signal source),
//                    RECEIVER = the reader (MCU timer/GPIO quadrature decode).
// The pair shares the encoder element common terminal; the common lands on
// the logic return through the component pin, not through this face (same
// ruling as ADC.SINGLE / STEPDIR: return via the supply domain).
// Scope: the generic 2-phase A/B face. An index (Z) third lane and
// differential (+/-) pairs are not members; they come in with the first
// consumer that needs them (component-inventory B5 note).
// Shape witness: ALPS EC11 series (EC11E15244B2 detail sheet, 4 pages;
// real part mcpub sensor/ec11) -- A/C/B element with C common, 2-phase A/B
// output, no index lane anywhere in the document.

interface ENC(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.3m
    maxspeed = [100kHz]   // generic face cap; mechanical encoders sit far
                          // below it (EC11: 15 pulses/rev, 3ms chatter mask)
    voltage = [1.8V,3.3V,5V]

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1). Contact outputs carry no drive
    // transistor: the reader side expects pull-ups (EC11 sliding-noise
    // test circuit p.3: A and B each through R to +5V, C grounded).
    pins = [
        1 = _ @class(digital) // A
        2 = _ @class(digital) // B
    ]

    role TRANSMITTER {  // the encoder: contact pair against the element common
        name = "ENC Transmitter"
        pins = [
            out 1 = A @class(digital), "Quadrature phase A"
            out 2 = B @class(digital), "Quadrature phase B (phase-delayed from A; B transition drawn after A in the CW output-wave figure)"
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
