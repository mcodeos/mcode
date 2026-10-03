# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

interface UART.TTL(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 15m
    maxspeed = [9.6kbps@15m, 115.2kbps@5m, 1Mbps@1m]
    voltage = [1.8V,3.3V,5V]
    receiver = ["0V ~ 1.8V", "0V ~ 3.3V", "0V ~ 5V"]
    output = ["0V ~ 1.8V", "0V ~ 3.3V", "0V ~ 5V"]

    // UART.TTL Standard Definition
    // Core Rule: Point-to-point serial communication using TTL voltage levels
    // 2-wire (TX/RX), GND shared through power domain — same as I2C/SPI
    // TTL Level Spec:
    //   1.8V TTL: High = 1.2V ~ 1.8V (Logic 1), Low = 0V ~ 0.4V (Logic 0)
    //   3.3V TTL: High = 2V ~ 3.3V (Logic 1), Low = 0V ~ 0.8V (Logic 0)
    //   5V TTL: High = 2V ~ 5V (Logic 1), Low = 0V ~ 0.8V (Logic 0)
    // Device Definition: DCE = Data Communications Equipment, DTE = Data Terminal Equipment

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1). Mediated devices and module ports bind
    // role-less and take their shape from this table; the role tables below
    // carry the named views: the data pair crosses by position (TX <-> RX).
    pins = [
        1 = _ @class(digital) // TX <-> RX
        2 = _ @class(digital) // RX <-> TX
    ]

    // DCE role: cross-connects to DTE. Level windows are device truth — they
    // belong on the component's own pin rows (or a protocol-fixed row like
    // RS-232), and ERC judges them per net (E4124); the role name stays
    // level-free.
    role DCE {
        name = "UART.TTL DCE"
        pins = [
            out 1 = TX @class(digital), "Transmit"  // Cross-connect to DTE RX
            in 2 = RX @class(digital), "Receive"   // Cross-connect to DTE TX
        ]
        peer = DTE(1)
    }

    // DTE role: cross-connects to DCE (level judging per pin row, see DCE).
    role DTE {
        name = "UART.TTL DTE"
        pins = [
            in 1 = RX @class(digital), "Receive"           // Cross-connect to DCE TX
            out 2 = TX @class(digital), "Transmit"          // Cross-connect to DCE RX
        ]
        peer = DCE(1)
    }

    // Relay face (iface-peer-cardinality-design.md §4): the cable's conductor
    // view — inherits the role-less table above (2 anonymous lanes) and
    // selects no endpoint role. A cable module binds
    // `io a::UART.TTL(RELAY)` on each end and states its crossing or
    // straight join in the body.
    role RELAY {
        name = "UART TTL Relay"
    }
}

interface UART.RS232.3(role)
{
    topology = "point to point"
    mode = ["half duplex", "full duplex"]
    maxdistance = 15m
    receiver = ±15V
    output = ±25V

    // EIA-RS-232C Standard Pin Definition - 3-Pin (Basic Transmit & Receive Only)
    // Core Rule: DTE ↔ DCE - Cross-connect for data/handshake/flow control pins, direct-connect for status pins & GND
    // RS232 Level Spec: High = +3V ~ +15V (Logic 0), Low = -15V ~ -3V (Logic 1), GND = no level param (signal reference)
    // Device Definition: DCE = Data Communications Equipment (central/peripheral device), DTE = Data Terminal Equipment (master/terminal device)
    // Peer Rule: Each DCE role is paired with the corresponding DTE role, mutual peer association for standard matching
    // Variant note: RS232 splits into per-variant interfaces (.3/.5/.9) — the
    // variants share a name family, not a conductor view (conductor-view-design.md R-CV3)

