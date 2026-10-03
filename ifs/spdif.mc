# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// S/PDIF (Sony/Philips Digital Interface) Standard Definition
// Core Rule: single-wire consumer digital audio link, biphase-mark coded
// Physical media: 75 Ohm coax (with ground through the DC/power interface) or
// optical (TOSLINK; the optical module sits on the device face, this interface
// stays electrical)
// Applications: DAC links, TV / amplifier digital audio, S/PDIF passthrough

interface SPDIF(role)
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 10m  // coax; optical longer
    maxspeed = [12.3Mbps]  // 192 kHz * 64 bit frame worst case
    voltage = [3.3V, 5V]  // logic-side levels; coax swing ~1Vpp into 75 Ohm

    pins = [
        1 = SIG @class(digital), "Serial digital audio signal"
    ]

    role TRANSMITTER {
        name = "S/PDIF Transmitter"
        pins = [
            out 1 = SIG @class(digital), "Serial digital audio signal"  // The transmitter drives the link
        ]
        peer = RECEIVER(1)
    }
    role RECEIVER {
        name = "S/PDIF Receiver"
        pins = [
            in 1 = SIG @class(digital), "Serial digital audio signal"   // The receiver decodes it
        ]
        peer = TRANSMITTER(1)
    }
}
