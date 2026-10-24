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

    // Corpus verdict (6 diff-input ADC samples: ADS127L01/ADS127L11/
    // ADS131M04/ADS8588S/ADS8588H/AD7606B): the retired rows carried no
    // interface-level contract. Distance and the Mbps@distance ladder:
    // zero witnesses corpus-wide (no datasheet states a length face).
    // Speed: per-part data rates (64kSPS OSR-scaled to 800kSPS), rides
    // the part spec face. Supply: genuinely multi-rail (5V analog +
    // 1.71~3.6V drive class vs 3V class) but that is the DC face. Input
    // window: bimodal with no common value - (a) on-chip-scaled true
    // bipolar +-10/+-5V class, (b) reference-scaled FSR = +-VREF (PGA
    // gain) class; the bare +-10V row witnessed only class (a). Common-
    // mode is stated supply-relative (AVDD/2) or as abs-max bounds, never
    // absolute. If a lane book is ever forced, its lawful shape is a
    // v_in require with the value split by that class split - until then
    // the numbers ride the part spec faces and no .ELEC book exists.

    // The two rows tagged @sig.pair(p) are the two legs of one differential
    // signal; the P/N spellings are the naming convention, and the first
    // member is leg A.
    // The @id.class(analog) row attribute is the library-default signal class,
    // same as ADC.SINGLE: adopting components inherit it and may override
    // by ordinal.
    pins = [
        1 = P @id.class(analog) @sig.pair(p), "Positive Input"   // Positive differential input
        2 = N @id.class(analog) @sig.pair(p), "Negative Input"   // Negative differential input
    ]
    
    role TRANSMITTER {  // ADC.DIFF Transmitter - Sensor or signal source
        name = "ADC.DIFF Transmitter"
        pins = [
            out 1 = P @id.class(analog) @sig.pair(p), "Positive Input"   // The source drives the pair
            out 2 = N @id.class(analog) @sig.pair(p), "Negative Input"
        ]
        peer = RECEIVER(1)
    }
    role RECEIVER {  // ADC.DIFF Receiver - ADC converter
        name = "ADC.DIFF Receiver"
        pins = [
            in 1 = P @id.class(analog) @sig.pair(p), "Positive Input"    // The converter samples the pair
            in 2 = N @id.class(analog) @sig.pair(p), "Negative Input"
        ]
        peer = TRANSMITTER(1)
    }
}