    // Role-less conductor view: 3 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _ @class(digital) // RXD <-> TXD
        2 = _ @class(digital) // TXD <-> RXD
        3 = _ // GND
    ]

    role DCE {  // RS232.3 DCE - basic TX/RX function only
        name = "RS232.3 DCE"
        pins = [
            in 1 = RXD @class(digital), "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]  // Cross-connect to DTE Pin1 TXD
            out 2 = TXD @class(digital), "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V] // Cross-connect to DTE Pin2 RXD
            3 = GND, "Signal Ground"                                    // Direct connect to DTE Pin3 GND, signal reference ground
        ]
        peer = DTE(1)  // Paired with terminal device DTE
    }

    role DTE {  // RS232.3 DTE - basic TX/RX function only
        name = "RS232.3 DTE"
        pins = [
            out 1 = TXD @class(digital), "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V] // Cross-connect to DCE Pin1 RXD
            in 2 = RXD @class(digital), "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]  // Cross-connect to DCE Pin2 TXD
            3 = GND, "Signal Ground"                                    // Direct connect to DCE Pin3 GND, signal reference ground
        ]
        peer = DCE(1)  // Paired with communication device DCE
    }
}

interface UART.RS232.5(role)
{
    topology = "point to point"
    mode = ["half duplex", "full duplex"]
    maxdistance = 15m
    receiver = ±15V
    output = ±25V

    // EIA-RS-232C Standard Pin Definition - 5-Pin (TX/RX + RTS/CTS Hardware Flow Control)
    // Core Rule: DTE ↔ DCE - Cross-connect for data/handshake/flow control pins, direct-connect for status pins & GND
    // RS232 Level Spec: High = +3V ~ +15V (Logic 0), Low = -15V ~ -3V (Logic 1), GND = no level param (signal reference)
    // Device Definition: DCE = Data Communications Equipment (central/peripheral device), DTE = Data Terminal Equipment (master/terminal device)
    // Peer Rule: Each DCE role is paired with the corresponding DTE role, mutual peer association for standard matching

    // Role-less conductor view: 5 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _ @class(digital) // RXD <-> TXD
        2 = _ @class(digital) // TXD <-> RXD
        3 = _ // GND
        4 = _ @class(digital) // RTS <-> CTS
        5 = _ @class(digital) // CTS <-> RTS
    ]

    role DCE {  // RS232.5 DCE - TX/RX + RTS/CTS hardware flow control
        name = "RS232.5 DCE"
        pins = [
            in 1 = RXD @class(digital), "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Cross-connect to DTE Pin1 TXD
            out 2 = TXD @class(digital), "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DTE Pin2 RXD
            3 = GND, "Signal Ground"                                          // Direct connect to DTE Pin3 GND, signal reference ground
            in 4 = RTS @class(digital), "Request to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]      // Cross-connect to DTE Pin4 CTS, hardware flow control
            out 5 = CTS @class(digital), "Clear to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DTE Pin5 RTS, hardware flow control
        ]
        peer = DTE(1)  // Paired with terminal device DTE
    }

    role DTE {  // RS232.5 DTE - TX/RX + RTS/CTS hardware flow control
        name = "RS232.5 DTE"
        pins = [
            out 1 = TXD @class(digital), "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DCE Pin1 RXD
            in 2 = RXD @class(digital), "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Cross-connect to DCE Pin2 TXD
            3 = GND, "Signal Ground"                                          // Direct connect to DCE Pin3 GND, signal reference ground
            in 4 = CTS @class(digital), "Clear to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DCE Pin4 RTS, hardware flow control
            out 5 = RTS @class(digital), "Request to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]      // Cross-connect to DCE Pin5 CTS, hardware flow control
        ]
        peer = DCE(1)  // Paired with communication device DCE
    }
}

interface UART.RS232.9(role)
{
    topology = "point to point"
    mode = ["half duplex", "full duplex"]
    maxdistance = 15m
    receiver = ±15V
    output = ±25V

    // EIA-RS-232C Standard Pin Definition - 9-Pin (EIA-RS-232C Standard Full Function Version)
    // Core Rule: DTE ↔ DCE - Cross-connect for data/handshake/flow control pins, direct-connect for status pins & GND
    // RS232 Level Spec: High = +3V ~ +15V (Logic 0), Low = -15V ~ -3V (Logic 1), GND = no level param (signal reference)
    // Device Definition: DCE = Data Communications Equipment (central/peripheral device), DTE = Data Terminal Equipment (master/terminal device)
    // Peer Rule: Each DCE role is paired with the corresponding DTE role, mutual peer association for standard matching

