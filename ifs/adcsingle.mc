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

    // Corpus verdict (5 ADC samples: ADS7883/ADC0804-N/ADC0832-N/ADC0831/
    // AD7891): the retired rows carried no interface-level contract.
    // Distance: zero witnesses corpus-wide (folklore). Speed: per-part
    // throughput, supply-conditional (3 MSPS @ 5V tier vs 2 MSPS @ 3.3V
    // tier on ADS7883) - rides the family recipe's fsample require. Supply:
    // part/class windows (2.7~5.5V class vs fixed-5V parts), rides the DC
    // faces. Input range: every sample states one, but always referenced
    // to the part's own VCC/VREF (GND~VCC+0.05, 0~5V single-supply,
    // 0~2.5/0~5V against REF IN) - zero common absolute window; the form
    // ("0 V to the part's own reference") is the whole interface content
    // and rides the family recipe's input.v_in require. Resolution: part
    // identity, rides the family recipe's converter.resolution. No .ELEC
    // book: the electrical contract is already keyed at converter altitude
    // by the ADC.SINGLE family recipe.

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
