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

# Universal Serial Bus

// ---------------------------------------------------------------------------------------------
// USB Base Interface
// ---------------------------------------------------------------------------------------------

interface USB(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 5m
    maxspeed = [1.5Mbps@5m, 12Mbps@5m, 480Mbps@3m]
    voltage = 5V
    current = 500mA  // Default current (USB 2.0)

    // USB (Universal Serial Bus) Standard Definition
    // Core Rule: Universal serial bus for connecting peripherals to computers
    // USB Level Spec: Differential signaling, D+ and D- lines
    // Device Definition: Host = Controls the bus, Peripheral = Peripheral device
    // Versions: USB 1.1 (Low/Full Speed), USB 2.0 (High Speed), USB 3.0 (SuperSpeed)

    pins = [
        [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
        [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]
    ]
    
    role Host {
        name = "USB Host"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = Host
    }

}

// ---------------------------------------------------------------------------------------------
// USB 2.0 Variants
// ---------------------------------------------------------------------------------------------

// USB 2.0 Type A Connector
interface USB.TYPEA(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 5m
    maxspeed = [1.5Mbps@5m, 12Mbps@5m, 480Mbps@3m]
    voltage = 5V
    current = 500mA  // USB 2.0 current
    name = "USB 2.0 Type A"
    description = "Standard rectangular connector, typically used on hosts"
    
    pins = [
        [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
        [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]
    ]

    role Host {
        name = "USB Host"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = Host
    }

}

// USB 2.0 Type B Connector
interface USB.TYPEB(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 5m
    maxspeed = [1.5Mbps@5m, 12Mbps@5m, 480Mbps@3m]
    voltage = 5V
    current = 500mA  // USB 2.0 current
    name = "USB 2.0 Type B"
    description = "Squarish connector, typically used on devices"
    
    pins = [
        [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
        [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]
    ]

    role Host {
        name = "USB Host"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = Host
    }

}

// USB 2.0 Mini Type B Connector
interface USB.MINIB(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 5m
    maxspeed = [1.5Mbps@5m, 12Mbps@5m, 480Mbps@3m]
    voltage = 5V
    current = 500mA  // USB 2.0 current
    name = "USB 2.0 Mini Type B"
    description = "Smaller connector for portable devices"
    
    pins = [
        [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
        [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]
        4 = ID, "ID"                // Identification pin (for OTG)
    ]

    role Host {
        name = "USB Host"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID, "ID"                // Cable sense: the plug grounds it (OTG)
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID, "ID"                // Cable sense: the plug grounds it (OTG)
        ]
        peer = Host
    }

}

// USB 2.0 Micro Type B Connector
interface USB.MICROB(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 5m
    maxspeed = [1.5Mbps@5m, 12Mbps@5m, 480Mbps@3m]
    voltage = 5V
    current = 500mA  // USB 2.0 current
    name = "USB 2.0 Micro Type B"
    description = "Even smaller connector for mobile devices"
    
    pins = [
        [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
        [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]
        4 = ID, "ID"                // Identification pin (for OTG)
    ]

    role Host {
        name = "USB Host"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID, "ID"                // Cable sense: the plug grounds it (OTG)
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID, "ID"                // Cable sense: the plug grounds it (OTG)
        ]
        peer = Host
    }

}

// ---------------------------------------------------------------------------------------------
// USB 3.x Variants
// ---------------------------------------------------------------------------------------------

// USB 3.x Type A Connector
interface USB3.TYPEA(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 3m
    maxspeed = [5Gbps@3m]  // SuperSpeed
    voltage = 5V
    current = 900mA  // USB 3.0 current
    name = "USB 3.x Type A"
    description = "USB 3.x Type A connector with additional SuperSpeed pins"
    
    pins = [
        // USB 2.0 pins (backward compatibility)
        [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
        [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]

        // USB 3.x additional pins (Standard-A receptacle is the host side:
        // the host receives on SSRX 5/6 and transmits on SSTX 8/9)
        5 = SSRX\-, "SuperSpeed RX Negative"  // SuperSpeed receive negative
        6 = SSRX\+, "SuperSpeed RX Positive"  // SuperSpeed receive positive
        7 = GND_DRAIN, "Ground Drain"        // Ground drain
        8 = SSTX\-, "SuperSpeed TX Negative"  // SuperSpeed transmit negative
        9 = SSTX\+, "SuperSpeed TX Positive"  // SuperSpeed transmit positive
    ]

    role Host {
        name = "USB Host"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 5 = SSRX\-, "SuperSpeed RX Negative"  // The host receives on SSRX
            in 6 = SSRX\+, "SuperSpeed RX Positive"
            7 = GND_DRAIN, "Ground Drain"        // Ground drain
            out 8 = SSTX\-, "SuperSpeed TX Negative"  // and transmits on SSTX
            out 9 = SSTX\+, "SuperSpeed TX Positive"
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            out 5 = SSRX\-, "SuperSpeed RX Negative"  // The device transmits on these wires
            out 6 = SSRX\+, "SuperSpeed RX Positive"
            7 = GND_DRAIN, "Ground Drain"        // Ground drain
            in 8 = SSTX\-, "SuperSpeed TX Negative"  // and reads what the host sends
            in 9 = SSTX\+, "SuperSpeed TX Positive"
        ]
        peer = Host
    }

}

// USB 3.x Type B Connector
interface USB3.TYPEB(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 3m
    maxspeed = [5Gbps@3m]  // SuperSpeed
    voltage = 5V
    current = 900mA  // USB 3.0 current
    name = "USB 3.x Type B"
    description = "USB 3.x Type B connector with additional SuperSpeed pins"
    
    pins = [
        // USB 2.0 pins (backward compatibility)
        [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
        [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]

        // USB 3.x additional pins (Standard-B receptacle is the device side:
        // the device transmits on SSTX 5/6 and receives on SSRX 8/9)
        5 = SSTX\-, "SuperSpeed TX Negative"  // SuperSpeed transmit negative
        6 = SSTX\+, "SuperSpeed TX Positive"  // SuperSpeed transmit positive
        7 = GND_DRAIN, "Ground Drain"        // Ground drain
        8 = SSRX\-, "SuperSpeed RX Negative"  // SuperSpeed receive negative
        9 = SSRX\+, "SuperSpeed RX Positive"  // SuperSpeed receive positive
    ]

    role Host {
        name = "USB Host"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 5 = SSTX\-, "SuperSpeed TX Negative"  // The device transmits on SSTX
            in 6 = SSTX\+, "SuperSpeed TX Positive"
            7 = GND_DRAIN, "Ground Drain"        // Ground drain
            out 8 = SSRX\-, "SuperSpeed RX Negative"  // The host answers on SSRX
            out 9 = SSRX\+, "SuperSpeed RX Positive"
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            out 5 = SSTX\-, "SuperSpeed TX Negative"  // The device transmits on SSTX
            out 6 = SSTX\+, "SuperSpeed TX Positive"
            7 = GND_DRAIN, "Ground Drain"        // Ground drain
            in 8 = SSRX\-, "SuperSpeed RX Negative"  // and reads what the host sends
            in 9 = SSRX\+, "SuperSpeed RX Positive"
        ]
        peer = Host
    }

}

// USB 3.x Micro B Connector
interface USB3.MICROB(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 3m
    maxspeed = [5Gbps@3m]  // SuperSpeed
    voltage = 5V
    current = 900mA  // USB 3.0 current
    name = "USB 3.x Micro B"
    description = "USB 3.x Micro B connector with additional SuperSpeed pins"
    
    pins = [
        // USB 2.0 pins (backward compatibility)
        [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
        [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]
        4 = ID, "ID"                // Identification pin (for OTG)
        
        // USB 3.x additional pins (Micro-B receptacle is the device side:
        // the device transmits on SSTX 6/7 and receives on SSRX 9/10)
        6 = SSTX\-, "SuperSpeed TX Negative"  // SuperSpeed transmit negative
        7 = SSTX\+, "SuperSpeed TX Positive"  // SuperSpeed transmit positive
        8 = GND_DRAIN, "Ground Drain"        // Ground drain
        9 = SSRX\-, "SuperSpeed RX Negative"  // SuperSpeed receive negative
        10 = SSRX\+, "SuperSpeed RX Positive" // SuperSpeed receive positive
    ]
    
    role Host {
        name = "USB Host"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID, "ID"                // Cable sense: the plug grounds it (OTG)
            in 6 = SSTX\-, "SuperSpeed TX Negative"  // The device transmits on SSTX
            in 7 = SSTX\+, "SuperSpeed TX Positive"
            8 = GND_DRAIN, "Ground Drain"
            out 9 = SSRX\-, "SuperSpeed RX Negative"  // The host answers on SSRX
            out 10 = SSRX\+, "SuperSpeed RX Positive"
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+], ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID, "ID"                // Cable sense: the plug grounds it (OTG)
            out 6 = SSTX\-, "SuperSpeed TX Negative"  // The device transmits on SSTX
            out 7 = SSTX\+, "SuperSpeed TX Positive"
            8 = GND_DRAIN, "Ground Drain"
            in 9 = SSRX\-, "SuperSpeed RX Negative"  // and reads what the host sends
            in 10 = SSRX\+, "SuperSpeed RX Positive"
        ]
        peer = Host
    }

}

// ---------------------------------------------------------------------------------------------
// USB-C Connector
// ---------------------------------------------------------------------------------------------

// USB-C Connector (24 pins)
interface USB.C(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = [3m, 2m]  // Depending on speed
    maxspeed = [5Gbps@3m, 10Gbps@2m]  // SuperSpeed and SuperSpeed+ (USB 3.1/3.2)
    voltage = [5V, 9V, 12V, 15V, 20V]  // Power Delivery
    current = [3A, 5A]  // Power Delivery
    name = "USB Type C"
    description = "Reversible USB Type C connector"
    
    pins = [
        // Top row (A side)
        A1 = GND, "Ground"           // Ground
        A2 = SSTX1\+, "SuperSpeed TX1 Positive"  // SuperSpeed transmit pair 1 positive
        A3 = SSTX1\-, "SuperSpeed TX1 Negative"  // SuperSpeed transmit pair 1 negative
        A4 = VBUS, "Power"           // +5V power (Power Delivery capable)
        A5 = CC1, "Configuration Channel 1"  // Configuration channel
        // The USB 2.0 lane exists on both sides under the same member names:
        // two @pair groups are declared (U205③ ruled 2026-09-23) and the
        // name-level consumer resolves them to one pair — only one side is
        // live at a time (plug orientation).
        A6 = USB2_D\+ @pair(dA), "USB 2.0 Data Positive"  // USB 2.0 positive data line (A side)
        A7 = USB2_D\- @pair(dA), "USB 2.0 Data Negative"  // USB 2.0 negative data line (A side)
        A8 = SBU1, "Sideband Use 1"  // Sideband use pin
        A9 = VBUS, "Power"           // +5V power (Power Delivery capable)
        A10 = SSRX2\+, "SuperSpeed RX2 Positive"  // SuperSpeed receive pair 2 positive
        A11 = SSRX2\-, "SuperSpeed RX2 Negative"  // SuperSpeed receive pair 2 negative
        A12 = GND, "Ground"           // Ground

        // Bottom row (B side)
        B1 = GND, "Ground"           // Ground
        B2 = SSRX1\+, "SuperSpeed RX1 Positive"  // SuperSpeed receive pair 1 positive
        B3 = SSRX1\-, "SuperSpeed RX1 Negative"  // SuperSpeed receive pair 1 negative
        B4 = VBUS, "Power"           // +5V power (Power Delivery capable)
        B5 = CC2, "Configuration Channel 2"  // Configuration channel
        B6 = USB2_D\+ @pair(dB), "USB 2.0 Data Positive"  // USB 2.0 positive data line (B side)
        B7 = USB2_D\- @pair(dB), "USB 2.0 Data Negative"  // USB 2.0 negative data line (B side)
        B8 = SBU2, "Sideband Use 2"  // Sideband use pin
        B9 = VBUS, "Power"           // +5V power (Power Delivery capable)
        B10 = SSTX2\+, "SuperSpeed TX2 Positive"  // SuperSpeed transmit pair 2 positive
        B11 = SSTX2\-, "SuperSpeed TX2 Negative"  // SuperSpeed transmit pair 2 negative
        B12 = GND, "Ground"           // Ground
    ]
    
    // USB-C specific features
    features = [
        "Reversible plug orientation",
        "Power Delivery (up to 100W)",
        "Alternate Mode (DisplayPort, HDMI, Thunderbolt)",
        "Dual Role Device (DRD) capability"
    ]

    role Host {
        name = "USB Host"
        pins = [
            A1 = GND, "Ground"
            out A2 = SSTX1\+, "SuperSpeed TX1 Positive"  // host view
            out A3 = SSTX1\-, "SuperSpeed TX1 Negative"  // host view
            A4 = VBUS, "Power"
            io A5 = CC1, "Configuration Channel 1"  // host view
            io A6 = USB2_D\+ @pair(dA), "USB 2.0 Data Positive"  // host view
            io A7 = USB2_D\- @pair(dA), "USB 2.0 Data Negative"  // host view
            io A8 = SBU1, "Sideband Use 1"  // host view
            A9 = VBUS, "Power"
            in A10 = SSRX2\+, "SuperSpeed RX2 Positive"  // host view
            in A11 = SSRX2\-, "SuperSpeed RX2 Negative"  // host view
            A12 = GND, "Ground"
            B1 = GND, "Ground"
            in B2 = SSRX1\+, "SuperSpeed RX1 Positive"  // host view
            in B3 = SSRX1\-, "SuperSpeed RX1 Negative"  // host view
            B4 = VBUS, "Power"
            io B5 = CC2, "Configuration Channel 2"  // host view
            io B6 = USB2_D\+ @pair(dB), "USB 2.0 Data Positive"  // host view
            io B7 = USB2_D\- @pair(dB), "USB 2.0 Data Negative"  // host view
            io B8 = SBU2, "Sideband Use 2"  // host view
            B9 = VBUS, "Power"
            out B10 = SSTX2\+, "SuperSpeed TX2 Positive"  // host view
            out B11 = SSTX2\-, "SuperSpeed TX2 Negative"  // host view
            B12 = GND, "Ground"
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            A1 = GND, "Ground"
            in A2 = SSTX1\+, "SuperSpeed TX1 Positive"  // device view
            in A3 = SSTX1\-, "SuperSpeed TX1 Negative"  // device view
            A4 = VBUS, "Power"
            io A5 = CC1, "Configuration Channel 1"  // device view
            io A6 = USB2_D\+ @pair(dA), "USB 2.0 Data Positive"  // device view
            io A7 = USB2_D\- @pair(dA), "USB 2.0 Data Negative"  // device view
            io A8 = SBU1, "Sideband Use 1"  // device view
            A9 = VBUS, "Power"
            out A10 = SSRX2\+, "SuperSpeed RX2 Positive"  // device view
            out A11 = SSRX2\-, "SuperSpeed RX2 Negative"  // device view
            A12 = GND, "Ground"
            B1 = GND, "Ground"
            out B2 = SSRX1\+, "SuperSpeed RX1 Positive"  // device view
            out B3 = SSRX1\-, "SuperSpeed RX1 Negative"  // device view
            B4 = VBUS, "Power"
            io B5 = CC2, "Configuration Channel 2"  // device view
            io B6 = USB2_D\+ @pair(dB), "USB 2.0 Data Positive"  // device view
            io B7 = USB2_D\- @pair(dB), "USB 2.0 Data Negative"  // device view
            io B8 = SBU2, "Sideband Use 2"  // device view
            B9 = VBUS, "Power"
            in B10 = SSTX2\+, "SuperSpeed TX2 Positive"  // device view
            in B11 = SSTX2\-, "SuperSpeed TX2 Negative"  // device view
            B12 = GND, "Ground"
        ]
        peer = Host
    }

}

// ---------------------------------------------------------------------------------------------
// USB Data Interface
// ---------------------------------------------------------------------------------------------
interface USB.DATA(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxspeed = [1.5Mbps, 12Mbps, 480Mbps]
    name = "USB Data Interface"
    description = "USB data interface with differential signaling"

    // The two rows tagged @pair(d) are the two legs of one differential
    // signal; the +/- spellings are the naming convention (same as
    // USB3.TX / USB3.RX).
    pins = [
        1 = D\+ @pair(d), "Data Positive"     // Positive data line
        2 = D\- @pair(d), "Data Negative"     // Negative data line
    ]

    role Host {
        name = "USB Host"
        pins = [
            io 1 = D\+ @pair(d), "Data Positive"     // Half duplex: either side drives
            io 2 = D\- @pair(d), "Data Negative"
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            io 1 = D\+ @pair(d), "Data Positive"     // Half duplex: either side drives
            io 2 = D\- @pair(d), "Data Negative"
        ]
        peer = Host
    }

}

// ---------------------------------------------------------------------------------------------
// USB 3.x SuperSpeed Transmit Interface
// ---------------------------------------------------------------------------------------------
interface USB3.TX(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxspeed = [5Gbps]
    name = "USB 3.x SuperSpeed Transmit Interface"
    description = "USB 3.x SuperSpeed transmit interface"
    
    // The two rows tagged @pair(sstx) are the two legs of one differential
    // signal; the +/- spellings are the naming convention (same as USB3.RX
    // and every other differential interface). The match slot records the
    // intra-pair length tolerance as a requirement: mcc records it, the
    // layout tool and the bench judge it.
    pins = [
        1 = SSTX\+ @pair(sstx, match: 0.2mm), "SuperSpeed TX Positive"  // SuperSpeed transmit positive
        2 = SSTX\- @pair(sstx, match: 0.2mm), "SuperSpeed TX Negative"  // SuperSpeed transmit negative
    ]

    role Host {
        name = "USB Host"
        pins = [
            out 1 = SSTX\+ @pair(sstx, match: 0.2mm), "SuperSpeed TX Positive"  // The transmit end drives
            out 2 = SSTX\- @pair(sstx, match: 0.2mm), "SuperSpeed TX Negative"
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            in 1 = SSTX\+ @pair(sstx, match: 0.2mm), "SuperSpeed TX Positive"  // The peer end reads
            in 2 = SSTX\- @pair(sstx, match: 0.2mm), "SuperSpeed TX Negative"
        ]
        peer = Host
    }

}

// ---------------------------------------------------------------------------------------------
// USB 3.x SuperSpeed Receive Interface
// ---------------------------------------------------------------------------------------------
interface USB3.RX(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxspeed = [5Gbps]
    name = "USB 3.x SuperSpeed Receive Interface"
    description = "USB 3.x SuperSpeed receive interface"

    // The two rows tagged @pair(ssrx) are the two legs of one differential
    // signal; the +/- spellings are the naming convention (same as USB3.TX).
    // The match slot records the intra-pair length tolerance as a requirement:
    // mcc records it, the layout tool and the bench judge it.
    pins = [
        1 = SSRX\+ @pair(ssrx, match: 0.2mm), "SuperSpeed RX Positive"  // SuperSpeed receive positive
        2 = SSRX\- @pair(ssrx, match: 0.2mm), "SuperSpeed RX Negative"  // SuperSpeed receive negative
    ]

    role Host {
        name = "USB Host"
        pins = [
            in 1 = SSRX\+ @pair(ssrx, match: 0.2mm), "SuperSpeed RX Positive"  // The receive end reads
            in 2 = SSRX\- @pair(ssrx, match: 0.2mm), "SuperSpeed RX Negative"
        ]
        peer = Device
    }
    role Device {
        name = "USB Device"
        pins = [
            out 1 = SSRX\+ @pair(ssrx, match: 0.2mm), "SuperSpeed RX Positive"  // The transmit end drives
            out 2 = SSRX\- @pair(ssrx, match: 0.2mm), "SuperSpeed RX Negative"
        ]
        peer = Host
    }

}
