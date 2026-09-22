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
// USB Connector Definitions
// ---------------------------------------------------------------------------------------------
// Based on interface definitions in ifs/usb.mc.
// Layer avoidance: the bare form names (USB.TYPEA, USB.MINIB, USB.C, ...) belong to the
// interface layer; connector components carry the SOCK_ prefix (USB.SOCK_TYPEA, ...).
// Pin maps follow the USB-IF physical pin book (2 = D-, 3 = D+; Standard-A receptacle
// receives on SSRX 5/6; Standard-B receptacle transmits on SSTX 5/6; Type-B has no ID pin).

// USB 2.0 Type A Connector
component USB.SOCK_TYPEA()
{
    name = "USB 2.0 Type A Connector"
    description = "USB 2.0 Type A connector"

    spec = [
        type = "USB"
        version = "2.0"
        form_factor = "Type A"
        orientation = _ // [horizontal, vertical]
    ]

    pins = [
        1 = 1, "Power (+5V)"
        2 = 2, "Data Negative"
        3 = 3, "Data Positive"
        4 = 4, "Ground"
    ]
}

// USB 2.0 Type B Connector
component USB.SOCK_TYPEB()
{
    name = "USB 2.0 Type B Connector"
    description = "USB 2.0 Type B connector"

    spec = [
        type = "USB"
        version = "2.0"
        form_factor = "Type B"
        mount = _ // [through-hole, surface-mount]
    ]

    pins = [
        1 = 1, "Power (+5V)"
        2 = 2, "Data Negative"
        3 = 3, "Data Positive"
        4 = 4, "Ground"
    ]
}

// USB 2.0 Mini Type B Connector (abstract base for real-part variants)
// Mini-USB socket pin book: 5 wires (VBUS/D-/D+/ID/GND) + 2 ground + 2 shield
abstract component USB.SOCK_MINIB()
{
    name = "USB 2.0 Mini Type B Connector"
    description = "USB 2.0 Mini Type B connector"

    spec = [
        type = "USB"
        version = "2.0"
        form_factor = "Mini Type B"
        orientation = _ // [horizontal, vertical]
    ]

    pins = [
        [1:5] = USB::USB.MINIB(Device)   // USB interface: 1=VBUS, 2=D-, 3=D+, 4=ID, 5=GND
        [6,7] = GND                          // USB GND
        8 = SHIELD3 @exposed(esd_contact)    // USB shield: exposed boundary electrode
        9 = SHIELD4 @exposed(esd_contact)    // USB shield: exposed boundary electrode
    ]
}

// USB 2.0 Micro Type B Connector
component USB.SOCK_MICROB()
{
    name = "USB 2.0 Micro Type B Connector"
    description = "USB 2.0 Micro Type B connector"

    spec = [
        type = "USB"
        version = "2.0"
        form_factor = "Micro Type B"
        orientation = _ // [horizontal, vertical]
    ]

    pins = [
        1 = 1, "Power (+5V)"
        2 = 2, "Data Negative"
        3 = 3, "Data Positive"
        4 = 4, "Identification (OTG)"
        5 = 5, "Ground"
    ]
}

// ---------------------------------------------------------------------------------------------
// USB 3.x Connectors
// ---------------------------------------------------------------------------------------------
// USB 3.x Type A Connector (Standard-A receptacle: host side)
component USB3.SOCK_TYPEA()
{
    name = "USB 3.x Type A Connector"
    description = "USB 3.x Type A connector"

    spec = [
        type = "USB"
        version = "3.x"
        form_factor = "Type A"
        orientation = _ // [horizontal, vertical]
    ]

    pins = [
        // USB 2.0 pins (backward compatibility)
        1 = 1, "Power (+5V)"
        2 = 2, "Data Negative (USB 2.0)"
        3 = 3, "Data Positive (USB 2.0)"
        4 = 4, "Ground"

        // USB 3.x additional pins (host side: receive on SSRX 5/6, transmit on SSTX 8/9)
        5 = 5, "SuperSpeed RX Negative"
        6 = 6, "SuperSpeed RX Positive"
        7 = 7, "Ground Drain"
        8 = 8, "SuperSpeed TX Negative"
        9 = 9, "SuperSpeed TX Positive"
    ]
}

// USB 3.x Type B Connector (Standard-B receptacle: device side, 9 pins, no ID pin)
component USB3.SOCK_TYPEB()
{
    name = "USB 3.x Type B Connector"
    description = "USB 3.x Type B connector"

    spec = [
        type = "USB"
        version = "3.x"
        form_factor = "Type B"
        mount = _ // [through-hole, surface-mount]
    ]

    pins = [
        // USB 2.0 pins (backward compatibility)
        1 = 1, "Power (+5V)"
        2 = 2, "Data Negative (USB 2.0)"
        3 = 3, "Data Positive (USB 2.0)"
        4 = 4, "Ground"

        // USB 3.x additional pins (device side: transmit on SSTX 5/6, receive on SSRX 8/9)
        5 = 5, "SuperSpeed TX Negative"
        6 = 6, "SuperSpeed TX Positive"
        7 = 7, "Ground Drain"
        8 = 8, "SuperSpeed RX Negative"
        9 = 9, "SuperSpeed RX Positive"
    ]
}

// USB 3.x Micro B Connector
component USB3.SOCK_MICROB()
{
    name = "USB 3.x Micro B Connector"
    description = "USB 3.x Micro B connector"

    spec = [
        type = "USB"
        version = "3.x"
        form_factor = "Micro B"
        orientation = _ // [horizontal, vertical]
    ]

    pins = [
        // USB 2.0 pins (backward compatibility)
        1 = 1, "Power (+5V)"
        2 = 2, "Data Negative (USB 2.0)"
        3 = 3, "Data Positive (USB 2.0)"
        4 = 4, "Identification (OTG)"
        5 = 5, "Ground"

        // USB 3.x additional pins (device side: transmit on SSTX 6/7, receive on SSRX 9/10)
        6 = 6, "SuperSpeed TX Negative"
        7 = 7, "SuperSpeed TX Positive"
        8 = 8, "Ground Drain"
        9 = 9, "SuperSpeed RX Negative"
        10 = 10, "SuperSpeed RX Positive"
    ]
}

// ---------------------------------------------------------------------------------------------
// USB-C Connector
// ---------------------------------------------------------------------------------------------
// USB-C Connector: A1-B12 numbering, same system as the USB.C interface
component USB.SOCK_C()
{
    name = "USB Type C Connector"
    description = "USB Type C connector"

    spec = [
        type = "USB"
        version = "3.1/3.2"
        form_factor = "Type C"
        mount = _ // [through-hole, surface-mount]
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

// ---------------------------------------------------------------------------------------------
// Usage Examples
// ---------------------------------------------------------------------------------------------
// 1. USB 2.0 Type A connector

// USB.SOCK_TYPEA()

// 2. USB 2.0 Micro B connector
// USB.SOCK_MICROB()

// 3. USB 3.x Type A connector
// USB3.SOCK_TYPEA()

// 4. USB-C connector
// USB.SOCK_C()
