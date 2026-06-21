# Copyright 2026 MCode Alliance
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
        [1,2] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
        [3,4] = [D\+,D\-], ["Data Positive", "Data Negative"]
    ]
    
    role Host {  // USB Host - Controls the bus
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {  // USB Device - Peripheral device
        name = "USB Device"
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
        [2,3] = [D\+,D\-], ["Data Negative", "Data Positive"]
    ]

    role Host { 
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
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
        [2,3] = [D\+,D\-], ["Data Negative", "Data Positive"]
    ]

    role Host { 
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
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
        [2,3] = [D\+,D\-], ["Data Negative", "Data Positive"]
        4 = ID, "ID"                // Identification pin (for OTG)
    ]

    role Host { 
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
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
        [2,3] = [D\+,D\-], ["Data Negative", "Data Positive"]
        4 = ID, "ID"                // Identification pin (for OTG)
    ]

    role Host { 
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
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
        [2,3] = [D\+,D\-], ["Data Negative", "Data Positive"]
        
        // USB 3.x additional pins
        5 = SSTX\-, "SuperSpeed TX Negative"  // SuperSpeed transmit negative
        6 = SSTX\+, "SuperSpeed TX Positive"  // SuperSpeed transmit positive
        7 = GND_DRAIN, "Ground Drain"        // Ground drain
        8 = SSRX\+, "SuperSpeed RX Positive"  // SuperSpeed receive positive
        9 = SSRX\-, "SuperSpeed RX Negative"  // SuperSpeed receive negative
    ]

    role Host { 
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
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
        [1,5] = [VBUS, GND]::DC(5V), ["Power", "Ground"]
        [2,3] = [D\+,D\-], ["Data Negative", "Data Positive"]
        4 = ID, "ID"                // Identification pin
        
        // USB 3.x additional pins
        6 = SSTX\-, "SuperSpeed TX Negative"  // SuperSpeed transmit negative
        7 = SSTX\+, "SuperSpeed TX Positive"  // SuperSpeed transmit positive
        8 = GND_DRAIN, "Ground Drain"        // Ground drain
        9 = SSRX\+, "SuperSpeed RX Positive"  // SuperSpeed receive positive
        10 = SSRX\-, "SuperSpeed RX Negative" // SuperSpeed receive negative
    ]

    role Host { 
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
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
        [2,3] = [D\+,D\-], ["Data Negative", "Data Positive"]
        4 = ID, "ID"                // Identification pin (for OTG)
        
        // USB 3.x additional pins
        6 = SSTX\-, "SuperSpeed TX Negative"  // SuperSpeed transmit negative
        7 = SSTX\+, "SuperSpeed TX Positive"  // SuperSpeed transmit positive
        8 = GND_DRAIN, "Ground Drain"        // Ground drain
        9 = SSRX\+, "SuperSpeed RX Positive"  // SuperSpeed receive positive
        10 = SSRX\-, "SuperSpeed RX Negative" // SuperSpeed receive negative
    ]
    
    role Host { 
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
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
        A2 = SSRX2\-, "SuperSpeed RX2 Negative"  // SuperSpeed receive pair 2 negative
        A3 = SSRX2\+, "SuperSpeed RX2 Positive"  // SuperSpeed receive pair 2 positive
        A4 = VBUS, "Power"           // +5V power (Power Delivery capable)
        A5 = CC1, "Configuration Channel 1"  // Configuration channel
        A6 = USB2_D\+, "USB 2.0 Data Positive"  // USB 2.0 positive data line
        A7 = USB2_D\-, "USB 2.0 Data Negative"  // USB 2.0 negative data line
        A8 = SBU1, "Sideband Use 1"  // Sideband use pin
        A9 = VBUS, "Power"           // +5V power (Power Delivery capable)
        A10 = SSTX2\+, "SuperSpeed TX2 Positive"  // SuperSpeed transmit pair 2 positive
        A11 = SSTX2\-, "SuperSpeed TX2 Negative"  // SuperSpeed transmit pair 2 negative
        A12 = GND, "Ground"           // Ground
        
        // Bottom row (B side)
        B1 = GND, "Ground"           // Ground
        B2 = SSTX1\-, "SuperSpeed TX1 Negative"  // SuperSpeed transmit pair 1 negative
        B3 = SSTX1\+, "SuperSpeed TX1 Positive"  // SuperSpeed transmit pair 1 positive
        B4 = VBUS, "Power"           // +5V power (Power Delivery capable)
        B5 = CC2, "Configuration Channel 2"  // Configuration channel
        B6 = USB2_D\+, "USB 2.0 Data Positive"  // USB 2.0 positive data line
        B7 = USB2_D\-, "USB 2.0 Data Negative"  // USB 2.0 negative data line
        B8 = SBU2, "Sideband Use 2"  // Sideband use pin
        B9 = VBUS, "Power"           // +5V power (Power Delivery capable)
        B10 = SSRX1\+, "SuperSpeed RX1 Positive"  // SuperSpeed receive pair 1 positive
        B11 = SSRX1\-, "SuperSpeed RX1 Negative"  // SuperSpeed receive pair 1 negative
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
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
        peer = Host
    }
}

