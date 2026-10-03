# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ADC.SINGLE (Single-Ended Analog Input) Standard Definition
// Core Rule: One-wire single-ended analog voltage input
// 1 wire: the reference is the analog ground domain, shared through the
// power supply (DC interface), same as ADC.DIFF / UART.TTL / I2C / SPI
// (Decision Record 2, spec/19 §9 -- no ground member here).
// The @class(analog) row attribute is the library-default signal class:
// adopting components inherit it and may override by ordinal.
// Applications: sensor adoption (analog sensors), audio line-in, control loops

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
