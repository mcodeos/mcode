# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// USB - Universal Serial Bus 2.0 Interface Standard Definition
// Core Rule: A half-duplex differential data pair (D-/D+) plus a 5V VBUS
//            power pair borrowed from the DC interface; host and device
//            time-share the data pair. Speeds from Low (1.5Mbps) through
//            Full (12Mbps) to High (480Mbps).
// Device Definition: HOST = the controlling host (asserts VBUS, drives
//                    the bus),
//                    DEVICE = the peripheral device.
// Note: the RELAY role is the cable conductor view — it takes the base
//       pin table and selects no endpoint role; a cable module binds it
//       on each end and states its crossing or straight join in the body.

interface USB(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 5m
    maxspeed = [1.5Mbps@5m, 12Mbps@5m, 480Mbps@3m]
    voltage = 5V
    current = 500mA  // Default current (USB 2.0)

    pins = [
        [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
        [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]
    ]
    
    role HOST {
        name = "USB Host"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = HOST(1)
    }

    // Relay face: the cable's conductor
    // view — takes the interface's base pin table and selects no endpoint
    // role. A cable module binds `io a::USB(RELAY)` on each end and states
    // its crossing or straight join in the body.
    role RELAY {
        name = "USB Relay"
    }
}

// USB.TYPEA - USB 2.0 Type-A Connector Interface Standard Definition
// Core Rule: Same electrical law as USB (half-duplex D-/D+ pair plus 5V
//            VBUS power); the rectangular receptacle typically hosting
//            the host side.
// Device Definition: HOST = the controlling host,
//                    DEVICE = the peripheral device.

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
        [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]
    ]

    role HOST {
        name = "USB Host"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = HOST(1)
    }

}

// USB.TYPEB - USB 2.0 Type-B Connector Interface Standard Definition
// Core Rule: Same electrical law as USB (half-duplex D-/D+ pair plus 5V
//            VBUS power); the squarish receptacle typically hosting the
//            peripheral side.
// Device Definition: HOST = the controlling host,
//                    DEVICE = the peripheral device.

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
        [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]
    ]

    role HOST {
        name = "USB Host"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
        ]
        peer = HOST(1)
    }

}

// USB.MINIB - USB 2.0 Mini Type-B Connector Interface Standard Definition
// Core Rule: Same electrical law as USB over the mini form factor, plus
//            the OTG ID pin: the plug grounds it and the device-side
//            cable sense reads the role.
// Device Definition: HOST = the OTG/host side (reads the grounded ID),
//                    DEVICE = the peripheral device.

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
        [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]
        4 = ID @class(digital), "ID"                // Identification pin (for OTG)
    ]

    role HOST {
        name = "USB Host"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID @class(digital), "ID"                // Cable sense: the plug grounds it (OTG)
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID @class(digital), "ID"                // Cable sense: the plug grounds it (OTG)
        ]
        peer = HOST(1)
    }

}

// USB.MICROB - USB 2.0 Micro Type-B Connector Interface Standard Definition
// Core Rule: Same electrical law as USB over the micro form factor, plus
//            the OTG ID pin: the plug grounds it and the device-side
//            cable sense reads the role.
// Device Definition: HOST = the OTG/host side (reads the grounded ID),
//                    DEVICE = the peripheral device.

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
        [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]
        4 = ID @class(digital), "ID"                // Identification pin (for OTG)
    ]

    role HOST {
        name = "USB Host"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID @class(digital), "ID"                // Cable sense: the plug grounds it (OTG)
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID @class(digital), "ID"                // Cable sense: the plug grounds it (OTG)
        ]
        peer = HOST(1)
    }

}

