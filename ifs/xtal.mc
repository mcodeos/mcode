# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// XTAL - Passive Crystal/Resonator Interface Standard Definition
// Core Rule: The passive resonator face (two-terminal crystal / ceramic
//            resonator). The role pair is a circuit-identity pair, not a
//            signal direction pair: OSCILLATOR hosts the sustaining
//            amplifier (the drive comes from its internal inverter; the
//            crystal transmits nothing), RESONATOR is the passive
//            piezoelectric body. Both ends of a resonator must land on
//            one OSCILLATOR instance, and a RESONATOR has exactly one
//            OSCILLATOR — `peer = ROLE(1)` on both roles makes that
//            law declarative. No Transmitter/Receiver wording and no
//            direction words (passive leaf).
// Device Definition: OSCILLATOR = the amplifier host (MCU XIN/XOUT, RTC
//                    OSC pins),
//                    RESONATOR = the crystal / ceramic resonator body.
// Note: active oscillator modules do not adopt this face; their clock
//       output adopts the single-ended CLK interface.

interface XTAL(role)
{
    topology = "point to point"

    pins = [
        1 = X1 | XTAL1 | XIN | XI | XTI | OSCIN @class(analog)   // Crystal terminal 1 (datasheet XTAL1; host side XIN/XI/XTI/OSCIN)
        2 = X2 | XTAL2 | XOUT | XO | XTO | OSCOUT @class(analog)   // Crystal terminal 2 (datasheet XTAL2; host side XOUT/XO/XTO/OSCOUT)
    ]

    role OSCILLATOR {  // hosts the sustaining amplifier: MCU XIN/XOUT
        name = "XTAL Oscillator"
        peer = RESONATOR(1)
    }
    role RESONATOR {   // the passive piezoelectric body
        name = "XTAL Resonator"
        peer = OSCILLATOR(1)
    }
}

// Example usage:
// component MyComponent
// {
//     pins = [
//         [1,2] = XTAL{X1,X2}::XTAL(RESONATOR) , ["Crystal input","Crystal output"]
//     ]
// }
// MCU side (the pins hosting the sustaining amplifier):
//     in [3,4] = XTAL::XTAL(OSCILLATOR) , ["Crystal in","Crystal out"]
