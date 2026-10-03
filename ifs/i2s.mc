# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

interface I2S(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 5m
    maxspeed = [8Mbps@5m, 16Mbps@2m, 32Mbps@1m]
    voltage = [1.8V,3.3V,5V]

    // I2S (Inter-IC Sound) Standard Definition
    // Core Rule: Three-wire digital audio bus for connecting audio devices
    // I2S Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: TRANSMITTER = Sends audio data, RECEIVER = Receives audio data
    // Audio Format: Supports various sample rates and bit depths

    // Family pin-order law: control before data — clock, word select, then the
    // data lane (same principle as PCM's CLK, SYNC, IN, OUT; matches the
    // Philips document order SCK, WS, SD).
    pins = [
        1 = SCK @class(digital), "Bit Clock"       // Bit clock signal
        2 = WS @class(digital), "Word Select"      // Channel select (left/right)
        3 = SD @class(digital), "Serial Data"      // Audio data
    ]
    
    // Direction words follow the PCM ruling: SCK/WS stay direction-less in the
    // role views — either side can be the controller, so their direction is
    // orthogonal to the Transmitter/Receiver pairing. Only the data lane gets
    // a word.
    role TRANSMITTER {  // I2S Transmitter - Sends audio data
        name = "I2S Transmitter"
        pins = [
            1 = SCK @class(digital), "Bit Clock"       // Controller face — direction follows the controller
            2 = WS @class(digital), "Word Select"      // Controller face — direction follows the controller
            out 3 = SD @class(digital), "Serial Data"  // The transmitter drives the data lane
        ]
        peer = RECEIVER
    }
    role RECEIVER {  // I2S Receiver - Receives audio data
        name = "I2S Receiver"
        pins = [
            1 = SCK @class(digital), "Bit Clock"      // Controller face — direction follows the controller
            2 = WS @class(digital), "Word Select"     // Controller face — direction follows the controller
            in 3 = SD @class(digital), "Serial Data"  // The receiver listens on the data lane
        ]
        peer = TRANSMITTER
    }
}