// USB3.TYPEA - USB 3.x Type-A Connector Interface Standard Definition
// Core Rule: USB 2.0 pins for backward compatibility plus two
//            SuperSpeed differential pairs and a GND_DRAIN return; the
//            Standard-A receptacle is the host side, so the host receives
//            on SSRX and transmits on SSTX.
// Device Definition: HOST = the SuperSpeed host (transmits on SSTX,
//                    receives on SSRX),
//                    DEVICE = the SuperSpeed peripheral.

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
        [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]

        // USB 3.x additional pins (Standard-A receptacle is the host side:
        // the host receives on SSRX 5/6 and transmits on SSTX 8/9)
        5 = SSRX\- @pair(ssrx) @class(digital), "SuperSpeed RX Negative"  // SuperSpeed receive negative
        6 = SSRX\+ @pair(ssrx) @class(digital), "SuperSpeed RX Positive"  // SuperSpeed receive positive
        7 = GND_DRAIN, "Ground Drain"        // Ground drain
        8 = SSTX\- @pair(sstx) @class(digital), "SuperSpeed TX Negative"  // SuperSpeed transmit negative
        9 = SSTX\+ @pair(sstx) @class(digital), "SuperSpeed TX Positive"  // SuperSpeed transmit positive
    ]

    role HOST {
        name = "USB Host"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 5 = SSRX\- @pair(ssrx) @class(digital), "SuperSpeed RX Negative"  // The host receives on SSRX
            in 6 = SSRX\+ @pair(ssrx) @class(digital), "SuperSpeed RX Positive"
            7 = GND_DRAIN, "Ground Drain"        // Ground drain
            out 8 = SSTX\- @pair(sstx) @class(digital), "SuperSpeed TX Negative"  // and transmits on SSTX
            out 9 = SSTX\+ @pair(sstx) @class(digital), "SuperSpeed TX Positive"
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            out 5 = SSRX\- @pair(ssrx) @class(digital), "SuperSpeed RX Negative"  // The device transmits on these wires
            out 6 = SSRX\+ @pair(ssrx) @class(digital), "SuperSpeed RX Positive"
            7 = GND_DRAIN, "Ground Drain"        // Ground drain
            in 8 = SSTX\- @pair(sstx) @class(digital), "SuperSpeed TX Negative"  // and reads what the host sends
            in 9 = SSTX\+ @pair(sstx) @class(digital), "SuperSpeed TX Positive"
        ]
        peer = HOST(1)
    }

}

// USB3.TYPEB - USB 3.x Type-B Connector Interface Standard Definition
// Core Rule: USB 2.0 pins for backward compatibility plus two
//            SuperSpeed differential pairs and a GND_DRAIN return; the
//            Standard-B receptacle is the device side, so the device
//            transmits on SSTX and receives on SSRX.
// Device Definition: HOST = the SuperSpeed host (transmits on SSTX,
//                    receives on SSRX),
//                    DEVICE = the SuperSpeed peripheral.

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
        [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]

        // USB 3.x additional pins (Standard-B receptacle is the device side:
        // the device transmits on SSTX 5/6 and receives on SSRX 8/9)
        5 = SSTX\- @pair(sstx) @class(digital), "SuperSpeed TX Negative"  // SuperSpeed transmit negative
        6 = SSTX\+ @pair(sstx) @class(digital), "SuperSpeed TX Positive"  // SuperSpeed transmit positive
        7 = GND_DRAIN, "Ground Drain"        // Ground drain
        8 = SSRX\- @pair(ssrx) @class(digital), "SuperSpeed RX Negative"  // SuperSpeed receive negative
        9 = SSRX\+ @pair(ssrx) @class(digital), "SuperSpeed RX Positive"  // SuperSpeed receive positive
    ]

    role HOST {
        name = "USB Host"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 5 = SSTX\- @pair(sstx) @class(digital), "SuperSpeed TX Negative"  // The device transmits on SSTX
            in 6 = SSTX\+ @pair(sstx) @class(digital), "SuperSpeed TX Positive"
            7 = GND_DRAIN, "Ground Drain"        // Ground drain
            out 8 = SSRX\- @pair(ssrx) @class(digital), "SuperSpeed RX Negative"  // The host answers on SSRX
            out 9 = SSRX\+ @pair(ssrx) @class(digital), "SuperSpeed RX Positive"
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            [1,4] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            out 5 = SSTX\- @pair(sstx) @class(digital), "SuperSpeed TX Negative"  // The device transmits on SSTX
            out 6 = SSTX\+ @pair(sstx) @class(digital), "SuperSpeed TX Positive"
            7 = GND_DRAIN, "Ground Drain"        // Ground drain
            in 8 = SSRX\- @pair(ssrx) @class(digital), "SuperSpeed RX Negative"  // and reads what the host sends
            in 9 = SSRX\+ @pair(ssrx) @class(digital), "SuperSpeed RX Positive"
        ]
        peer = HOST(1)
    }

}

