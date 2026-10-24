# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// LIN - Local Interconnect Network Bus Interface Standard Definition
// Core Rule: Low-cost single-wire (plus ground) multi-point bus at 12V
//            for vehicle body electronics; the master controls the
//            schedule and both sides time-share the wire, either one
//            driving a response slot.
// Device Definition: MASTER = controls the bus schedule,
//                    SLAVE = body-electronics node.

interface LIN(role)
{
    topology = "multi-point"
    mode = ["half duplex"]

    // Corpus verdict (LIN 2.x / SAE J2602 class; transceiver contract
    // already keyed at the family-recipe altitude -- DEV.TRANS.LIN carries
    // bus rate (20 kbaud class), v_bus, v_th, and the v_bb battery
    // supply window): the three retired rows route there or die.
    // Speed: the 20 kbps row is the DEV.TRANS.LIN rate key's value domain,
    // not an interface envelope. Voltage: 12 V is the VBAT domain --
    // the battery window is DEV.TRANS.LIN v_bb, the node supply windows ride
    // the DC faces. Distance: the 40 m figure has zero corpus
    // witnesses (the LIN specification owns any cable face). No .ELEC
    // book: the bus electrical face is already keyed at the recipe
    // altitude -- a second book on the same face would be a double
    // book.

    pins = [
        1 = LIN @id.class(digital), "Data"    // Single wire data line
        2 = GND, "Ground"  // Signal reference ground
    ]
    
    role MASTER {
        name = "LIN Master"
        pins = [
            io 1 = LIN @id.class(digital), "Data"  // Master and slaves time-share the wire — either side may drive a response
            2 = GND, "Ground"   // Signal reference ground
        ]
        peer = SLAVE
    }

    role SLAVE {
        name = "LIN Slave"
        pins = [
            io 1 = LIN @id.class(digital), "Data"  // Master and slaves time-share the wire — either side may drive a response
            2 = GND, "Ground"   // Signal reference ground
        ]
        peer = MASTER
    }
}
