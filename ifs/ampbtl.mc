# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// AMP.BTL - Bridge-Tied-Load Audio Output Interface Standard Definition
// Core Rule: Two anti-phase single-ended legs drive both ends of one
//            load — N is the anti-phase leg of P, so the load sees the
//            P - N swing. A power drive pair, not a measurement pair: the
//            receiver is a passive load, the load floats across the pair,
//            and each leg may carry its own ESD return.
// Device Definition: TRANSMITTER = amplifier BTL output stage,
//                    RECEIVER = passive load (speaker, haptic actuator).

interface AMP.BTL(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.5m
    voltage = [3.3V,5V]
    output_power = [1W,3W]
    load = [4Ohm,8Ohm]

    // The two rows tagged @pair(p) are the two legs of one bridge drive; the
    // P/N spellings are the naming convention, and the first member is leg A.
    // The @class(analog) row attribute is the library-default signal class
    // (same as ADC.SINGLE / ADC.DIFF): a bridge drive is an analog power
    // output face even when the amplifier stage is class D.
    pins = [
        1 = P @class(analog) @pair(p), "Positive BTL Output"   // Positive-phase bridge leg
        2 = N @class(analog) @pair(p), "Negative BTL Output"   // Anti-phase bridge leg
    ]

    role TRANSMITTER {  // AMP.BTL Transmitter - Amplifier BTL output stage
        name = "AMP.BTL Transmitter"
        pins = [
            out 1 = P @class(analog) @pair(p), "Positive BTL Output"  // The amplifier drives both legs
            out 2 = N @class(analog) @pair(p), "Negative BTL Output"
        ]
        peer = RECEIVER(1)
    }
    role RECEIVER {  // AMP.BTL Receiver - Speaker or other passive load
        name = "AMP.BTL Receiver"
        pins = [
            in 1 = P @class(analog) @pair(p), "Positive BTL Output"   // The load floats across the pair
            in 2 = N @class(analog) @pair(p), "Negative BTL Output"
        ]
        peer = TRANSMITTER(1)
    }
}