// USB3.MICROB - USB 3.x Micro Type-B Connector Interface Standard Definition
// Core Rule: USB 2.0 pins (including the OTG ID cable-sense pin) plus
//            two SuperSpeed differential pairs and a GND_DRAIN return;
//            the Micro-B receptacle is the device side, so the device
//            transmits on SSTX and receives on SSRX.
// Device Definition: HOST = the SuperSpeed host (transmits on SSTX,
//                    receives on SSRX),
//                    DEVICE = the SuperSpeed peripheral.

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
        [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]
        4 = ID @class(digital), "ID"                // Identification pin (for OTG)
        
        // USB 3.x additional pins (Micro-B receptacle is the device side:
        // the device transmits on SSTX 6/7 and receives on SSRX 9/10)
        6 = SSTX\- @pair(sstx) @class(digital), "SuperSpeed TX Negative"  // SuperSpeed transmit negative
        7 = SSTX\+ @pair(sstx) @class(digital), "SuperSpeed TX Positive"  // SuperSpeed transmit positive
        8 = GND_DRAIN, "Ground Drain"        // Ground drain
        9 = SSRX\- @pair(ssrx) @class(digital), "SuperSpeed RX Negative"  // SuperSpeed receive negative
        10 = SSRX\+ @pair(ssrx) @class(digital), "SuperSpeed RX Positive" // SuperSpeed receive positive
    ]
    
    role HOST {
        name = "USB Host"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID @class(digital), "ID"                // Cable sense: the plug grounds it (OTG)
            in 6 = SSTX\- @pair(sstx) @class(digital), "SuperSpeed TX Negative"  // The device transmits on SSTX
            in 7 = SSTX\+ @pair(sstx) @class(digital), "SuperSpeed TX Positive"
            8 = GND_DRAIN, "Ground Drain"
            out 9 = SSRX\- @pair(ssrx) @class(digital), "SuperSpeed RX Negative"  // The host answers on SSRX
            out 10 = SSRX\+ @pair(ssrx) @class(digital), "SuperSpeed RX Positive"
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
            io [2,3] = [D\-,D\+] @pair(d) @class(digital), ["Data Negative", "Data Positive"]  // Half duplex: host and device time-share the pair
            in 4 = ID @class(digital), "ID"                // Cable sense: the plug grounds it (OTG)
            out 6 = SSTX\- @pair(sstx) @class(digital), "SuperSpeed TX Negative"  // The device transmits on SSTX
            out 7 = SSTX\+ @pair(sstx) @class(digital), "SuperSpeed TX Positive"
            8 = GND_DRAIN, "Ground Drain"
            in 9 = SSRX\- @pair(ssrx) @class(digital), "SuperSpeed RX Negative"  // and reads what the host sends
            in 10 = SSRX\+ @pair(ssrx) @class(digital), "SuperSpeed RX Positive"
        ]
        peer = HOST(1)
    }

}

