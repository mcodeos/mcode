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

// ---------------------------------------------------------------------------------------------
// Circular Connector Definitions
// ---------------------------------------------------------------------------------------------

// Basic Circular Connector
component CIRC.BASIC(pin_count::INT)
{
    name = "Circular Connector"
    description = "Basic circular connector with " + pin_count + " pins"
    
    spec = [
        pin_count = pin_count
        diameter = _ // [8mm, 10mm, 12mm, 16mm, 20mm] ？
        thread = _ // [M8, M10, M12, M16, 1/4-20, 3/8-16] ？
    ]
    
    pins = [
        1:pin_count = 1:pin_count 

    ]
}

// MIL-SPEC Circular Connector (MS Connector)
component CIRC.MIL_SPEC(pin_count::INT)
{
    name = "MIL-SPEC Circular Connector"
    description = "MIL-SPEC circular connector, " + pin_count + " pins"
    
    spec = [
        series = _ // [MS3102, MS3106, MS3108, MS3110]
        shell_size = _ // [8, 10, 12, 14, 16]
        pin_count = pin_count
        standard = "MIL-SPEC"
    ]
    
    pins = [
        1:pin_count = 1:pin_count
    ]
}

// DIN 41612 Connector (Commonly used in industrial equipment)
component CIRC.DIN41612(pin_count::INT)
{
    name = "DIN 41612 Connector"
    description = "DIN 41612 circular connector, " + pin_count + " pins"
    
    spec = [
        standard = "DIN 41612"
        size = _ // [1, 2, 3, 4, 5]
        pin_count = pin_count
    ]
    
    pins = [
        1:pin_count = 1:pin_count
    ]
}

// BNC Connector (RF Coaxial Connector)
component CIRC.BNC(impedance::STRING = "50Ω")
{
    name = "BNC Connector"
    description = "BNC RF coaxial connector, " + impedance + " impedance"
    
    spec = [
        type = "BNC"
        impedance = impedance
        application = "RF, Video"
    ]
    
    pins = [
        1 = Center, "Center Conductor"
        2 = GND, "Ground Shield"
    ]
}

// SMA Connector (RF Coaxial Connector)
component CIRC.SMA(impedance::STRING = "50Ω")
{
    name = "SMA Connector"
    description = "SMA RF coaxial connector, " + impedance + " impedance"
    
    spec = [
        type = "SMA"
        impedance = impedance
        application = "RF, Microwave"
    ]
    
    pins = [
        1 = Center, "Center Conductor"
        2 = GND, "Ground Shield"
    ]
}

// Usage Examples:
// 1. Basic circular connector
// CIRC.BASIC(5)

// 2. MIL-SPEC connector
// CIRC.MIL_SPEC(10)

// 3. DIN 41612 connector
// CIRC.DIN41612(16)

// 4. BNC connector
// CIRC.BNC("50Ω")

// 5. SMA connector
// CIRC.SMA("50Ω")
