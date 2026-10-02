# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// DAC
interface DAC(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [1MSPS]
    voltage = [3.3V, 5V]
    output_range = 0V ~ voltage
    resolution = [8bit,10bit,12bit,16bit]

    // DAC (Digital-to-Analog Converter) Standard Definition
    // Core Rule: Converts digital values to analog voltage
    // DAC Level Spec: Output voltage proportional to digital input
    // Device Definition: TRANSMITTER = the DAC analog output stage,
    //                    RECEIVER = the analog input it feeds (amp, ADC, filter)
    // Applications: Audio output, signal generation, motor control

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
