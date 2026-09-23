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
        [1,2] = [VCC, GND]::DC(volt)   // source terminal pair
    ]
}

# DC Battery Component
component DC.BAT(volt::UV.VOLT, charge::UV.CHARGE)
{
    name = "DC Battery"
    description = "DC battery"
    
    spec = [
        voltage = volt // [1.5V, 3V, 3.7V, 9V, 12V]
        capacity = charge // [100mAh, 500mAh, 1000mAh, 2000mAh, 5000mAh]
    ]
    
    pins = [
        psbi [1,2] = BAT{VCC, GND}::DC(volt)   // battery: bidirectional source (charge = sink, discharge = source); BAT bus, whole-lead addressable
    ]
}

# Usage Examples:
# This file defines the source primitives DC.SRC and DC.BAT (the DC
# *interface* and power domains are declared elsewhere, in mcode/ifs).
# 1. Fixed supply source feeding a rail
# DC.SRC(12V, 2A) vmain
# vmain.VCC -> vcc_12v
# 2. Logic rail source
# DC.SRC(3.3V, 1A) v3v3
# 3. Battery cells
# DC.BAT(3.7V, 2000mAh) li_ion
# DC.BAT(9V, 500mAh) pp3
# DC.BAT(1.5V, 2500mAh) aa_cell
