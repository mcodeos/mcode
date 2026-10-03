# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ADC.SINGLE - Single-Ended Analog Input Interface Standard Definition
// Core Rule: One-wire single-ended analog voltage input; the reference is
//            the analog ground domain, shared through the power supply
//            (DC interface), so the face has no ground member. The
//            @class(analog) row attribute is the library-default signal
//            class: adopting components inherit it and may override by
//            ordinal.
// Device Definition: TRANSMITTER = sensor or signal source driving the
//                    line,
//                    RECEIVER = ADC converter or analog front-end
//                    sampling it.

interface ADC.SINGLE(role)
{
    topology = "point to point"
    mode = ["input"]
    maxdistance = 0.5m
    maxspeed = [1MSPS]
    voltage = [3.3V, 5V]
    input_range = 0V ~ voltage
    resolution = [8bit,10bit,12bit,16bit]

    pins = [
        1 = IN @class(analog)   // Single-ended analog input, referenced to analog ground
    ]

    role TRANSMITTER {  // ADC.SINGLE Transmitter - Sensor or signal source
        name = "ADC.SINGLE Transmitter"
        pins = [
            out 1 = IN @class(analog)  // The source drives the line
        ]
        peer = RECEIVER
    }
    role RECEIVER {  // ADC.SINGLE Receiver - ADC converter or analog front-end
        name = "ADC.SINGLE Receiver"
        pins = [
            in 1 = IN @class(analog)   // The converter samples the line
        ]
        peer = TRANSMITTER
    }
}
