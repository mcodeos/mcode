# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// MII - Media Independent Interface Standard Definition
// Core Rule: Nibble-wide MAC-to-PHY data bus. Both clocks are sourced by
//            the PHY (TX_CLK/RX_CLK are PHY outputs, 25MHz at 100M,
//            2.5MHz at 10M) and the MAC samples data to them. TX_ER
//            (optional) propagates transmit errors; CRS/COL are the
//            half-duplex carrier sense / collision detect.
// Device Definition: MAC = media access controller (in the MCU/SoC),
//                    PHY = physical layer device.

interface MII(role)
{
    topology = "point to point"
    mode = ["full duplex", "half duplex"]  // CRS/COL carry meaning in half duplex
    maxdistance = 0.1m  // PCB trace only
    maxspeed = [2.5MHz@0.1m, 25MHz@0.1m]  // 10BASE-T / 100BASE-TX nibble clock
    voltage = [1.8V, 2.5V, 3.3V]  // I/O ring follows VDDIO

    pins = [
        1 = TX_CLK @class(digital), "Transmit Clock (PHY drives)"      // 25MHz / 2.5MHz continuous
        2 = TXD0 @class(digital), "Transmit Data Bit 0"                // MAC samples to TX_CLK
        3 = TXD1 @class(digital), "Transmit Data Bit 1"
        4 = TXD2 @class(digital), "Transmit Data Bit 2"
        5 = TXD3 @class(digital), "Transmit Data Bit 3"
        6 = TX_EN @class(digital), "Transmit Enable"
        7 = TX_ER @class(digital), "Transmit Error (optional)"         // optional signal
        8 = RX_CLK @class(digital), "Receive Clock (PHY drives)"       // recovered or reference-derived
        9 = RXD0 @class(digital), "Receive Data Bit 0"                 // MAC samples to RX_CLK
        10 = RXD1 @class(digital), "Receive Data Bit 1"
        11 = RXD2 @class(digital), "Receive Data Bit 2"
        12 = RXD3 @class(digital), "Receive Data Bit 3"
        13 = RX_DV @class(digital), "Receive Data Valid"
        14 = RX_ER @class(digital), "Receive Error"
        15 = CRS @class(digital), "Carrier Sense (half duplex)"        // asserted on medium non-idle
        16 = COL @class(digital), "Collision Detect (half duplex)"
    ]

    role MAC {
        name = "Ethernet MAC"
        pins = [
            in 1 = TX_CLK @class(digital), "Transmit Clock (PHY drives)"   // The MAC sources no clock; it samples to the PHY's
            out 2 = TXD0 @class(digital), "Transmit Data Bit 0"
            out 3 = TXD1 @class(digital), "Transmit Data Bit 1"
            out 4 = TXD2 @class(digital), "Transmit Data Bit 2"
            out 5 = TXD3 @class(digital), "Transmit Data Bit 3"
            out 6 = TX_EN @class(digital), "Transmit Enable"
            out 7 = TX_ER @class(digital), "Transmit Error (optional)"
            in 8 = RX_CLK @class(digital), "Receive Clock (PHY drives)"
            in 9 = RXD0 @class(digital), "Receive Data Bit 0"
            in 10 = RXD1 @class(digital), "Receive Data Bit 1"
            in 11 = RXD2 @class(digital), "Receive Data Bit 2"
            in 12 = RXD3 @class(digital), "Receive Data Bit 3"
            in 13 = RX_DV @class(digital), "Receive Data Valid"
            in 14 = RX_ER @class(digital), "Receive Error"
            in 15 = CRS @class(digital), "Carrier Sense (half duplex)"
            in 16 = COL @class(digital), "Collision Detect (half duplex)"
        ]
        peer = PHY
    }

