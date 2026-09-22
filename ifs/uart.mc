# Copyright 2026 MCode
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
        1 = _    // TX <-> RX
        2 = _    // RX <-> TX
    ]

    // DCE Roles for different voltage levels
    role DCE {
        name = "UART.TTL DCE"
        pins = [
            1 = TX, "Transmit"  // Cross-connect to DTE RX
            2 = RX, "Receive"   // Cross-connect to DTE TX
        ]
        peer = DTE
    }
    
    // DCE Roles for different voltage levels
    role DCE_1V8 {  // UART.TTL DCE - 1.8V Data Communications Equipment
        name = "UART.TTL DCE 1.8V"
        pins = [
            1 = TX, "Transmit", voltage:[low:0V ~ 0.4V, high:1.2V ~ 1.8V]  // Cross-connect to DTE_1V8 RX
            2 = RX, "Receive", voltage:[low:0V ~ 0.4V, high:1.2V ~ 1.8V]  // Cross-connect to DTE_1V8 TX
        ]
        peer = DTE_1V8
    }
    
    role DCE_3V3 {  // UART.TTL DCE - 3.3V Data Communications Equipment
        name = "UART.TTL DCE 3.3V"
        pins = [
            1 = TX, "Transmit", voltage:[low:0V ~ 0.8V, high:2V ~ 3.3V]  // Cross-connect to DTE_3V3 RX
            2 = RX, "Receive", voltage:[low:0V ~ 0.8V, high:2V ~ 3.3V]  // Cross-connect to DTE_3V3 TX
        ]
        peer = DTE_3V3
    }
    
    role DCE_5V {  // UART.TTL DCE - 5V Data Communications Equipment
        name = "UART.TTL DCE 5V"
        pins = [
            1 = TX, "Transmit", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Cross-connect to DTE_5V RX
            2 = RX, "Receive", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Cross-connect to DTE_5V TX
        ]
        peer = DTE_5V
    }
    
    // DTE Roles for different voltage levels
    role DTE {
        name = "UART.TTL DTE"
        pins = [ 
            1 = RX, "Receive"           // Cross-connect to DCE TX
            2 = TX, "Transmit"          // Cross-connect to DCE RX
        ]
        peer = DCE
    }
    
    // DTE Roles for different voltage levels
    role DTE_1V8 {  // UART.TTL DTE - 1.8V Data Terminal Equipment
        name = "UART.TTL DTE 1.8V"
        pins = [ 
            1 = RX, "Receive", voltage:[low:0V ~ 0.4V, high:1.2V ~ 1.8V]  // Cross-connect to DCE_1V8 TX
            2 = TX, "Transmit", voltage:[low:0V ~ 0.4V, high:1.2V ~ 1.8V]  // Cross-connect to DCE_1V8 RX
        ]
        peer = DCE_1V8
    }
    
    role DTE_3V3 {  // UART.TTL DTE - 3.3V Data Terminal Equipment
        name = "UART.TTL DTE 3.3V"
        pins = [ 
            1 = RX, "Receive", voltage:[low:0V ~ 0.8V, high:2V ~ 3.3V]  // Cross-connect to DCE_3V3 TX
            2 = TX, "Transmit", voltage:[low:0V ~ 0.8V, high:2V ~ 3.3V]  // Cross-connect to DCE_3V3 RX
        ]
        peer = DCE_3V3
    }
    
    role DTE_5V {  // UART.TTL DTE - 5V Data Terminal Equipment
        name = "UART.TTL DTE 5V"
        pins = [ 
            1 = RX, "Receive", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Cross-connect to DCE_5V TX
            2 = TX, "Transmit", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Cross-connect to DCE_5V RX
        ]
        peer = DCE_5V
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
        1 = _    // RXD <-> TXD
        2 = _    // TXD <-> RXD
        3 = _    // GND
    ]

    role DCE {  // RS232.3 DCE - basic TX/RX function only
        name = "RS232.3 DCE"
        pins = [
            1 = RXD, "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]  // Cross-connect to DTE Pin1 TXD
            2 = TXD, "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V] // Cross-connect to DTE Pin2 RXD
            3 = GND, "Signal Ground"                                    // Direct connect to DTE Pin3 GND, signal reference ground
        ]
        peer = DTE  // Paired with terminal device DTE
    }

    role DTE {  // RS232.3 DTE - basic TX/RX function only
        name = "RS232.3 DTE"
        pins = [
            1 = TXD, "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V] // Cross-connect to DCE Pin1 RXD
            2 = RXD, "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]  // Cross-connect to DCE Pin2 TXD
            3 = GND, "Signal Ground"                                    // Direct connect to DCE Pin3 GND, signal reference ground
        ]
        peer = DCE  // Paired with communication device DCE
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
        1 = _    // RXD <-> TXD
        2 = _    // TXD <-> RXD
        3 = _    // GND
        4 = _    // RTS <-> CTS
        5 = _    // CTS <-> RTS
    ]

    role DCE {  // RS232.5 DCE - TX/RX + RTS/CTS hardware flow control
        name = "RS232.5 DCE"
        pins = [
            1 = RXD, "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Cross-connect to DTE Pin1 TXD
            2 = TXD, "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DTE Pin2 RXD
            3 = GND, "Signal Ground"                                          // Direct connect to DTE Pin3 GND, signal reference ground
            4 = RTS, "Request to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]      // Cross-connect to DTE Pin4 CTS, hardware flow control
            5 = CTS, "Clear to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DTE Pin5 RTS, hardware flow control
        ]
        peer = DTE  // Paired with terminal device DTE
    }

    role DTE {  // RS232.5 DTE - TX/RX + RTS/CTS hardware flow control
        name = "RS232.5 DTE"
        pins = [
            1 = TXD, "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DCE Pin1 RXD
            2 = RXD, "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Cross-connect to DCE Pin2 TXD
            3 = GND, "Signal Ground"                                          // Direct connect to DCE Pin3 GND, signal reference ground
            4 = CTS, "Clear to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DCE Pin4 RTS, hardware flow control
            5 = RTS, "Request to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]      // Cross-connect to DCE Pin5 CTS, hardware flow control
        ]
        peer = DCE  // Paired with communication device DCE
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
        1 = _    // DCD
        2 = _    // RXD <-> TXD
        3 = _    // TXD <-> RXD
        4 = _    // DTR <-> DSR
        5 = _    // GND
        6 = _    // DSR <-> DTR
        7 = _    // RTS <-> CTS
        8 = _    // CTS <-> RTS
        9 = _    // RI
    ]

    role DCE {  // RS232.9 DCE - EIA-RS-232C full function
        name = "RS232.9 DCE (EIA-RS-232C)"
        pins = [
            1 = DCD,  "Data Carrier Detect", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]   // Direct connect to DTE Pin1 DCD, status indicator
            2 = RXD,  "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]          // Cross-connect to DTE Pin2 TXD, core data receive
            3 = TXD,  "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]         // Cross-connect to DTE Pin3 RXD, core data transmit
            4 = DTR,  "Data Terminal Ready", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]   // Cross-connect to DTE Pin4 DSR, device handshake
            5 = GND,  "Signal Ground"                                            // Direct connect to DTE Pin5 GND, signal reference ground
            6 = DSR,  "Data Set Ready", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Cross-connect to DTE Pin6 DTR, device handshake
            7 = RTS,  "Request to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DTE Pin7 CTS, hardware flow control
            8 = CTS,  "Clear to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]         // Cross-connect to DTE Pin8 RTS, hardware flow control
            9 = RI,   "Ring Indicator", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Direct connect to DTE Pin9 RI, status indicator
        ]
        peer = DTE  // Paired with terminal device DTE
    }

    role DTE {  // RS232.9 DTE - EIA-RS-232C full function
        name = "RS232.9 DTE (EIA-RS-232C)"
        pins = [
            1 = DCD,  "Data Carrier Detect", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]   // Direct connect to DCE Pin1 DCD, status indicator
            2 = TXD,  "Transmit Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]         // Cross-connect to DCE Pin2 RXD, core data transmit
            3 = RXD,  "Receive Data", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]          // Cross-connect to DCE Pin3 TXD, core data receive
            4 = DSR,  "Data Set Ready", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Cross-connect to DCE Pin4 DTR, device handshake
            5 = GND,  "Signal Ground"                                            // Direct connect to DCE Pin5 GND, signal reference ground
            6 = DTR,  "Data Terminal Ready", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]   // Cross-connect to DCE Pin6 DSR, device handshake
            7 = CTS,  "Clear to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]         // Cross-connect to DCE Pin7 RTS, hardware flow control
            8 = RTS,  "Request to Send", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]       // Cross-connect to DCE Pin8 CTS, hardware flow control
            9 = RI,   "Ring Indicator", voltage:[low:-15V ~ -3V, high:+3V ~ +15V]        // Direct connect to DCE Pin9 RI, status indicator
        ]
        peer = DCE  // Paired with communication device DCE
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
    // Device Definition: TX = Transmitter, RX = Receiver
    // Variant note: the 2-wire variant (A/B only, no GND) is UART.RS422.2 — the
    // variants share a name family, not a conductor view (conductor-view-design.md R-CV3)

    // Role-less conductor view: 3 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _    // A
        2 = _    // B
        3 = _    // GND
    ]

    // -------------------------- RS422 Transmitter --------------------------
    role TX {  // RS422 Transmitter - Sends balanced differential signals
        name = "RS422 Transmitter"
        pins = [
            1 = A, "Transmit Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]  // Positive differential signal
            2 = B, "Transmit Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]  // Negative differential signal (inverted A)
            3 = GND, "Signal Ground"                                    // Signal reference ground
        ]
        peer = RX  // Paired with RS422 Receiver
    }

    // -------------------------- RS422 Receiver --------------------------
    role RX {  // RS422 Receiver - Receives balanced differential signals
        name = "RS422 Receiver"
        pins = [
            1 = A, "Receive Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Positive differential signal
            2 = B, "Receive Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]   // Negative differential signal (inverted A)
            3 = GND, "Signal Ground"                                   // Signal reference ground
        ]
        peer = TX  // Paired with RS422 Transmitter
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
    // Device Definition: TX = Transmitter, RX = Receiver

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _    // A
        2 = _    // B
    ]

    role TX {  // RS422.2 Transmitter - Sends balanced differential signals
        name = "RS422.2 Transmitter"
        pins = [
            1 = A, "Transmit Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]
            2 = B, "Transmit Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]
        ]
        peer = RX
    }

    role RX {  // RS422.2 Receiver - Receives balanced differential signals
        name = "RS422.2 Receiver"
        pins = [
            1 = A, "Receive Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]
            2 = B, "Receive Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]
        ]
        peer = TX
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
        1 = _    // RXD <-> TXD
        2 = _    // TXD <-> RXD
        3 = _    // GND
        4 = _    // RTS <-> CTS
        5 = _    // CTS <-> RTS
    ]

    // -------------------------- RS423 DCE --------------------------
    role DCE {  // RS423 DCE - Data Communications Equipment
        name = "RS423 DCE"
        pins = [
            1 = RXD, "Receive Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]  // Cross-connect to DTE RXD
            2 = TXD, "Transmit Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V] // Cross-connect to DTE TXD
            3 = GND, "Signal Ground"                                    // Signal reference ground
            4 = RTS, "Request to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]  // Cross-connect to DTE CTS
            5 = CTS, "Clear to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Cross-connect to DTE RTS
        ]
        peer = DTE  // Paired with RS423 DTE
    }

    // -------------------------- RS423 DTE --------------------------
    role DTE {  // RS423 DTE - Data Terminal Equipment
        name = "RS423 DTE"
        pins = [
            1 = TXD, "Transmit Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Cross-connect to DCE RXD
            2 = RXD, "Receive Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]    // Cross-connect to DCE TXD
            3 = GND, "Signal Ground"                                   // Signal reference ground
            4 = CTS, "Clear to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Cross-connect to DCE RTS
            5 = RTS, "Request to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]  // Cross-connect to DCE CTS
        ]
        peer = DCE  // Paired with RS423 DCE
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

    // Role-less conductor view: 16 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _     // SD <-> RD
        2 = _     // RD <-> SD
        3 = _     // RS <-> CS
        4 = _     // CS <-> RS
        5 = _     // DR <-> CD
        6 = _     // CD <-> DR
        7 = _     // TM <-> TT
        8 = _     // TT <-> TM
        9 = _     // RT (timing)
        10 = _    // SG
        11 = _    // SD2 <-> RD2 (secondary, optional)
        12 = _    // RD2 <-> SD2 (secondary, optional)
        13 = _    // RS2 <-> CS2 (secondary, optional)
        14 = _    // CS2 <-> RS2 (secondary, optional)
        15 = _    // DR2 <-> CD2 (secondary, optional)
        16 = _    // CD2 <-> DR2 (secondary, optional)
    ]

    // -------------------------- RS449 DCE --------------------------
    role DCE {  // RS449 DCE - Data Communications Equipment
        name = "RS449 DCE"
        pins = [
            // Primary Data Pins
            1 = SD, "Send Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]         // Cross-connect to DTE RD
            2 = RD, "Receive Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DTE SD
            3 = RS, "Request to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DTE CS
            4 = CS, "Clear to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DTE RS
            5 = DR, "Data Ready", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]          // Cross-connect to DTE CD
            6 = CD, "Carrier Detect", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DTE DR
            7 = TM, "Transmit Clock", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DTE TT
            8 = TT, "Terminal Timing", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DTE TM
            9 = RT, "Receive Timing", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DTE RT
            10 = SG, "Signal Ground"                                       // Signal reference ground

            // Secondary Data Pins (Optional)
            11 = SD2, "Send Data 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DTE RD2
            12 = RD2, "Receive Data 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DTE SD2
            13 = RS2, "Request to Send 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Cross-connect to DTE CS2
            14 = CS2, "Clear to Send 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DTE RS2
            15 = DR2, "Data Ready 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]        // Cross-connect to DTE CD2
            16 = CD2, "Carrier Detect 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]    // Cross-connect to DTE DR2
        ]
        peer = DTE  // Paired with RS449 DTE
    }

    // -------------------------- RS449 DTE --------------------------
    role DTE {  // RS449 DTE - Data Terminal Equipment
        name = "RS449 DTE"
        pins = [
            // Primary Data Pins
            1 = RD, "Receive Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DCE SD
            2 = SD, "Send Data", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]         // Cross-connect to DCE RD
            3 = CS, "Clear to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DCE RS
            4 = RS, "Request to Send", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DCE CS
            5 = CD, "Carrier Detect", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DCE DR
            6 = DR, "Data Ready", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]          // Cross-connect to DCE CD
            7 = TT, "Terminal Timing", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DCE TM
            8 = TM, "Transmit Clock", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DCE TT
            9 = RT, "Receive Timing", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]      // Cross-connect to DCE RT
            10 = SG, "Signal Ground"                                       // Signal reference ground

            // Secondary Data Pins (Optional)
            11 = RD2, "Receive Data 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DCE SD2
            12 = SD2, "Send Data 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]       // Cross-connect to DCE RD2
            13 = CS2, "Clear to Send 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]     // Cross-connect to DCE RS2
            14 = RS2, "Request to Send 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Cross-connect to DCE CS2
            15 = CD2, "Carrier Detect 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]    // Cross-connect to DCE DR2
            16 = DR2, "Data Ready 2", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]        // Cross-connect to DCE CD2
        ]
        peer = DCE  // Paired with RS449 DCE
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
    // Device Definition: Master = Controls the bus, Slave = Responds to master
    // Bus Configuration: 1 master, multiple slaves (up to 32 nodes)
    // Variant note: the common 2-wire variant (A/B only, no GND) is the base
    // family name UART.RS485; this 3-wire member (A/B + GND) is UART.RS485.3 — the
    // variants share a name family, not a conductor view (conductor-view-design.md R-CV3).

    // Role-less conductor view: 3 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _    // A
        2 = _    // B
        3 = _    // GND
    ]

    // -------------------------- RS485 Master --------------------------
    role Master {  // RS485 Master - Controls the bus
        name = "RS485 Master"
        pins = [
            1 = A, "Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]  // Positive differential signal
            2 = B, "Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]  // Negative differential signal (inverted A)
            3 = GND, "Signal Ground"                           // Signal reference ground
        ]
        peer = Slave  // Paired with RS485 Slave
    }

    // -------------------------- RS485 Slave --------------------------
    role Slave {  // RS485 Slave - Responds to master
        name = "RS485 Slave"
        pins = [
            1 = A, "Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]   // Positive differential signal
            2 = B, "Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]   // Negative differential signal (inverted A)
            3 = GND, "Signal Ground"                           // Signal reference ground
        ]
        peer = Master  // Paired with RS485 Master
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
    // Device Definition: Master = Controls the bus, Slave = Responds to master
    // Bus Configuration: 1 master, multiple slaves (up to 32 nodes)

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _    // A
        2 = _    // B
    ]

    role Master {  // RS485 Master - Controls the bus
        name = "RS485 Master"
        pins = [
            1 = A, "Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]
            2 = B, "Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]
        ]
        peer = Slave
    }

    role Slave {  // RS485 Slave - Responds to master
        name = "RS485 Slave"
        pins = [
            1 = A, "Data A", voltage:[low:-6V ~ -2V, high:+2V ~ +6V]
            2 = B, "Data B", voltage:[low:+2V ~ +6V, high:-6V ~ -2V]
        ]
        peer = Master
    }
}
