# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ADC.DIFF - Differential ADC Input Interface Standard Definition
// Core Rule: Differential analog measurement pair (P/N): the converter
//            reads the voltage difference between the legs, rejecting
//            common-mode noise and improving signal-to-noise ratio. The
//            ground reference is the analog ground domain, shared through
//            the power supply (DC interface) — no ground member here.
// Device Definition: TRANSMITTER = sensor or signal source driving the
//                    pair,
//                    RECEIVER = ADC converter sampling the pair.

interface ADC.DIFF(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [1Mbps@0.5m, 10Mbps@0.1m]
    voltage = [3.3V,5V]
    input_range = ±10V
    resolution = [8bit,10bit,12bit,16bit]

    // The two rows tagged @pair(p) are the two legs of one differential
    // signal; the P/N spellings are the naming convention, and the first
    // member is leg A.
    // The @class(analog) row attribute is the library-default signal class,
    // same as ADC.SINGLE: adopting components inherit it and may override
    // by ordinal.
    pins = [
        1 = P @class(analog) @pair(p), "Positive Input"   // Positive differential input
        2 = N @class(analog) @pair(p), "Negative Input"   // Negative differential input
    ]
    
    role TRANSMITTER {  // ADC.DIFF Transmitter - Sensor or signal source
        name = "ADC.DIFF Transmitter"
        pins = [
            out 1 = P @class(analog) @pair(p), "Positive Input"   // The source drives the pair
            out 2 = N @class(analog) @pair(p), "Negative Input"
        ]
        peer = RECEIVER(1)
    }
    role RECEIVER {  // ADC.DIFF Receiver - ADC converter
        name = "ADC.DIFF Receiver"
        pins = [
            in 1 = P @class(analog) @pair(p), "Positive Input"    // The converter samples the pair
            in 2 = N @class(analog) @pair(p), "Negative Input"
        ]
        peer = TRANSMITTER(1)
    }
}
