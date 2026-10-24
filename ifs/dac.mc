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

    // Corpus verdict (7 DAC samples: DAC8551/DAC7512/TLV5638/DAC8560/
    // DAC7551/DAC081C081/MCP4921): the retired rows carried no interface-
    // level contract. Distance: zero witnesses corpus-wide (folklore).
    // Speed: per-part settling (us-class), rides the part spec face -
    // the family recipe's t_settle require is its keyed home. Supply:
    // every sample states 2.7~5.5V, but that is the supply rail face and
    // rides the DC faces. Output swing: rail-to-rail to the part's OWN
    // reference or supply - the form ("0 V to its own reference, buffer
    // rail-to-rail") is the whole interface content, the numbers are
    // per-part (internal 2.5V vs external ref vs supply-derived) and ride
    // the family recipe's output.v_out require. Resolution: part identity
    // (8/12/16bit), rides the family recipe's converter.resolution.
    // No .ELEC book: the electrical contract is already keyed at converter
    // altitude by the DEV.SIG.DAC.SINGLE family recipe - a second book on this
    // face would be the double-book the registry bans.

    pins = [
        1 = OUT @id.class(analog), "Analog Output"    // Analog output voltage
    ]
    
    role TRANSMITTER {  // the DAC analog output stage
        name = "DAC Transmitter"
        pins = [
            out 1 = OUT @id.class(analog), "Analog Output"  // The DAC drives the output
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // the analog input it feeds (amp, ADC, filter)
        name = "DAC Receiver"
        pins = [
            in 1 = OUT @id.class(analog), "Analog Output"   // The fed stage samples it
        ]
        peer = TRANSMITTER
    }
}
