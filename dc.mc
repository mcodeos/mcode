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

// ---------------------------------------------------------------------------------------------
// DC Component Definitions
// ---------------------------------------------------------------------------------------------

# DC Power Source Component
component DC.SRC(volt::UV.VOLT, curr::UV.AMP)
{
    name = "DC Power Source"
    description = "DC power supply source"
    
    spec = [
        voltage = volt // [3.3V, 5V, 9V, 12V, 24V]
        current = curr
    ]
    
    pins = [
        [1,2] = [VCC, GND]::DC(volt, Source)
    ]
}

# DC Battery Component
component DC.BAT(volt::UV.VOLT, cap::UV.CAP)
{
    name = "DC Battery"
    description = "DC battery"
    
    spec = [
        voltage = volt // [1.5V, 3V, 3.7V, 9V, 12V]
        capacity = cap // [100mAh, 500mAh, 1000mAh, 2000mAh, 5000mAh]
    ]
    
    pins = [ 
        [1,2] = [\+, \-]::DC(volt, Source)
    ]
}

# Usage Examples:
# 1. Basic usage with explicit voltage
# PowerDomain(dc24v::DC(24V)) // Create a 24V power domain
# PowerDomain(dc15v::DC(15V)) // Create a 15V power domain

# 2. Usage with default 5V voltage
# PowerDomain(dc5v::DC(5V)) // Create a 5V power domain (using default)

# 3. Usage with custom pin names
# PowerDomain(dc15v[VCC15V,GND15V]::DC(15V)) // Specify custom pin names

# 4. Power supply definition with custom pins
# DC.VCC24::DC(24V) // 24V supply with custom pins
# DC.VCC12::DC(12V) // 12V supply with custom pins
# DC.VCC15::DC(15V) // 15V supply with custom positive pin

# 5. Negative voltage supply
# DC.NEG5V::DC(-5V) // -5V negative supply

# 6. Low voltage supply for microcontrollers
# DC.VCC3V3::DC(3.3V) // 3.3V supply
# DC.VCC1V8::DC(1.8V) // 1.8V supply