    // Role-less conductor view: 9 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _ @class(digital) // DCD
        2 = _ @class(digital) // RXD <-> TXD
        3 = _ @class(digital) // TXD <-> RXD
        4 = _ @class(digital) // DTR <-> DSR
        5 = _ // GND
        6 = _ @class(digital) // DSR <-> DTR
        7 = _ @class(digital) // RTS <-> CTS
        8 = _ @class(digital) // CTS <-> RTS
        9 = _ @class(digital) // RI
    ]

    role DCE {  // RS232.9 DCE - EIA-RS-232C full function
        name = "RS232.9 DCE (EIA-RS-232C)"
        pins = [
            out 1 = DCD @class(digital),  "Data Carrier Detect", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]   // Direct connect to DTE Pin1 DCD, status indicator
            in 2 = RXD @class(digital),  "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]          // Cross-connect to DTE Pin2 TXD, core data receive
            out 3 = TXD @class(digital),  "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]         // Cross-connect to DTE Pin3 RXD, core data transmit
            in 4 = DTR @class(digital),  "Data Terminal Ready", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]   // Cross-connect to DTE Pin4 DSR, device handshake
            5 = GND,  "Signal Ground"                                            // Direct connect to DTE Pin5 GND, signal reference ground
            out 6 = DSR @class(digital),  "Data Set Ready", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Cross-connect to DTE Pin6 DTR, device handshake
            in 7 = RTS @class(digital),  "Request to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DTE Pin7 CTS, hardware flow control
            out 8 = CTS @class(digital),  "Clear to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]         // Cross-connect to DTE Pin8 RTS, hardware flow control
            out 9 = RI @class(digital),   "Ring Indicator", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Direct connect to DTE Pin9 RI, status indicator
        ]
        peer = DTE(1)  // Paired with terminal device DTE
    }

    role DTE {  // RS232.9 DTE - EIA-RS-232C full function
        name = "RS232.9 DTE (EIA-RS-232C)"
        pins = [
            in 1 = DCD @class(digital),  "Data Carrier Detect", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]   // Direct connect to DCE Pin1 DCD, status indicator
            out 2 = TXD @class(digital),  "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]         // Cross-connect to DCE Pin2 RXD, core data transmit
            in 3 = RXD @class(digital),  "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]          // Cross-connect to DCE Pin3 TXD, core data receive
            in 4 = DSR @class(digital),  "Data Set Ready", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Cross-connect to DCE Pin4 DTR, device handshake
            5 = GND,  "Signal Ground"                                            // Direct connect to DCE Pin5 GND, signal reference ground
            out 6 = DTR @class(digital),  "Data Terminal Ready", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]   // Cross-connect to DCE Pin6 DSR, device handshake
            in 7 = CTS @class(digital),  "Clear to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]         // Cross-connect to DCE Pin7 RTS, hardware flow control
            out 8 = RTS @class(digital),  "Request to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DCE Pin8 CTS, hardware flow control
            in 9 = RI @class(digital),   "Ring Indicator", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Direct connect to DCE Pin9 RI, status indicator
        ]
        peer = DCE(1)  // Paired with communication device DCE
    }
}

interface UART.RS422(role)
{
    topology = "multi-point"
    mode = ["full duplex"]
    maxdistance = 1200m
    maxspeed = [100kbps@1200m, 1Mbps@100m, 10Mbps@10m]
    receiver = ±7V
    output = ±5V

    // EIA-RS-422 Standard Definition
    // Core Rule: Balanced differential signaling for noise immunity, multi-point capability (1 transmitter, multiple receivers)
    // RS422 Level Spec: High = +2V ~ +6V (Logic 1), Low = -6V ~ -2V (Logic 0)
    // Device Definition: TRANSMITTER = drives the A/B pair, RECEIVER = receives it
    // Variant note: the 2-wire variant (A/B only, no GND) is UART.RS422.2 — the
    // variants share a name family, not a conductor view (conductor-view-design.md R-CV3)

