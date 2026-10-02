# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// ---------------------------------------------------------------------------------------------
// XTAL Interface Definition
// ---------------------------------------------------------------------------------------------

// XTAL interface: the passive resonator face (two-terminal crystal / ceramic
// resonator). The role pair is a circuit-identity pair, not a signal direction
// pair: Oscillator hosts the sustaining amplifier (MCU XIN/XOUT, RTC OSC
// pins), Resonator is the passive piezoelectric body. No Transmitter/Receiver
// wording (in a Pierce loop the drive comes from the MCU internal inverter;
// the crystal transmits nothing) and no direction words (passive leaf law).
// ERC / sim / DRC judgments anchor on the roles: both ends of a resonator must
// land on one Oscillator instance, and a Resonator has exactly one Oscillator
// (U200; mcd/doc/ee/xtal-oscillator-design.md). The `peer = ROLE(1)` on both
// roles is that law made declarative for the flat ERC gate (6054): one adoption
// lane of a one-peer role must reach one peer instance across its terminals —
// a resonator body wired X1 onto one MCU and X2 onto another is a torn pairing
// each of whose nets passes the point-to-point count. Roles that declare
// nothing pair unrestricted.
// The @class(analog) row attribute is the library-default signal class:
// adopting components inherit it and may override by ordinal.
// Active oscillator modules do NOT adopt this face; their clock output adopts
// the single-ended CLK interface (ifs/clk.mc).

interface XTAL(role)
{
    topology = "point to point"

    pins = [
        1 = X1 @class(analog)   // Crystal terminal 1
        2 = X2 @class(analog)   // Crystal terminal 2
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