// USB.C - USB Type-C Connector Interface Standard Definition
// Core Rule: Reversible 24-pin face at Power Delivery voltages: one USB
//            2.0 lane under the same member names on both plug rows
//            (only one row live at a time by plug orientation), four
//            SuperSpeed pairs, the CC1/CC2 configuration channel, and two
//            sideband (SBU) pins.
// Device Definition: HOST = the host / dual-role side,
//                    DEVICE = the peripheral / dual-role side.

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
        A2 = SSTX1\+ @pair(sstx1) @class(digital), "SuperSpeed TX1 Positive"  // SuperSpeed transmit pair 1 positive
        A3 = SSTX1\- @pair(sstx1) @class(digital), "SuperSpeed TX1 Negative"  // SuperSpeed transmit pair 1 negative
        A4 = VBUS, "Power"           // +5V power (Power Delivery capable)
        A5 = CC1 @class(digital), "Configuration Channel 1"  // Configuration channel
        // The USB 2.0 lane exists on both sides under the same member names:
        // two @pair groups are declared and the name-level consumer
        // resolves them to one pair — only one side is live at a time
        // (plug orientation).
        A6 = USB2_D\+ @pair(dA) @class(digital), "USB 2.0 Data Positive"  // USB 2.0 positive data line (A side)
        A7 = USB2_D\- @pair(dA) @class(digital), "USB 2.0 Data Negative"  // USB 2.0 negative data line (A side)
        A8 = SBU1 @class(digital), "Sideband Use 1"  // Sideband use pin
        A9 = VBUS, "Power"           // +5V power (Power Delivery capable)
        A10 = SSRX2\+ @pair(ssrx2) @class(digital), "SuperSpeed RX2 Positive"  // SuperSpeed receive pair 2 positive
        A11 = SSRX2\- @pair(ssrx2) @class(digital), "SuperSpeed RX2 Negative"  // SuperSpeed receive pair 2 negative
        A12 = GND, "Ground"           // Ground

        // Bottom row (B side)
        B1 = GND, "Ground"           // Ground
        B2 = SSRX1\+ @pair(ssrx1) @class(digital), "SuperSpeed RX1 Positive"  // SuperSpeed receive pair 1 positive
        B3 = SSRX1\- @pair(ssrx1) @class(digital), "SuperSpeed RX1 Negative"  // SuperSpeed receive pair 1 negative
        B4 = VBUS, "Power"           // +5V power (Power Delivery capable)
        B5 = CC2 @class(digital), "Configuration Channel 2"  // Configuration channel
        B6 = USB2_D\+ @pair(dB) @class(digital), "USB 2.0 Data Positive"  // USB 2.0 positive data line (B side)
        B7 = USB2_D\- @pair(dB) @class(digital), "USB 2.0 Data Negative"  // USB 2.0 negative data line (B side)
        B8 = SBU2 @class(digital), "Sideband Use 2"  // Sideband use pin
        B9 = VBUS, "Power"           // +5V power (Power Delivery capable)
        B10 = SSTX2\+ @pair(sstx2) @class(digital), "SuperSpeed TX2 Positive"  // SuperSpeed transmit pair 2 positive
        B11 = SSTX2\- @pair(sstx2) @class(digital), "SuperSpeed TX2 Negative"  // SuperSpeed transmit pair 2 negative
        B12 = GND, "Ground"           // Ground
    ]
    
    // USB-C specific features
    features = [
        "Reversible plug orientation",
        "Power Delivery (up to 100W)",
        "Alternate Mode (other display protocols over the connector)",
        "Dual Role Device (DRD) capability"
    ]

    role HOST {
        name = "USB Host"
        pins = [
            A1 = GND, "Ground"
            out A2 = SSTX1\+ @pair(sstx1) @class(digital), "SuperSpeed TX1 Positive"  // host view
            out A3 = SSTX1\- @pair(sstx1) @class(digital), "SuperSpeed TX1 Negative"  // host view
            A4 = VBUS, "Power"
            io A5 = CC1 @class(digital), "Configuration Channel 1"  // host view
            io A6 = USB2_D\+ @pair(dA) @class(digital), "USB 2.0 Data Positive"  // host view
            io A7 = USB2_D\- @pair(dA) @class(digital), "USB 2.0 Data Negative"  // host view
            io A8 = SBU1 @class(digital), "Sideband Use 1"  // host view
            A9 = VBUS, "Power"
            in A10 = SSRX2\+ @pair(ssrx2) @class(digital), "SuperSpeed RX2 Positive"  // host view
            in A11 = SSRX2\- @pair(ssrx2) @class(digital), "SuperSpeed RX2 Negative"  // host view
            A12 = GND, "Ground"
            B1 = GND, "Ground"
            in B2 = SSRX1\+ @pair(ssrx1) @class(digital), "SuperSpeed RX1 Positive"  // host view
            in B3 = SSRX1\- @pair(ssrx1) @class(digital), "SuperSpeed RX1 Negative"  // host view
            B4 = VBUS, "Power"
            io B5 = CC2 @class(digital), "Configuration Channel 2"  // host view
            io B6 = USB2_D\+ @pair(dB) @class(digital), "USB 2.0 Data Positive"  // host view
            io B7 = USB2_D\- @pair(dB) @class(digital), "USB 2.0 Data Negative"  // host view
            io B8 = SBU2 @class(digital), "Sideband Use 2"  // host view
            B9 = VBUS, "Power"
            out B10 = SSTX2\+ @pair(sstx2) @class(digital), "SuperSpeed TX2 Positive"  // host view
            out B11 = SSTX2\- @pair(sstx2) @class(digital), "SuperSpeed TX2 Negative"  // host view
            B12 = GND, "Ground"
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            A1 = GND, "Ground"
            in A2 = SSTX1\+ @pair(sstx1) @class(digital), "SuperSpeed TX1 Positive"  // device view
            in A3 = SSTX1\- @pair(sstx1) @class(digital), "SuperSpeed TX1 Negative"  // device view
            A4 = VBUS, "Power"
            io A5 = CC1 @class(digital), "Configuration Channel 1"  // device view
            io A6 = USB2_D\+ @pair(dA) @class(digital), "USB 2.0 Data Positive"  // device view
            io A7 = USB2_D\- @pair(dA) @class(digital), "USB 2.0 Data Negative"  // device view
            io A8 = SBU1 @class(digital), "Sideband Use 1"  // device view
            A9 = VBUS, "Power"
            out A10 = SSRX2\+ @pair(ssrx2) @class(digital), "SuperSpeed RX2 Positive"  // device view
            out A11 = SSRX2\- @pair(ssrx2) @class(digital), "SuperSpeed RX2 Negative"  // device view
            A12 = GND, "Ground"
            B1 = GND, "Ground"
            out B2 = SSRX1\+ @pair(ssrx1) @class(digital), "SuperSpeed RX1 Positive"  // device view
            out B3 = SSRX1\- @pair(ssrx1) @class(digital), "SuperSpeed RX1 Negative"  // device view
            B4 = VBUS, "Power"
            io B5 = CC2 @class(digital), "Configuration Channel 2"  // device view
            io B6 = USB2_D\+ @pair(dB) @class(digital), "USB 2.0 Data Positive"  // device view
            io B7 = USB2_D\- @pair(dB) @class(digital), "USB 2.0 Data Negative"  // device view
            io B8 = SBU2 @class(digital), "Sideband Use 2"  // device view
            B9 = VBUS, "Power"
            in B10 = SSTX2\+ @pair(sstx2) @class(digital), "SuperSpeed TX2 Positive"  // device view
            in B11 = SSTX2\- @pair(sstx2) @class(digital), "SuperSpeed TX2 Negative"  // device view
            B12 = GND, "Ground"
        ]
        peer = HOST(1)
    }

}

