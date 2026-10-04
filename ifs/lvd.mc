# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// LVD - Low-Voltage Detection Input Interface Standard Definition
// Core Rule: One monitored voltage wire into the detector body. The
//            monitored wire is a high-impedance analog sense input; the
//            board drives it from the rail directly or through a
//            divider. The threshold lives inside the detector (bandgap
//            reference), so the face carries no reference member - the
//            ground reference is shared through the power supply (DC
//            interface). The detector's alarm output, where a part
//            routes it to a pin, is its own one-wire face: LVD.OUT
//            (datasheet LVD_OUT).
// Device Definition: SOURCE = the monitored rail (direct or via
//                    divider tap),
//                    DETECTOR = the low-voltage detector body (judges
//                    IN against its internal threshold).

interface LVD(role)
{
    topology = "point to point"
    mode = ["input"]
    maxdistance = 0.5m
    voltage = [1.8V, 3.3V, 5V]

    pins = [
        1 = IN @class(analog)   // Monitored voltage sense input (datasheet LVDINx)
    ]

    role SOURCE {
        name = "LVD Source"
        pins = [
            out 1 = IN @class(analog)   // The monitored rail drives the sense wire
        ]
        peer = DETECTOR
    }

    role DETECTOR {
        name = "LVD Detector"
        pins = [
            in 1 = IN @class(analog)    // The detector senses the rail
        ]
        peer = SOURCE(1)
    }
}

// LVD.OUT - Low-Voltage Alarm Output Interface Standard Definition
// Core Rule: One alarm/detection wire out of the detector body
//            (datasheet LVD_OUT). Kept as its own face rather than a
//            second member of LVD because parts route the alarm to a pin
//            only sometimes, and an adoption maps every member - a
//            one-wire face per wire keeps input-only and output-only
//            pins adoptable without phantom wiring.
// Device Definition: TRANSMITTER = the detector body driving the alarm,
//                    RECEIVER = the consumer of the alarm (interrupt
//                    logic, external input).

interface LVD.OUT(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.5m
    voltage = [1.8V, 3.3V, 5V]

    pins = [
        1 = OUT @class(digital)   // Detection result (datasheet LVD_OUT)
    ]

    role TRANSMITTER {
        name = "LVD.OUT Transmitter"
        pins = [
            out 1 = OUT @class(digital)   // The detector drives the alarm
        ]
        peer = RECEIVER
    }

    role RECEIVER {
        name = "LVD.OUT Receiver"
        pins = [
            in 1 = OUT @class(digital)    // The consumer reads the alarm
        ]
        peer = TRANSMITTER(1)
    }
}

// Example usage:
// MCU side (monitored-voltage pin):
//     io 7 = LVDIN1::LVD(DETECTOR), ["P15/LVDIN1"]
// MCU side (alarm output pin):
//     io 8 = LVD_OUT::LVD.OUT(TRANSMITTER), ["P15/LVD_OUT"]
// Rail side (direct or via divider):
//     out 1 = LVD::LVD(SOURCE), ["RailSense"]