    // Role-less conductor view: 3 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _ @class(digital) // A
        2 = _ @class(digital) // B
        3 = _ // GND
    ]

    // -------------------------- RS422 Transmitter --------------------------
    role TRANSMITTER {  // Sends balanced differential signals
        name = "RS422 Transmitter"
        pins = [
            out 1 = A @pair(ab) @class(digital), "Transmit Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]  // Positive differential signal
            out 2 = B @pair(ab) @class(digital), "Transmit Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]  // Negative differential signal (inverted A)
            3 = GND, "Signal Ground"                                    // Signal reference ground
        ]
        peer = RECEIVER  // Paired with RS422 Receiver
    }

    // -------------------------- RS422 Receiver --------------------------
    role RECEIVER {  // Receives balanced differential signals
        name = "RS422 Receiver"
        pins = [
            in 1 = A @pair(ab) @class(digital), "Receive Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Positive differential signal
            in 2 = B @pair(ab) @class(digital), "Receive Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]   // Negative differential signal (inverted A)
            3 = GND, "Signal Ground"                                   // Signal reference ground
        ]
        peer = TRANSMITTER  // Paired with RS422 Transmitter
    }
}

interface UART.RS422.2(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 1200m
    maxspeed = [100kbps@1200m, 1Mbps@100m, 10Mbps@10m]
    receiver = ±7V
    output = ±5V

    // EIA-RS-422 Standard Definition - 2-Wire variant (A/B only, no GND), same-cabinet use
    // Core Rule: Balanced differential signaling for noise immunity, multi-point capability (1 transmitter, multiple receivers)
    // RS422 Level Spec: High = +2V ~ +6V (Logic 1), Low = -6V ~ -2V (Logic 0)
    // Device Definition: TRANSMITTER = drives the A/B pair, RECEIVER = receives it

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _ @class(digital) // A
        2 = _ @class(digital) // B
    ]

    role TRANSMITTER {  // Sends balanced differential signals
        name = "RS422.2 Transmitter"
        pins = [
            out 1 = A @pair(ab) @class(digital), "Transmit Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]
            out 2 = B @pair(ab) @class(digital), "Transmit Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // Receives balanced differential signals
        name = "RS422.2 Receiver"
        pins = [
            in 1 = A @pair(ab) @class(digital), "Receive Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]
            in 2 = B @pair(ab) @class(digital), "Receive Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]
        ]
        peer = TRANSMITTER
    }
}

interface UART.RS423(role)
{
    topology = "point to point"
    mode = ["half duplex", "full duplex"]
    maxdistance = 1200m
    maxspeed = [100kbps@1200m, 1Mbps@100m, 10Mbps@10m]
    receiver = ±7V
    output = ±5V

    // EIA-RS-423 Standard Definition
    // Core Rule: Unbalanced differential signaling, point-to-point only (1 transmitter, 1 receiver)
    // RS423 Level Spec: High = +2V ~ +6V (Logic 1), Low = -6V ~ -2V (Logic 0)
    // Device Definition: DCE = Data Communications Equipment, DTE = Data Terminal Equipment

    // Role-less conductor view: 5 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _ @class(digital) // RXD <-> TXD
        2 = _ @class(digital) // TXD <-> RXD
        3 = _ // GND
        4 = _ @class(digital) // RTS <-> CTS
        5 = _ @class(digital) // CTS <-> RTS
    ]

    // -------------------------- RS423 DCE --------------------------
    role DCE {  // RS423 DCE - Data Communications Equipment
        name = "RS423 DCE"
        pins = [
            in 1 = RXD @class(digital), "Receive Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]  // Cross-connect to DTE RXD
            out 2 = TXD @class(digital), "Transmit Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V] // Cross-connect to DTE TXD
            3 = GND, "Signal Ground"                                    // Signal reference ground
            in 4 = RTS @class(digital), "Request to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]  // Cross-connect to DTE CTS
            out 5 = CTS @class(digital), "Clear to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Cross-connect to DTE RTS
        ]
        peer = DTE(1)  // Paired with RS423 DTE
    }

    // -------------------------- RS423 DTE --------------------------
    role DTE {  // RS423 DTE - Data Terminal Equipment
        name = "RS423 DTE"
        pins = [
            out 1 = TXD @class(digital), "Transmit Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Cross-connect to DCE RXD
            in 2 = RXD @class(digital), "Receive Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]    // Cross-connect to DCE TXD
            3 = GND, "Signal Ground"                                   // Signal reference ground
            in 4 = CTS @class(digital), "Clear to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Cross-connect to DCE RTS
            out 5 = RTS @class(digital), "Request to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]  // Cross-connect to DCE CTS
        ]
        peer = DCE(1)  // Paired with RS423 DCE
    }
}

