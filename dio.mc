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

# Basic Diode Component
# Generic diode with fundamental parameters
component DIO(v_fwd::UV.VOLT, v_rev::UV.VOLT, i_max::UV.AMP)
{
    name = "Diode"
    spec = [
        forward_voltage = v_fwd
        reverse_voltage = v_rev
        maximum_current = i_max
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func Rectifier(input, output)
    {
        input - this.ANODE
        this.CATHODE - output
        return this
    }
    
    func Freewheeling(load, supply)
    {
        load - this.ANODE
        this.CATHODE - supply
        return this
    }
}

# Schottky Diode
# Fast switching diode with low forward voltage drop
component DIO.SCH(v_fwd::UV.VOLT, v_rev::UV.VOLT, i_max::UV.AMP)
{
    name = "Schottky Diode"
    spec = [
        forward_voltage = v_fwd
        reverse_voltage = v_rev
        maximum_current = i_max
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func FastRectifier(input, output)
    {
        input - this.ANODE
        this.CATHODE - output
        return this
    }
}

# Zener Diode
# Voltage regulating diode that operates in reverse bias
component DIO.ZEN(v_z::UV.VOLT, p::UV.WAT, tol::UV.PERCENT)
{
    name = "Zener Diode"
    spec = [
        zener_voltage = v_z
        power_rating = p
        tolerance = tol
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func VoltageRegulator(inp, outp, gnd)
    {
        inp - this.CATHODE
        this.ANODE - gnd
        outp - this.CATHODE
        return this
    }
}

# Transient Voltage Suppressor (TVS)
# Diode for protecting against voltage spikes
component DIO.TVS(v_br::UV.VOLT, v_clamp::UV.VOLT, p_peak::UV.WAT)
{
    name = "Transient Voltage Suppressor"
    spec = [
        breakdown_voltage = v_br
        clamping_voltage = v_clamp
        peak_power = p_peak
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func SurgeProtector(circ, gnd)
    {
        circ - this.CATHODE
        this.ANODE - gnd
        return this
    }
}

# Photodiode
# Light-sensitive diode that generates current when exposed to light
component DIO.PHOTO(resp::UV.RESPONSIVITY, i_dark::UV.AMP, spec_range::UV.LEN)
{
    name = "Photodiode"
    spec = [
        responsivity = resp
        dark_current = i_dark
        spectral_range = spec_range
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func LightSensor(v_src, outp)
    {
        v_src - this.CATHODE
        this.ANODE - outp
        return outp
    }
}

# Usage Examples:
# 1. Basic diode as rectifier
# DIO(0.7V, 1000V, 1.0A).Rectifier(ac_signal, dc_output)

# 2. Schottky diode for fast rectification
# DIO.SCH(0.3V, 40V, 5.0A).FastRectifier(high_freq_ac, dc_output)

# 3. Zener diode as voltage regulator
# DIO.ZEN(5.1V, 0.5W, 5%).VoltageRegulator(unregulated_input, regulated_output, ground)

# 4. TVS diode for surge protection
# DIO.TVS(12V, 15V, 500W).SurgeProtector(sensitive_circuit, ground)

# 5. Photodiode as light sensor
# light_signal = DIO.PHOTO(0.5A/W, 1nA, 850nm).LightSensor(5.0V, light_output)

# Electrostatic Discharge (ESD) Protection Diode
# Diode for protecting against electrostatic discharge
component DIO.ESD(partno::STRING, rating::STRING)
{
    name = "ESD Protection Diode"
    spec = [
        part_number = partno
        esd_rating = rating
    ]
    
    pins = [
        1 = INPUT        # Input terminal to protect
        2 = GND          # Ground terminal
    ]
    
    func ESDProtection(input_signal, ground)
    {
        input_signal - this.INPUT
        this.GND - ground
        return this
    }
}

