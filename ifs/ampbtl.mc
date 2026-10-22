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

    // Corpus verdict (5 BTL amplifier samples: TPA3004D2/TPA3110D2/
    // TPA3116D2/TPA2005D1/LPA4871): the retired rows carried no interface-
    // level contract - the [3.3V,5V] supply envelope was falsified by its
    // own corpus (2.5~5.5V low-voltage class, but 8~26V and 4.5~26V are
    // the mainstream Class-D rows), and the [1W,3W] power envelope covered
    // only that low-voltage subset (10W/ch and 2x50W parts exist in class).
    // Supply rides the DC faces. Output power and load live as per-part
    // rated-condition tables - p_out(mode = rated(rl, vcc, thd), value)
    // rows already keyed by the DEV.AUDIO.AMP family recipe's power group
    // (r_load included; 4/8 Ohm are measurement conditions, abs-max min
    // load is the part's own rating). Distance: zero witnesses (folklore).
    // No .ELEC book: the electrical contract is owned by the DEV.AUDIO.AMP
    // family recipe; the BTL pair itself states no per-lane rows beyond
    // that table.

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