    role PHY {
        name = "Ethernet PHY"
        pins = [
            out 1 = TX_CLK @class(digital), "Transmit Clock (PHY drives)"  // The PHY sources both clocks
            in 2 = TXD0 @class(digital), "Transmit Data Bit 0"
            in 3 = TXD1 @class(digital), "Transmit Data Bit 1"
            in 4 = TXD2 @class(digital), "Transmit Data Bit 2"
            in 5 = TXD3 @class(digital), "Transmit Data Bit 3"
            in 6 = TX_EN @class(digital), "Transmit Enable"
            in 7 = TX_ER @class(digital), "Transmit Error (optional)"
            out 8 = RX_CLK @class(digital), "Receive Clock (PHY drives)"
            out 9 = RXD0 @class(digital), "Receive Data Bit 0"
            out 10 = RXD1 @class(digital), "Receive Data Bit 1"
            out 11 = RXD2 @class(digital), "Receive Data Bit 2"
            out 12 = RXD3 @class(digital), "Receive Data Bit 3"
            out 13 = RX_DV @class(digital), "Receive Data Valid"
            out 14 = RX_ER @class(digital), "Receive Error"
            out 15 = CRS @class(digital), "Carrier Sense (half duplex)"
            out 16 = COL @class(digital), "Collision Detect (half duplex)"
        ]
        peer = MAC
    }
}

// RMII - Reduced Media Independent Interface Standard Definition
// Core Rule: Reduced 2-bit data bus on one continuous 50MHz REF_CLK
//            (±50ppm) sourced by the MAC/system side and consumed by the
//            PHY as an input; both directions sample to it. CRS_DV
//            multiplexes carrier sense into the receive path, asserting
//            asynchronously on carrier and deasserting synchronous to
//            REF_CLK. RX_ER is optional at the MAC.
// Device Definition: MAC = media access controller,
//                    PHY = physical layer device.

interface RMII(role)
{
    topology = "point to point"
    mode = ["full duplex", "half duplex"]  // CRS_DV multiplexes carrier sense into the receive path
    maxdistance = 0.1m  // PCB trace only
    maxspeed = [50MHz@0.1m]  // fixed 50MHz REF_CLK, both directions sampled to it
    voltage = [1.8V, 2.5V, 3.3V]  // I/O ring follows VDDIO

    pins = [
        1 = REF_CLK @class(digital), "Reference Clock 50MHz (system drives)"  // continuous, shared by both directions
        2 = TXD0 @class(digital), "Transmit Data Bit 0"                       // MAC samples to REF_CLK
        3 = TXD1 @class(digital), "Transmit Data Bit 1"
        4 = TX_EN @class(digital), "Transmit Enable"
        5 = RXD0 @class(digital), "Receive Data Bit 0"                        // valid on REF_CLK rising edge
        6 = RXD1 @class(digital), "Receive Data Bit 1"
        7 = RX_ER @class(digital), "Receive Error (optional at MAC)"
        8 = CRS_DV @class(digital), "Carrier Sense / Receive Data Valid"
    ]

    role MAC {
        name = "Ethernet MAC"
        pins = [
            out 1 = REF_CLK @class(digital), "Reference Clock 50MHz (system drives)"  // The system side sources the shared clock
            out 2 = TXD0 @class(digital), "Transmit Data Bit 0"
            out 3 = TXD1 @class(digital), "Transmit Data Bit 1"
            out 4 = TX_EN @class(digital), "Transmit Enable"
            in 5 = RXD0 @class(digital), "Receive Data Bit 0"
            in 6 = RXD1 @class(digital), "Receive Data Bit 1"
            in 7 = RX_ER @class(digital), "Receive Error (optional at MAC)"
            in 8 = CRS_DV @class(digital), "Carrier Sense / Receive Data Valid"
        ]
        peer = PHY
    }

    role PHY {
        name = "Ethernet PHY"
        pins = [
            in 1 = REF_CLK @class(digital), "Reference Clock 50MHz (system drives)"   // The PHY never drives REF_CLK
            in 2 = TXD0 @class(digital), "Transmit Data Bit 0"
            in 3 = TXD1 @class(digital), "Transmit Data Bit 1"
            in 4 = TX_EN @class(digital), "Transmit Enable"
            out 5 = RXD0 @class(digital), "Receive Data Bit 0"
            out 6 = RXD1 @class(digital), "Receive Data Bit 1"
            out 7 = RX_ER @class(digital), "Receive Error (optional at MAC)"
            out 8 = CRS_DV @class(digital), "Carrier Sense / Receive Data Valid"
        ]
        peer = MAC
    }
}
