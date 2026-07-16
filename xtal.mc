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

use ./ifs/xtal

# Basic 2-Pin Crystal Component
component XTAL2(f::UV.HZ)
{
    name = "2-Pin Crystal"
    description = "Basic 2-pin crystal oscillator"
    
    spec = [
        frequency = f
    ]

    pins = [
        [1,2] = XTAL{X1,X2}::XTAL() , ["Crystal oscillator input","Crystal oscillator output"]
    ]

    func Cap(gnd)
    {
        CAP cx[1:2].Cap(XTAL.X[1:2], gnd)
        return XTAL
    }
}

# 4-Pin Crystal Component
component XTAL4(f::UV.HZ)
{
    name = "4-Pin Crystal"
    description = "4-pin crystal oscillator with NC pins"
    
    spec = [
        frequency = f
    ]
    
    pins = [
        [1,3] = XTAL{X1,X2}::XTAL() , ["Crystal oscillator input","Crystal oscillator output"]
        2 = NC      , "No connection"
        4 = NC      , "No connection"
    ]

    func Cap(gnd)
    {
        CAP cx[1:2].Cap(XTAL.X[1:2], gnd)
        return XTAL
    }
}

# Oscillator Component
component OSC(f::UV.HZ)
{
    name = "Oscillator"
    description = "Active oscillator module"
    
    spec = [
        frequency = f
    ]
    
    pins = [
        1 = NC  , "No connection"
        2 = GND , "Ground"
        3 = XTAL , "Oscillator output"
        4 = VDD , "Power supply"
    ]
}

# Ceramic Resonator Component
component XTAL.CERAMIC(f::UV.HZ)
{
    name = "Ceramic Resonator"
    description = "Ceramic resonator for timing applications"
    
    spec = [
        frequency = f
    ]
    
    pins = [
        [1,2] = XTAL{X1,X2}::XTAL() , ["Resonator input","Resonator output"]
    ]
}

# Surface Mount Crystal Component
component XTAL.SMD(freq::UV.HZ, cload::UV.CAP)
{
    name = "SMD Crystal"
    description = "Surface mount crystal oscillator"
    
    spec = [
        frequency = freq
        load_capacitance = cload
    ]
    
    pins = [
        [1,2] = XTAL{X1,X2}::XTAL() , ["Crystal oscillator input","Crystal oscillator output"]
    ]

    func Cap(gnd)
    {
        CAP cx[1:2].Cap(XTAL.X[1:2], gnd)
        return XTAL
    }
}

# Usage Examples:
# 1. Basic 2-pin crystal with capacitors
# XTAL2(16MHz).Cap(gnd)

# 2. 4-pin crystal with capacitors
# XTAL4(24MHz).Cap(gnd)

# 3. Active oscillator module
# OSC(10MHz)

# 4. Ceramic resonator
# XTAL.CERAMIC(8MHz)

# 5. SMD crystal with specified load capacitance
# XTAL.SMD(32.768kHz, 12pF).Cap(gnd)

