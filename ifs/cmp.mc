# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// CMP - Voltage Comparator Input Interface Standard Definition
// Core Rule: One compare input wire into a comparator body. The input
//            channel is a muxed analog sense wire (datasheets name the
//            pin function VCINx; the shorthand VCx on some pin tables is
//            the same function). The comparator's reference lives inside
//            the detector (bandgap / AVCC divider), so the face carries
//            no reference member - the ground reference is shared
//            through the power supply (DC interface), mirroring
//            ADC.SINGLE. The comparator's result, where a part routes it
//            to a pin, is its own one-wire face: CMP.OUT (same family,
//            datasheet VCx_OUT).
// Device Definition: SOURCE = the compared signal (sensor output,
//                    divider tap, external voltage),
//                    DETECTOR = the comparator host (the body whose
//                    internal stage judges IN against its reference).

interface CMP(role)
{
    topology = "point to point"
    mode = ["input"]
    maxdistance = 0.5m
    voltage = [1.8V, 3.3V, 5V]

    pins = [
        1 = IN @class(analog)   // Compare input (datasheet VCINx)
    ]

    role SOURCE {
        name = "CMP Source"
        pins = [
            out 1 = IN @class(analog)   // The compared signal drives the line
        ]
        peer = DETECTOR
    }

    role DETECTOR {
        name = "CMP Detector"
        pins = [
            in 1 = IN @class(analog)    // The comparator samples the line
        ]
        peer = SOURCE(1)
    }
}

// CMP.OUT - Comparator Result Output Interface Standard Definition
// Core Rule: One result wire out of a comparator body (datasheet
//            VCx_OUT). Kept as its own face rather than a second member
//            of CMP because parts route the result to a pin of the same
//            body only sometimes, and an adoption maps every member - a
//            one-wire face per wire keeps input-only and output-only
//            pins adoptable without phantom wiring.
// Device Definition: TRANSMITTER = the comparator host driving the
//                    result,
//                    RECEIVER = the consumer of the compare result
//                    (interrupt logic, external input).

interface CMP.OUT(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.5m
    voltage = [1.8V, 3.3V, 5V]

    pins = [
        1 = OUT @class(digital)   // Compare result (datasheet VCx_OUT)
    ]

    role TRANSMITTER {
        name = "CMP.OUT Transmitter"
        pins = [
            out 1 = OUT @class(digital)   // The comparator drives the result
        ]
        peer = RECEIVER
    }

    role RECEIVER {
        name = "CMP.OUT Receiver"
        pins = [
            in 1 = OUT @class(digital)    // The consumer reads the result
        ]
        peer = TRANSMITTER(1)
    }
}

// Example usage:
// MCU side (comparator input channel pin):
//     io 2 = VCIN7::CMP(DETECTOR), ["P01/VCIN7"]
// MCU side (comparator result pin):
//     io 8 = VC0_OUT::CMP.OUT(TRANSMITTER), ["P15/VC0_OUT"]
// Sensor side (the compared signal):
//     out 3 = CMP::CMP(SOURCE), ["SensorOut"]
