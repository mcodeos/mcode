# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// PCM - Pulse Code Modulation Audio Interface Standard Definition
// Core Rule: Digital audio link between audio CODECs and processors: bit
//            clock (CLK), frame sync (SYNC), and a data pair that flips
//            per side (ordinal k on the two sides is the same wire — one
//            side's IN is the other's OUT).
// Device Definition: TRANSMITTER = sends audio data (drives OUT,
//                    listens on IN),
//                    RECEIVER = receives audio data.

interface PCM(role)
{
    topology = "point to point"
    mode = ["full duplex"]

    // Corpus verdict (5 devices: TLV320AIC3104-Q1/TLV320AIC3204/CS42516/
    // TLV320AIC1103/CS42518): the retired rows carried no interface-level
    // contract. Distance: zero witnesses corpus-wide (folklore). Speed:
    // rates are Fs multiples (32/64/128/256xFs) or the telecom 2.048 MHz
    // PCMCLK - standard-derived or per-part, never a distance ladder;
    // TDM is slot programmability (protocol face), not electrical.
    // Voltage: logic levels are proportional to each chip's own rail
    // (VIH 0.7xIOVDD / 0.7xVLS; the telecom part states VIH = VDD) -
    // supply windows ride the DC faces. No .ELEC book: zero all-sample
    // keys exist on this face.

    // Role-less conductor view: 5 named lanes, ordinal = wire identity
    // (every name is the same on both sides). No direction words here: the
    // role tables below carry the directed views, and the data pair flips
    // per side.
    pins = [
        1 = CLK @id.class(digital), "Bit Clock"        // Bit clock signal
        2 = SYNC @id.class(digital), "Frame Sync"      // Frame synchronization signal
        3 = IN @id.class(digital), "Audio Input"       // Audio data line
        4 = OUT @id.class(digital), "Audio Output"     // Audio output line
        5 = GND, "Ground"           // Ground
    ]

    role TRANSMITTER {  // PCM Transmitter - Sends audio data
        name = "PCM Transmitter"
        pins = [
            1 = CLK @id.class(digital), "Bit Clock"        // Bit clock signal
            2 = SYNC @id.class(digital), "Frame Sync"      // Frame synchronization signal
            in 3 = IN @id.class(digital), "Audio Input"    // Audio data input (my side listens)
            out 4 = OUT @id.class(digital), "Audio Output" // Audio data output (my side drives)
            5 = GND, "Ground"           // Ground
        ]
        peer = RECEIVER
    }
    role RECEIVER {  // PCM Receiver - Receives audio data
        name = "PCM Receiver"
        pins = [
            1 = CLK @id.class(digital), "Bit Clock"        // Bit clock signal
            2 = SYNC @id.class(digital), "Frame Sync"      // Frame synchronization signal
            out 3 = IN @id.class(digital), "Audio Input"   // Same wire as the transmitter's input
            in 4 = OUT @id.class(digital), "Audio Output"  // Same wire as the transmitter's output
            5 = GND, "Ground"           // Ground
        ]
        peer = TRANSMITTER
    }
}
