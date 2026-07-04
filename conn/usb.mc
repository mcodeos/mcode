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
// Based on interface definitions in ifs/usb.mc

// USB 2.0 Type A Connector
component USB.TYPE_A()
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
component USB.TYPE_B()
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

// USB 2.0 Mini Type B Connector
component USB.MINI_B()
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
        1 = 1, "Power (+5V)"
        2 = 2, "Data Negative"
        3 = 3, "Data Positive"
        4 = 4, "Identification (OTG)"
        5 = 5, "Ground"
    ]
}

// USB 2.0 Micro Type B Connector
component USB.MICRO_B()
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
// USB 3.x Type A Connector
component USB3.TYPE_A()
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
        
        // USB 3.x additional pins
        5 = 5, "SuperSpeed TX Negative"
        6 = 6, "SuperSpeed TX Positive"
        7 = 7, "Ground Drain"
        8 = 8, "SuperSpeed RX Positive"
        9 = 9, "SuperSpeed RX Negative"
    ]
}

// USB 3.x Type B Connector
component USB3.TYPE_B()
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
        4 = 4, "Identification"
        5 = 5, "Ground"
        
        // USB 3.x additional pins
        6 = 6, "SuperSpeed TX Negative"
        7 = 7, "SuperSpeed TX Positive"
        8 = 8, "Ground Drain"
        9 = 9, "SuperSpeed RX Positive"
        10 = 10, "SuperSpeed RX Negative"
    ]
}

// USB 3.x Micro B Connector
component USB3.MICRO_B()
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
        
        // USB 3.x additional pins
        6 = 6, "SuperSpeed TX Negative"
        7 = 7, "SuperSpeed TX Positive"
        8 = 8, "Ground Drain"
        9 = 9, "SuperSpeed RX Positive"
        10 = 10, "SuperSpeed RX Negative"
    ]
}

// ---------------------------------------------------------------------------------------------
// USB-C Connector
// ---------------------------------------------------------------------------------------------
// USB-C Connector
component USB.C()
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
        1 = 1, "Power"
        2 = 2, "SuperSpeed RX2 Negative"
        3 = 3, "SuperSpeed RX2 Positive"
        4 = 4, "Ground"
        5 = 5, "Configuration Channel 1"
        6 = 6, "USB 2.0 Data Positive"
        7 = 7, "USB 2.0 Data Negative"
        8 = 8, "Sideband Use 1"
        9 = 9, "Power"
        10 = 10, "SuperSpeed TX2 Positive"
        11 = 11, "SuperSpeed TX2 Negative"
        12 = 12, "Ground"
        
        // Bottom row (B side)
        13 = 13, "Power"
        14 = 14, "SuperSpeed TX1 Negative"
        15 = 15, "SuperSpeed TX1 Positive"
        16 = 16, "Ground"
        17 = 17, "Configuration Channel 2"
        18 = 18, "USB 2.0 Data Positive"
        19 = 19, "USB 2.0 Data Negative"
        20 = 20, "Sideband Use 2"
        21 = 21, "Power"
        22 = 22, "SuperSpeed RX1 Positive"
        23 = 23, "SuperSpeed RX1 Negative"
        24 = 24, "Ground"
    ]
}

// ---------------------------------------------------------------------------------------------
// Usage Examples
// ---------------------------------------------------------------------------------------------
// 1. USB 2.0 Type A connector

// USB.TYPE_A()

// 2. USB 2.0 Micro B connector
// USB.MICRO_B()

// 3. USB 3.x Type A connector
// USB3.TYPE_A()

// 4. USB-C connector
// USB.C()
