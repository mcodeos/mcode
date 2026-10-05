# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// SENT - Single Edge Nibble Transmission Sensor Interface Standard Definition
// Core Rule: Unidirectional point-to-point sensor link on one wire: the
//            sensor encodes each data nibble as a drop-pause edge pattern
//            (tick-based, 12-28 ticks per nibble) and frames each sample
//            as sync + data nibbles + CRC; the receiver measures the edge
//            intervals against its tick reference. No clock line; the
//            sensor is powered from its own supply pin, not this face.
// Device Definition: TRANSMITTER = the sensor (drives SIG),
//                    RECEIVER = the ECU (times SIG edges).

interface SENT(role)
{
    topology = "point to point"
    mode = ["half duplex"]
    voltage = 5V

    pins = [
        1 = SIG @class(digital), "Signal line (single-wire)"    // drop-pause nibble encoding
    ]

    role TRANSMITTER {
        name = "SENT Sensor"
        pins = [
            out 1 = SIG @class(digital), "Signal line (single-wire)"
        ]
        peer = RECEIVER
    }

    role RECEIVER {
        name = "SENT ECU"
        pins = [
            in 1 = SIG @class(digital), "Signal line (single-wire)"
        ]
        peer = TRANSMITTER
    }
}

// SENT.SPC - SENT with Short PWM Code Trigger Standard Definition
// Core Rule: SENT plus the reverse-channel trigger: in short PWM code
//            mode the ECU drives SPC (a PWM trigger/command) toward the
//            sensor while the sensor keeps answering on SIG - the two
//            wires make the link bidirectional.
// Device Definition: TRANSMITTER = the sensor (drives SIG, samples SPC),
//                    RECEIVER = the ECU (times SIG, drives SPC).

interface SENT.SPC(role)
{
    topology = "point to point"
    mode = ["half duplex"]
    voltage = 5V

    pins = [
        1 = SIG @class(digital), "Signal line (sensor to ECU)"
        2 = SPC @class(digital), "Short PWM Code trigger (ECU to sensor)"
    ]

    role TRANSMITTER {
        name = "SENT.SPC Sensor"
        pins = [
            out 1 = SIG @class(digital), "Signal line"
            in 2 = SPC @class(digital), "Short PWM Code trigger"
        ]
        peer = RECEIVER
    }

    role RECEIVER {
        name = "SENT.SPC ECU"
        pins = [
            in 1 = SIG @class(digital), "Signal line"
            out 2 = SPC @class(digital), "Short PWM Code trigger"
        ]
        peer = TRANSMITTER
    }
}
