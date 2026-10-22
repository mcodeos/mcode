# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Universal Serial Bus connector sockets

// Note: layer avoidance - the bare form names (USB.TYPEA, USB.MINIB, USB.C,
// ...) belong to the interface layer; connector components carry the SOCK_
// prefix (USB.SOCK_TYPEA, ...).

// USB.SOCK_TYPEA - USB 2.0 Type A connector Component Definition
// Core Rule: Pin map follows the standard USB pin assignment: 1 = VBUS, 2 = D-, 3 = D+, 4 = GND.

component USB.SOCK_TYPEA() :: ANCH.CONN.CAP
{
    name = "USB 2.0 Type A Connector"
    description = "USB 2.0 Type A connector"

    spec += [
        version = "2.0"
        orientation = _ // [horizontal, vertical]
        ANCH.CONN.CAP = [
            conn_type = CONN_TYPE.USB_TYPE_A
            mate_type = CONN_TYPE.USB_TYPE_A
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        [1,2,3,4] = [VBUS, D\-, D\+, GND]::USB.TYPEA(DEVICE), "VBUS / Data Negative / Data Positive / GND"
    ]
}

// USB.SOCK_TYPEB - USB 2.0 Type B connector Component Definition
// Core Rule: Same 4-pin USB 2.0 map as USB.SOCK_TYPEA (1 = VBUS, 2 = D-, 3 = D+, 4 = GND); no ID pin.

component USB.SOCK_TYPEB() :: ANCH.CONN.CAP
{
    name = "USB 2.0 Type B Connector"
    description = "USB 2.0 Type B connector"

    spec += [
        version = "2.0"
        mount = _ // [through-hole, surface-mount]
        ANCH.CONN.CAP = [
            conn_type = CONN_TYPE.USB_TYPE_B
            mate_type = CONN_TYPE.USB_TYPE_B
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        [1,2,3,4] = [VBUS, D\-, D\+, GND]::USB.TYPEB(DEVICE), "VBUS / Data Negative / Data Positive / GND"
    ]
}

// USB.SOCK_MINIB - USB 2.0 Mini Type B connector, abstract base for real-part variants Component Definition
// Core Rule: Mini-USB socket pin map: 5 signal wires (VBUS/D-/D+/ID/GND)
// plus 2 extra ground pins and 2 exposed shield electrodes.

abstract component USB.SOCK_MINIB() :: ANCH.CONN.CAP
{
    name = "USB 2.0 Mini Type B Connector"
    description = "USB 2.0 Mini Type B connector"

    spec += [
        version = "2.0"
        orientation = _ // [horizontal, vertical]
        ANCH.CONN.CAP = [
            conn_type = CONN_TYPE.USB_MINI_B
            mate_type = CONN_TYPE.USB_MINI_B
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        [1:5] = USB::USB.MINIB(DEVICE)   // USB interface: 1=VBUS, 2=D-, 3=D+, 4=ID, 5=GND
        [6,7] = GND                          // USB GND
        8 = SHIELD3 @exposed(esd_contact)    // USB shield: exposed boundary electrode
        9 = SHIELD4 @exposed(esd_contact)    // USB shield: exposed boundary electrode
    ]
}

// USB.SOCK_MICROB - USB 2.0 Micro Type B connector Component Definition
// Core Rule: 5-pin Micro-B map (VBUS/D-/D+/ID/GND); the ID pin carries OTG role identification.

component USB.SOCK_MICROB() :: ANCH.CONN.CAP
{
    name = "USB 2.0 Micro Type B Connector"
    description = "USB 2.0 Micro Type B connector"

    spec += [
        version = "2.0"
        orientation = _ // [horizontal, vertical]
        ANCH.CONN.CAP = [
            conn_type = CONN_TYPE.USB_MICRO_B
            mate_type = CONN_TYPE.USB_MICRO_B
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        [1,2,3,4,5] = [VBUS, D\-, D\+, ID, GND]::USB.MICROB(DEVICE), "VBUS / Data Negative / Data Positive / ID / GND"
    ]
}

// USB3.SOCK_TYPEA - USB 3.x Standard-A receptacle (host side) Component Definition
// Core Rule: USB 2.0 pins kept for backward compatibility plus two SuperSpeed
// pairs and a ground drain; a host receptacle receives on SSRX 5/6 and
// transmits on SSTX 8/9.

component USB3.SOCK_TYPEA() :: ANCH.CONN.CAP
{
    name = "USB 3.x Type A Connector"
    description = "USB 3.x Type A connector"

    spec += [
        version = "3.x"
        orientation = _ // [horizontal, vertical]
        ANCH.CONN.CAP = [
            conn_type = CONN_TYPE.USB_TYPE_A
            mate_type = CONN_TYPE.USB_TYPE_A
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        io [1,4,2,3,5,6,7,8,9] = U3{VBUS, GND, D\-, D\+, SSRX\-, SSRX\+, GND_DRAIN, SSTX\-, SSTX\+}::USB3.TYPEA(), "USB 2.0 pins (1/4 power, 2/3 data) plus SuperSpeed pairs (5/6 RX, 8/9 TX) and the ground drain (7); host receptacle"
    ]
}

// USB3.SOCK_TYPEB - USB 3.x Standard-B receptacle (device side, 9 pins) Component Definition
// Core Rule: USB 2.0 pins kept for backward compatibility, no ID pin; a device
// receptacle transmits on SSTX 5/6 and receives on SSRX 8/9.

component USB3.SOCK_TYPEB() :: ANCH.CONN.CAP
{
    name = "USB 3.x Type B Connector"
    description = "USB 3.x Type B connector"

    spec += [
        version = "3.x"
        mount = _ // [through-hole, surface-mount]
        ANCH.CONN.CAP = [
            conn_type = CONN_TYPE.USB_TYPE_B
            mate_type = CONN_TYPE.USB_TYPE_B
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        io [1,4,2,3,5,6,7,8,9] = U3{VBUS, GND, D\-, D\+, SSTX\-, SSTX\+, GND_DRAIN, SSRX\-, SSRX\+}::USB3.TYPEB(), "USB 2.0 pins (1/4 power, 2/3 data) plus SuperSpeed pairs (5/6 TX, 8/9 RX) and the ground drain (7); device receptacle"
    ]
}

// USB3.SOCK_MICROB - USB 3.x Micro B connector Component Definition
// Core Rule: Micro-B 5-pin USB 2.0 map extended with a SuperSpeed TX pair, RX
// pair, and ground drain; a device receptacle transmits on SSTX 6/7 and
// receives on SSRX 9/10.

component USB3.SOCK_MICROB() :: ANCH.CONN.CAP
{
    name = "USB 3.x Micro B Connector"
    description = "USB 3.x Micro B connector"

    spec += [
        version = "3.x"
        orientation = _ // [horizontal, vertical]
        ANCH.CONN.CAP = [
            conn_type = CONN_TYPE.USB_MICRO_B
            mate_type = CONN_TYPE.USB_MICRO_B
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        io [1,5,2,3,4,6,7,8,9,10] = U3{VBUS, GND, D\-, D\+, ID, SSTX\-, SSTX\+, GND_DRAIN, SSRX\-, SSRX\+}::USB3.MICROB(), "USB 2.0 pins (1/5 power, 2/3 data, 4 ID) plus SuperSpeed pairs (6/7 TX, 9/10 RX) and the ground drain (8); device receptacle"
    ]
}

// USB.SOCK_C - USB Type C connector Component Definition
// Core Rule: Reversible double-row contact face with A1-B12 numbering, the
// same system as the USB.C interface.

component USB.SOCK_C() :: ANCH.CONN.CAP
{
    name = "USB Type C Connector"
    description = "USB Type C connector"

    spec += [
        version = "3.1/3.2"
        mount = _ // [through-hole, surface-mount]
        ANCH.CONN.CAP = [
            conn_type = CONN_TYPE.USB_TYPE_C
            mate_type = CONN_TYPE.USB_TYPE_C
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        // Top row (A side)
        A1 = A1, "Ground"
        A2 = A2, "SuperSpeed TX1 Positive"
        A3 = A3, "SuperSpeed TX1 Negative"
        A4 = A4, "Power"
        A5 = A5, "Configuration Channel 1"
        A6 = A6, "USB 2.0 Data Positive"
        A7 = A7, "USB 2.0 Data Negative"
        A8 = A8, "Sideband Use 1"
        A9 = A9, "Power"
        A10 = A10, "SuperSpeed RX2 Positive"
        A11 = A11, "SuperSpeed RX2 Negative"
        A12 = A12, "Ground"

        // Bottom row (B side)
        B1 = B1, "Ground"
        B2 = B2, "SuperSpeed RX1 Positive"
        B3 = B3, "SuperSpeed RX1 Negative"
        B4 = B4, "Power"
        B5 = B5, "Configuration Channel 2"
        B6 = B6, "USB 2.0 Data Positive"
        B7 = B7, "USB 2.0 Data Negative"
        B8 = B8, "Sideband Use 2"
        B9 = B9, "Power"
        B10 = B10, "SuperSpeed TX2 Positive"
        B11 = B11, "SuperSpeed TX2 Negative"
        B12 = B12, "Ground"
    ]
}

// Usage Examples
// 1. USB 2.0 Type A connector

// USB.SOCK_TYPEA()

// 2. USB 2.0 Micro B connector
// USB.SOCK_MICROB()

// 3. USB 3.x Type A connector
// USB3.SOCK_TYPEA()

// 4. USB-C connector
// USB.SOCK_C()
