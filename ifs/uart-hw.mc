# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// UART.TTL.HW - UART Interface (TTL levels, hardware flow control) Standard Definition
// Core Rule: Point-to-point full-duplex serial link over a crossed data
//            pair (TX <-> RX) plus a crossed handshake pair (RTS <-> CTS);
//            ground is shared through the power domain, no ground member.
//            Level windows are device truth -- they belong on the
//            component's own pin rows, and the role names stay level-free.
// Device Definition: DCE = data communications equipment
//                    (cross-connects to DTE),
//                    DTE = data terminal equipment.
// Note: this iface is the hardware-flow-control sibling of UART.TTL
//       (mcode/ifs/uart.mc); 2-wire UART.TTL stays a separate family
//       for the 2-wire-only case. The brace member order on the pack
//       side must match the DCE/DTE role pin tables below; the mcc
//       engine's role-sweep gate enforces this when the matching role
//       entry is registered in the role-sweep table.

interface UART.TTL.HW(role)
{
    topology = "point to point"
    mode = ["full duplex"]

    // Electrical contract data (bus envelope: distance/speed caps, supply
    // tiers, receiver/output level windows) rides the UART.TTL.HW.ELEC
    // recipe face (302 3.2); this definition carries structure only.

    // Role-less conductor view: 4 anonymous lanes, ordinal = wire identity
    // (Mediated devices and module ports bind role-less and take their
    // shape from this table; the role tables below carry the named
    // views: the data pair crosses by position (TX <-> RX) and the
    // handshake pair crosses by position (RTS <-> CTS)).
    pins = [
        1 = _ @class(digital) // TX <-> RX
        2 = _ @class(digital) // RX <-> TX
        3 = _ @class(digital) // CTS <-> RTS
        4 = _ @class(digital) // RTS <-> CTS
    ]

    role DCE {
        name = "UART.TTL.HW DCE"
        pins = [
            out 1 = TX  @class(digital) @cross(DTE.RX), "Transmit"          // Cross-connect to DTE RX
            in  2 = RX  @class(digital) @cross(DTE.TX), "Receive"           // Cross-connect to DTE TX
            in  3 = CTS @class(digital) @cross(DTE.RTS), "Clear To Send"     // Cross-connect to DTE RTS
            out 4 = RTS @class(digital) @cross(DTE.CTS), "Request To Send"   // Cross-connect to DTE CTS
        ]
        peer = DTE(1)
    }

    // DTE role: cross-connects to DCE (level judging per pin row, see DCE).
    role DTE {
        name = "UART.TTL.HW DTE"
        pins = [
            in  1 = RX  @class(digital) @cross(DCE.TX), "Receive"           // Cross-connect to DCE TX
            out 2 = TX  @class(digital) @cross(DCE.RX), "Transmit"          // Cross-connect to DCE RX
            out 3 = RTS @class(digital) @cross(DCE.CTS), "Request To Send"   // Cross-connect to DCE CTS
            in  4 = CTS @class(digital) @cross(DCE.RTS), "Clear To Send"     // Cross-connect to DCE RTS
        ]
        peer = DCE(1)
    }

    // Relay face: the cable's conductor
    // view -- inherits the role-less table above (4 anonymous lanes) and
    // selects no endpoint role. A cable module binds
    // `io a::UART.TTL.HW(RELAY)` on each end and states its crossing or
    // straight join in the body.
    role RELAY {
        name = "UART.TTL.HW Relay"
    }
}