// USB.DATA - USB Data-Only Interface Standard Definition
// Core Rule: The USB data pair alone (no power members): the data face
//            for modules, hub legs, and device internals; host and device
//            time-share the half-duplex pair.
// Device Definition: HOST = the controlling host,
//                    DEVICE = the peripheral device.

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
        1 = D\+ @pair(d) @class(digital), "Data Positive"     // Positive data line
        2 = D\- @pair(d) @class(digital), "Data Negative"     // Negative data line
    ]

    role HOST {
        name = "USB Host"
        pins = [
            io 1 = D\+ @pair(d) @class(digital), "Data Positive"     // Half duplex: either side drives
            io 2 = D\- @pair(d) @class(digital), "Data Negative"
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            io 1 = D\+ @pair(d) @class(digital), "Data Positive"     // Half duplex: either side drives
            io 2 = D\- @pair(d) @class(digital), "Data Negative"
        ]
        peer = HOST(1)
    }

}

// USB3.TX - USB 3.x SuperSpeed Transmit Pair Interface Standard Definition
// Core Rule: One SuperSpeed differential transmit pair; the @pair match
//            slot records the intra-pair length tolerance as a
//            requirement — the tooling records it and the layout tool and
//            bench judge it.
// Device Definition: HOST = the transmit end that drives the pair,
//                    DEVICE = the peer end that reads it.

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
        1 = SSTX\+ @pair(sstx, match: 0.2mm) @class(digital), "SuperSpeed TX Positive"  // SuperSpeed transmit positive
        2 = SSTX\- @pair(sstx, match: 0.2mm) @class(digital), "SuperSpeed TX Negative"  // SuperSpeed transmit negative
    ]

    role HOST {
        name = "USB Host"
        pins = [
            out 1 = SSTX\+ @pair(sstx, match: 0.2mm) @class(digital), "SuperSpeed TX Positive"  // The transmit end drives
            out 2 = SSTX\- @pair(sstx, match: 0.2mm) @class(digital), "SuperSpeed TX Negative"
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            in 1 = SSTX\+ @pair(sstx, match: 0.2mm) @class(digital), "SuperSpeed TX Positive"  // The peer end reads
            in 2 = SSTX\- @pair(sstx, match: 0.2mm) @class(digital), "SuperSpeed TX Negative"
        ]
        peer = HOST(1)
    }

}

