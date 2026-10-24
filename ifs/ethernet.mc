# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ETHERNET - Ethernet Twisted-Pair Interface Standard Definition
// Core Rule: Four twisted pairs on the 8-pin face. At 10/100M the TD pair
//            and RD pair cross between host and switch port; at gigabit
//            and above all four pairs are bidirectional.
// Device Definition: HOST = network end device (MAC/PHY),
//                    SWITCH = switch port.

interface ETHERNET(role)
{
    topology = "star"
    mode = ["full duplex"]

    // Corpus verdict (PHYs LAN8710A/DP83848/RTL8221B class; the
    // transceiver electrical axis is already keyed at the family-recipe
    // altitude -- DEV.TRANS.ETH carries supply.v_ddio and the MAC interface
    // faces): the retired rows carried no interface-level contract.
    // Distance: the 100 m figure has zero part-level witnesses
    // corpus-wide (the IEEE 802.3 specification owns the channel
    // length; the only corpus hit is a PoE app-note context). Speed:
    // the rate list is the 802.3 class labels -- spec-derived identity,
    // quoted against the standard by every PHY. Voltage: media
    // signaling is the per-part TP-PMD amplitude tables (~1 Vpp class,
    // tightly clustered but per-part) riding the magnetics face; 3.3 V
    // was the PHY supply rail class, not the signaling face. No .ELEC
    // book: the media face is keyed at the recipe altitude and the
    // channel is spec-owned.

    pins = [
        1 = TD\+ @sig.pair(td) @id.class(digital), "Transmit Data Positive"    // Positive transmit data
        2 = TD\- @sig.pair(td) @id.class(digital), "Transmit Data Negative"    // Negative transmit data
        3 = RD\+ @sig.pair(rd) @id.class(digital), "Receive Data Positive"     // Positive receive data
        4 = BI4 @sig.pair(bi45) @id.class(digital), "Bidirectional"              // Bidirectional line
        5 = BI5 @sig.pair(bi45) @id.class(digital), "Bidirectional"              // Bidirectional line
        6 = RD\- @sig.pair(rd) @id.class(digital), "Receive Data Negative"     // Negative receive data
        7 = BI7 @sig.pair(bi78) @id.class(digital), "Bidirectional"              // Bidirectional line
        8 = BI8 @sig.pair(bi78) @id.class(digital), "Bidirectional"              // Bidirectional line
    ]
    
    role HOST {
        name = "Ethernet Host"
        pins = [
            out 1 = TD\+ @sig.pair(td) @id.class(digital), "Transmit Data Positive"  // The host transmits on TD
            out 2 = TD\- @sig.pair(td) @id.class(digital), "Transmit Data Negative"
            in 3 = RD\+ @sig.pair(rd) @id.class(digital), "Receive Data Positive"    // and receives on RD
            io 4 = BI4 @sig.pair(bi45) @id.class(digital), "Bidirectional"             // Gigabit quad: all four pairs
            io 5 = BI5 @sig.pair(bi45) @id.class(digital), "Bidirectional"             // are bidirectional
            in 6 = RD\- @sig.pair(rd) @id.class(digital), "Receive Data Negative"
            io 7 = BI7 @sig.pair(bi78) @id.class(digital), "Bidirectional"
            io 8 = BI8 @sig.pair(bi78) @id.class(digital), "Bidirectional"
        ]
        peer = SWITCH
    }

    role SWITCH {
        name = "Ethernet Switch"
        pins = [
            in 1 = TD\+ @sig.pair(td) @id.class(digital), "Transmit Data Positive"   // The switch port receives the host's TD
            in 2 = TD\- @sig.pair(td) @id.class(digital), "Transmit Data Negative"
            out 3 = RD\+ @sig.pair(rd) @id.class(digital), "Receive Data Positive"   // and transmits the host's RD
            io 4 = BI4 @sig.pair(bi45) @id.class(digital), "Bidirectional"             // Gigabit quad: all four pairs
            io 5 = BI5 @sig.pair(bi45) @id.class(digital), "Bidirectional"             // are bidirectional
            out 6 = RD\- @sig.pair(rd) @id.class(digital), "Receive Data Negative"
            io 7 = BI7 @sig.pair(bi78) @id.class(digital), "Bidirectional"
            io 8 = BI8 @sig.pair(bi78) @id.class(digital), "Bidirectional"
        ]
        peer = HOST
    }
}