// ---------------------------------------------------------------------------------------------// USB Data Interface// ---------------------------------------------------------------------------------------------// USB Data Interface
interface USB.DATA(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxspeed = [1.5Mbps, 12Mbps, 480Mbps]
    name = "USB Data Interface"
    description = "USB data interface with differential signaling"
    
    pins = [
        1 = D\-, "Data Negative"     // Negative data line
        2 = D\+, "Data Positive"     // Positive data line
    ]
    
    role Host {  // USB Host - Controls the bus
        name = "USB Data Host"
        peer = Device
    }
    role Device {  // USB Device - Peripheral device
        name = "USB Data Device"
        peer = Host
    }

    role Host { 
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
        peer = Host
    }
}

// ---------------------------------------------------------------------------------------------// USB 3.x SuperSpeed Transmit Interface// ---------------------------------------------------------------------------------------------// USB 3.x SuperSpeed Transmit Interface
interface USB3.TX(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxspeed = [5Gbps]
    name = "USB 3.x SuperSpeed Transmit Interface"
    description = "USB 3.x SuperSpeed transmit interface"
    
    pins = [
        1 = SSTX\-, "SuperSpeed TX Negative"  // SuperSpeed transmit negative
        2 = SSTX\+, "SuperSpeed TX Positive"  // SuperSpeed transmit positive
    ]

    role Host { 
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
        peer = Host
    }
}

// ---------------------------------------------------------------------------------------------// USB 3.x SuperSpeed Receive Interface// ---------------------------------------------------------------------------------------------// USB 3.x SuperSpeed Receive Interface
interface USB3.RX(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxspeed = [5Gbps]
    name = "USB 3.x SuperSpeed Receive Interface"
    description = "USB 3.x SuperSpeed receive interface"
    
    pins = [
        1 = SSRX\+, "SuperSpeed RX Positive"  // SuperSpeed receive positive
        2 = SSRX\-, "SuperSpeed RX Negative"  // SuperSpeed receive negative
    ]

    role Host { 
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
        peer = Host
    }
}

// ---------------------------------------------------------------------------------------------// USB Power Delivery// ---------------------------------------------------------------------------------------------// USB Power Delivery
interface USB.PD(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = [3m, 2m]  // Depending on speed
    maxspeed = [5Gbps@3m, 10Gbps@2m]  // SuperSpeed and SuperSpeed+ (USB 3.1/3.2)
    voltage = [5V, 9V, 12V, 15V, 20V]
    current = [3A, 5A]
    power = [15W, 27W, 36W, 45W, 60W, 100W]
    name = "USB Power Delivery"
    description = "USB Power Delivery specification for higher power and voltage"
    
    features = [
        "Variable voltage and current",
        "Bidirectional power flow",
        "Power role swap",
        "Data role swap"
    ]

    role Host { 
        name = "USB Host"
        peer = Peripheral
    }
    role Peripheral {
        name = "USB Peripheral"
        peer = Host
    }
}