// USB3.RX - USB 3.x SuperSpeed Receive Pair Interface Standard Definition
// Core Rule: One SuperSpeed differential receive pair; the @pair match
//            slot records the intra-pair length tolerance as a
//            requirement — the tooling records it and the layout tool and
//            bench judge it.
// Device Definition: HOST = the receive end that reads the pair,
//                    DEVICE = the peer end that drives it.

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
        1 = SSRX\+ @pair(ssrx, match: 0.2mm) @class(digital), "SuperSpeed RX Positive"  // SuperSpeed receive positive
        2 = SSRX\- @pair(ssrx, match: 0.2mm) @class(digital), "SuperSpeed RX Negative"  // SuperSpeed receive negative
    ]

    role HOST {
        name = "USB Host"
        pins = [
            in 1 = SSRX\+ @pair(ssrx, match: 0.2mm) @class(digital), "SuperSpeed RX Positive"  // The receive end reads
            in 2 = SSRX\- @pair(ssrx, match: 0.2mm) @class(digital), "SuperSpeed RX Negative"
        ]
        peer = DEVICE(1)
    }
    role DEVICE {
        name = "USB Device"
        pins = [
            out 1 = SSRX\+ @pair(ssrx, match: 0.2mm) @class(digital), "SuperSpeed RX Positive"  // The transmit end drives
            out 2 = SSRX\- @pair(ssrx, match: 0.2mm) @class(digital), "SuperSpeed RX Negative"
        ]
        peer = HOST(1)
    }

}
