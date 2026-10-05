# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// CAN - Controller Area Network Bus Interface Standard Definition
// Core Rule: Multi-point half-duplex bus over one differential pair; the
//            dominant state (logic 0) drives CAN_H above CAN_L
//            (CAN_H - CAN_L > 1.5V), recessive (logic 1) leaves
//            CAN_H - CAN_L < 0.5V — an electrical fact of the family, not
//            a polarity the declaration carries. Any node may drive the
//            dominant state and every node reads the bus back.
// Device Definition: NODE = any CAN node (controller + transceiver);
//                    all nodes are peer-equal.

interface CAN(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 10km
    maxspeed = [10kbps@10km, 125kbps@500m, 1Mbps@40m]
    voltage = 5V
    receiver = ±5V
    output = ±5V

    // The two rows tagged @pair(can) are the two legs of one differential
    // signal; the H/L spellings are the naming convention. The dominant state
    // drives CAN_H above CAN_L — an electrical fact of the family, not a
    // polarity the declaration carries.
    pins = [
        1 = CAN_H @pair(can) @class(digital), "CAN High"    // High side of differential signal
        2 = CAN_L @pair(can) @class(digital), "CAN Low"    // Low side of differential signal
        3 = GND, "Ground"        // Signal reference ground
    ]
    
    role NODE {
        name = "CAN Node"
        pins = [
            io 1 = CAN_H @pair(can) @class(digital), "CAN High"  // Any node may drive the dominant state
            io 2 = CAN_L @pair(can) @class(digital), "CAN Low"   // and every node reads the bus back
            3 = GND, "Ground"                    // Signal reference ground
        ]
        peer = NODE
    }
}

// CAN.TTL - CAN Controller/Transceiver Link (TTL levels) Standard Definition
// Core Rule: Point-to-point serial link between one CAN controller and
//            its transceiver: the controller hands the transmit bit stream
//            to the transceiver (TXD) and takes the bus bit stream back
//            (RXD). Arbitration and bit timing stay in the controller;
//            the transceiver only translates levels, so the link itself
//            is single-ended TTL and carries no bus state. The bus face
//            (CAN_H/CAN_L) is the CAN interface, not this link.
// Device Definition: CTRL = CAN controller (bit timing, arbitration),
//                    XCVR = bus transceiver (level translation only).

interface CAN.TTL(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [1Mbps@0.5m, 500kbps@1m]
    voltage = [3.3V, 5V]

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    pins = [
        1 = _ @class(digital) // TXD <-> TXD
        2 = _ @class(digital) // RXD <-> RXD
    ]

    role CTRL {
        name = "CAN.TTL Controller"
        pins = [
            out 1 = TXD @class(digital), "Transmit bit stream to transceiver"
            in 2 = RXD @class(digital), "Receive bus bit stream from transceiver"
        ]
        peer = XCVR
    }

    role XCVR {
        name = "CAN.TTL Transceiver"
        pins = [
            in 1 = TXD @class(digital), "Transmit bit stream from controller"
            out 2 = RXD @class(digital), "Bus bit stream to controller"
        ]
        peer = CTRL
    }
}
