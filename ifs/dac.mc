# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// DAC - Digital-to-Analog Converter Output Interface Standard Definition
// Core Rule: Single-ended analog output whose voltage is proportional to
//            the digital value written; the ground reference rides the
//            power supply (no ground member on the face).
// Device Definition: TRANSMITTER = the DAC analog output stage,
//                    RECEIVER = the analog input it feeds (amp, ADC,
//                    filter).

interface DAC(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [1MSPS]
    voltage = [3.3V, 5V]
    output_range = 0V ~ voltage
    resolution = [8bit,10bit,12bit,16bit]

    pins = [
        1 = OUT @class(analog), "Analog Output"    // Analog output voltage
    ]
    
    role TRANSMITTER {  // the DAC analog output stage
        name = "DAC Transmitter"
        pins = [
            out 1 = OUT @class(analog), "Analog Output"  // The DAC drives the output
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // the analog input it feeds (amp, ADC, filter)
        name = "DAC Receiver"
        pins = [
            in 1 = OUT @class(analog), "Analog Output"   // The fed stage samples it
        ]
        peer = TRANSMITTER
    }
}
