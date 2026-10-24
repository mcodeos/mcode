# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// CMP - Voltage Comparator Input Interface Standard Definition
// Core Rule: One compare input PAIR into a comparator body. A comparator
//            judges a difference: the positive leg against the negative
//            leg, never one wire against an internal reference alone -
//            the reference lives inside the detector (bandgap / AVCC
//            divider) but the negative leg is still a leg of the part
//            (LM393 1IN- / 2IN-). A one-wire face cannot say that, so the
//            face carries the pair as two members, tagged @sig.pair(p) like
//            every other differential pair in the library (ADC.DIFF is
//            the sibling). The ground reference is shared through the
//            power supply (DC interface), mirroring ADC.SINGLE. The
//            comparator's result, where a part routes it to a pin, is its
//            own one-wire face: CMP.OUT (same family, datasheet VCx_OUT).
// Device Definition: SOURCE = the compared signal (sensor output,
//                    divider tap, external voltage),
//                    DETECTOR = the comparator host (the body whose
//                    internal stage judges the pair against its
//                    reference).

interface CMP(role)
{
    topology = "point to point"
    mode = ["input"]

    // Electrical contract data rides the CMP recipe face (302 3.2): the
    // comparator part-family book (input/cmode/timing/output/supply
    // groups) carries the supply tiers (supply.v_sup / abs_max.v_sup) and
    // the whole per-unit EC answer set. No distance key exists anywhere on
    // the recipe face (zero of nine sheets state one; the retired
    // maxdistance tier was folklore, forensics log).

    pins = [
        1 = INP @id.class(analog) @sig.pair(p), "Positive Compare Input"   // Compare input, positive leg (datasheet IN+ / VCINx)
        2 = INN @id.class(analog) @sig.pair(p), "Negative Compare Input"   // Compare input, negative leg (datasheet IN-)
    ]

    role SOURCE {
        name = "CMP Source"
        pins = [
            out 1 = INP @id.class(analog) @sig.pair(p)   // The compared signal drives the positive leg
            out 2 = INN @id.class(analog) @sig.pair(p)   // The compared signal drives the negative leg
        ]
        peer = DETECTOR(1)
    }

    role DETECTOR {
        name = "CMP Detector"
        pins = [
            in 1 = INP @id.class(analog) @sig.pair(p)    // The comparator samples the positive leg
            in 2 = INN @id.class(analog) @sig.pair(p)    // The comparator samples the negative leg
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

    // Same recipe routing as CMP: supply tiers ride the part supply face;
    // the result wire is a digital output line, distance retires
    // (zero corpus statements), and the output EC answer set (out_kind /
    // vo_sw / i_out) lives on the recipe output group.

    pins = [
        1 = OUT @id.class(digital)   // Compare result (datasheet VCx_OUT)
    ]

    role TRANSMITTER {
        name = "CMP.OUT Transmitter"
        pins = [
            out 1 = OUT @id.class(digital)   // The comparator drives the result
        ]
        peer = RECEIVER
    }

    role RECEIVER {
        name = "CMP.OUT Receiver"
        pins = [
            in 1 = OUT @id.class(digital)    // The consumer reads the result
        ]
        peer = TRANSMITTER(1)
    }
}

// Example usage:
// MCU side (comparator input channel pin pair):
//     io [2, 3] = VCIN7{INP, INN}::CMP(DETECTOR), ["P01/VCIN7"]
// MCU side (comparator result pin):
//     io 8 = VC0_OUT::CMP.OUT(TRANSMITTER), ["P15/VC0_OUT"]
// Sensor side (the compared signal):
//     out 3 = CMP::CMP(SOURCE), ["SensorOut"]