interface UART.RS449(role)
{
    topology = "point to point"
    mode = ["half duplex", "full duplex"]
    maxdistance = 1200m
    maxspeed = [100kbps@1200m, 1Mbps@100m, 10Mbps@10m]
    receiver = ±7V
    output = ±5V

    // EIA-RS-449 Standard Definition
    // Core Rule: Enhanced RS232 with higher speed and distance, supports both balanced and unbalanced signaling
    // RS449 Level Spec: High = +2V ~ +6V (Logic 1), Low = -6V ~ -2V (Logic 0)
    // Device Definition: DCE = Data Communications Equipment, DTE = Data Terminal Equipment
    // Connector: 37-pin (primary) or 9-pin (secondary)
    // Pin-order law: an interface that models a specific physical connector
    // mirrors that connector's numbering (RS232.9 = DE-9; USB; SDIO). RS449
    // models the functional standard, not the ISO 4902 connector, so this
    // table is functional order by design - the 37-pin numbering is not mirrored.

    // Role-less conductor view: 16 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _ @class(digital) // SD <-> RD
        2 = _ @class(digital) // RD <-> SD
        3 = _ @class(digital) // RS <-> CS
        4 = _ @class(digital) // CS <-> RS
        5 = _ @class(digital) // DR <-> CD
        6 = _ @class(digital) // CD <-> DR
        7 = _ @class(digital) // TM <-> TT
        8 = _ @class(digital) // TT <-> TM
        9 = _ @class(digital) // RT (timing)
        10 = _ @class(digital) // SG
        11 = _    // SD2 <-> RD2 (secondary @class(digital), optional)
        12 = _    // RD2 <-> SD2 (secondary @class(digital), optional)
        13 = _    // RS2 <-> CS2 (secondary @class(digital), optional)
        14 = _    // CS2 <-> RS2 (secondary @class(digital), optional)
        15 = _    // DR2 <-> CD2 (secondary @class(digital), optional)
        16 = _    // CD2 <-> DR2 (secondary @class(digital), optional)
    ]

    // -------------------------- RS449 DCE --------------------------
    role DCE {  // RS449 DCE - Data Communications Equipment
        name = "RS449 DCE"
        pins = [
            // Primary Data Pins
            in 1 = SD @class(digital), "Send Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]         // Cross-connect to DTE RD
            out 2 = RD @class(digital), "Receive Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DTE SD
            in 3 = RS @class(digital), "Request to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DTE CS
            out 4 = CS @class(digital), "Clear to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DTE RS
            out 5 = DR @class(digital), "Data Ready", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]          // Cross-connect to DTE CD
            out 6 = CD @class(digital), "Carrier Detect", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DTE DR
            in 7 = TM @class(digital), "Transmit Clock", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DTE TT
            out 8 = TT @class(digital), "Terminal Timing", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DTE TM
            out 9 = RT @class(digital), "Receive Timing", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DTE RT
            10 = SG @class(digital), "Signal Ground"                                       // Signal reference ground

            // Secondary Data Pins (Optional)
            in 11 = SD2 @class(digital), "Send Data 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DTE RD2
            out 12 = RD2 @class(digital), "Receive Data 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DTE SD2
            in 13 = RS2 @class(digital), "Request to Send 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Cross-connect to DTE CS2
            out 14 = CS2 @class(digital), "Clear to Send 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DTE RS2
            out 15 = DR2 @class(digital), "Data Ready 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]        // Cross-connect to DTE CD2
            out 16 = CD2 @class(digital), "Carrier Detect 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]    // Cross-connect to DTE DR2
        ]
        peer = DTE(1)  // Paired with RS449 DTE
    }

    // -------------------------- RS449 DTE --------------------------
    role DTE {  // RS449 DTE - Data Terminal Equipment
        name = "RS449 DTE"
        pins = [
            // Primary Data Pins
            in 1 = RD @class(digital), "Receive Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DCE SD
            out 2 = SD @class(digital), "Send Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]         // Cross-connect to DCE RD
            in 3 = CS @class(digital), "Clear to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DCE RS
            out 4 = RS @class(digital), "Request to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DCE CS
            in 5 = CD @class(digital), "Carrier Detect", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DCE DR
            in 6 = DR @class(digital), "Data Ready", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]          // Cross-connect to DCE CD
            out 7 = TT @class(digital), "Terminal Timing", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DCE TM
            in 8 = TM @class(digital), "Transmit Clock", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DCE TT
            in 9 = RT @class(digital), "Receive Timing", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DCE RT
            10 = SG @class(digital), "Signal Ground"                                       // Signal reference ground

            // Secondary Data Pins (Optional)
            in 11 = RD2 @class(digital), "Receive Data 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DCE SD2
            out 12 = SD2 @class(digital), "Send Data 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DCE RD2
            in 13 = CS2 @class(digital), "Clear to Send 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DCE RS2
            out 14 = RS2 @class(digital), "Request to Send 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Cross-connect to DCE CS2
            in 15 = CD2 @class(digital), "Carrier Detect 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]    // Cross-connect to DCE DR2
            out 16 = DR2 @class(digital), "Data Ready 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]        // Cross-connect to DCE CD2
        ]
        peer = DCE(1)  // Paired with RS449 DCE
    }
}

