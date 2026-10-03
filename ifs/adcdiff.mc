# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ADC.DIFF (Differential ADC) Standard Definition
// Core Rule: Differential analog-to-digital converter interface for high-precision measurements
// Differential Input: Measures the voltage difference between P (positive) and N (negative) inputs
// Advantage: Rejects common-mode noise, improves signal-to-noise ratio
// Applications: Sensor measurements, audio, industrial control systems
// 2-wire (P/N): the ground reference is the analog ground domain, shared
// through the power supply (DC interface), same as UART.TTL / I2C / SPI.

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
    // same as ADC.SINGLE: adopting components inherit it and may override by
    // ordinal.
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
