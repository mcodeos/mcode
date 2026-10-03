# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

interface CAN(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 10km
    maxspeed = [10kbps@10km, 125kbps@500m, 1Mbps@40m]
    voltage = 5V
    receiver = ±5V
    output = ±5V

    // CAN (Controller Area Network) Standard Definition
    // Core Rule: Differential signaling for robust communication in noisy environments
    // CAN Level Spec: High = CAN_H - CAN_L > 1.5V (Logic 0), Low = CAN_H - CAN_L < 0.5V (Logic 1)
    // Device Definition: Node = Any device on the CAN bus
    // Versions: CAN 2.0 (Standard/Extended), CAN FD (Flexible Data Rate)

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