interface UART.RS485.3(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 1200m
    maxspeed = [100kbps@1200m, 1Mbps@100m, 10Mbps@10m]
    receiver = ±7V
    output = ±5V

    // EIA/TI-RS-485 Standard Definition
    // Core Rule: Multi-point balanced differential signaling, supports multiple nodes on a single bus
    // RS485 Level Spec: High = +2V ~ +6V (Logic 1), Low = -6V ~ -2V (Logic 0)
    // Device Definition: MASTER = Controls the bus, SLAVE = Responds to master
    // Bus Configuration: 1 master, multiple slaves (up to 32 nodes)
    // Variant note: the common 2-wire variant (A/B only, no GND) is the base
    // family name UART.RS485; this 3-wire member (A/B + GND) is UART.RS485.3 — the
    // variants share a name family, not a conductor view (conductor-view-design.md R-CV3).

    // Role-less conductor view: 3 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _ @class(digital) // A
        2 = _ @class(digital) // B
        3 = _ // GND
    ]

    // -------------------------- RS485 Master --------------------------
    role MASTER {  // RS485 Master - Controls the bus
        name = "RS485 Master"
        pins = [
            io 1 = A @pair(ab) @class(digital), "Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]  // Positive differential signal
            io 2 = B @pair(ab) @class(digital), "Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]  // Negative differential signal (inverted A)
            3 = GND, "Signal Ground"                           // Signal reference ground
        ]
        peer = SLAVE  // Paired with RS485 Slave
    }

    // -------------------------- RS485 Slave --------------------------
    role SLAVE {  // RS485 Slave - Responds to master
        name = "RS485 Slave"
        pins = [
            io 1 = A @pair(ab) @class(digital), "Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Positive differential signal
            io 2 = B @pair(ab) @class(digital), "Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]   // Negative differential signal (inverted A)
            3 = GND, "Signal Ground"                           // Signal reference ground
        ]
        peer = MASTER  // Paired with RS485 Master
    }
}

interface UART.RS485(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 1200m
    maxspeed = [100kbps@1200m, 1Mbps@100m, 10Mbps@10m]
    receiver = ±7V
    output = ±5V

    // EIA/TI-RS-485 Standard Definition - 2-Wire variant (A/B only, no GND), same-cabinet use
    // Variant note: the base family name UART.RS485 is the common 2-wire form; the
    // 3-wire member (A/B + GND) is UART.RS485.3.
    // Core Rule: Multi-point balanced differential signaling, supports multiple nodes on a single bus
    // RS485 Level Spec: High = +2V ~ +6V (Logic 1), Low = -6V ~ -2V (Logic 0)
    // Device Definition: MASTER = Controls the bus, SLAVE = Responds to master
    // Bus Configuration: 1 master, multiple slaves (up to 32 nodes)

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _ @class(digital) // A
        2 = _ @class(digital) // B
    ]

    role MASTER {  // RS485 Master - Controls the bus
        name = "RS485 Master"
        pins = [
            io 1 = A @pair(ab) @class(digital), "Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]
            io 2 = B @pair(ab) @class(digital), "Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]
        ]
        peer = SLAVE
    }

    role SLAVE {  // RS485 Slave - Responds to master
        name = "RS485 Slave"
        pins = [
            io 1 = A @pair(ab) @class(digital), "Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]
            io 2 = B @pair(ab) @class(digital), "Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]
        ]
        peer = MASTER
    }
}
