# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// I2S - Inter-IC Sound Interface Standard Definition
// Core Rule: Three-wire point-to-point digital audio bus: bit clock
//            (SCK), word select (WS), and the data lane (SD). Control
//            before data is the family pin-order law (the classic I2S
//            order SCK, WS, SD). SCK/WS stay direction-less in the role
//            views — either side can be the controller — only the data
//            lane takes a direction word.
// Device Definition: TRANSMITTER = drives the data lane,
//                    RECEIVER = listens on the data lane.

interface I2S(role)
{
    topology = "point to point"
    mode = ["full duplex"]

    // Corpus verdict (7 devices: WM8731/WM8960/ES8388/CS4344/INMP441/
    // STM32F401 I2S peripheral/PCM1808): the retired rows carried no
    // interface-level contract. Distance: zero witnesses corpus-wide
    // (folklore). Speed: never stated as a distance function; the only
    // figures are per-part (64xFs clocks, the STM32 42 MHz fMCK cap, the
    // INMP441 3.2 MHz fSCK) - part spec faces. Voltage: no interface-level
    // list exists - logic levels are quoted proportional to each chip's
    // own supply (VIH 0.7xDBVDD / 0.7xIOVDD / 0.6xVA classes) and some
    // carrying parts state no logic EC table at all (ES8388); supply
    // windows ride the DC faces. No .ELEC book: zero all-sample keys
    // exist on this face; the family recipe carries the pin-order law and
    // the part spec faces carry the clocks.

    // Family pin-order law: control before data — clock, word select, then
    // the data lane (same principle as PCM's CLK, SYNC, IN, OUT).
    pins = [
        1 = SCK @id.class(digital), "Bit Clock"       // Bit clock signal
        2 = WS @id.class(digital), "Word Select"      // Channel select (left/right)
        3 = SD @id.class(digital), "Serial Data"      // Audio data
    ]
    
    // Direction words follow PCM's convention: SCK/WS stay direction-less
    // in the role views — either side can be the controller, so their
    // direction is orthogonal to the Transmitter/Receiver pairing. Only
    // the data lane gets a word.
    role TRANSMITTER {  // I2S Transmitter - Sends audio data
        name = "I2S Transmitter"
        pins = [
            1 = SCK @id.class(digital), "Bit Clock"       // Controller face — direction follows the controller
            2 = WS @id.class(digital), "Word Select"      // Controller face — direction follows the controller
            out 3 = SD @id.class(digital), "Serial Data"  // The transmitter drives the data lane
        ]
        peer = RECEIVER
    }
    role RECEIVER {  // I2S Receiver - Receives audio data
        name = "I2S Receiver"
        pins = [
            1 = SCK @id.class(digital), "Bit Clock"      // Controller face — direction follows the controller
            2 = WS @id.class(digital), "Word Select"     // Controller face — direction follows the controller
            in 3 = SD @id.class(digital), "Serial Data"  // The receiver listens on the data lane
        ]
        peer = TRANSMITTER
    }
}
