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
component DIO(vfwd::UV.VOLT, vrev::UV.VOLT, imax::UV.AMP)
{
    name = "Diode"
    spec = [
        forward_voltage = vfwd
        reverse_voltage = vrev
        maximum_current = imax
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
}

# Electrostatic Discharge (ESD) Protection Diode
# Diode for protecting against electrostatic discharge
component DIO.ESD(rating::UV.VOLT)
{
    name = "ESD Diode"
    spec = [
        esd_rating = rating
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func Protect([input, gnd])
    {
        [input, gnd] - [this.CATHODE, this.ANODE]
        return [input, gnd]
    }
}

# Schottky Diode
# Fast switching diode with low forward voltage drop
component DIO.SCH(vfwd::UV.VOLT, vrev::UV.VOLT, imax::UV.AMP)
{
    name = "Schottky Diode"
    spec = [
        forward_voltage = vfwd
        reverse_voltage = vrev
        maximum_current = imax
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
component DIO.ZEN(vz::UV.VOLT, ppeak::UV.WATT, tol::UV.PERCENT)
{
    name = "Zener Diode"
    spec = [
        zener_voltage = vz
        power_rating = ppeak
        tolerance = tol
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func VoltageRegulator(input, output, gnd)
    {
        input - this.CATHODE
        this.ANODE - gnd
        output - this.CATHODE
        return this
    }
}

# Transient Voltage Suppressor (TVS)
# Diode for protecting against voltage spikes
component DIO.TVS(vbr::UV.VOLT, vclamp::UV.VOLT, ppeak::UV.WATT)
{
    name = "Transient Voltage Suppressor"
    spec = [
        breakdown_voltage = vbr
        clamping_voltage = vclamp
        peak_power = ppeak
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func Protect(input, gnd)
    {
        input - this.CATHODE
        this.ANODE - gnd
        return this
    }
}

# Photodiode
# Light-sensitive diode that generates current when exposed to light
component DIO.PHOTO(resp::UV.RESPONSIVITY, idark::UV.AMP, srange::UV.LEN)
{
    name = "Photodiode"
    spec = [
        responsivity = resp
        dark_current = idark
        spectral_range = srange
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func LightSensor(vcc, output)
    {
        vcc - this.CATHODE
        this.ANODE - output
        return output
    }
}

# Usage Examples:
# 1. Basic diode as rectifier
# DIO(0.7V, 1000V, 1.0A).Rectifier(ac_signal, dc_output)

# 2. Schottky diode for fast rectification
# DIO.SCH(0.3V, 40V, 5.0A).FastRectifier(high_freq_ac, dc_output)

# 3. Zener diode as voltage regulator
# DIO.ZEN(5.1V, 0.5W, 5%).VoltageRegulator(unregulated_input, regulated_output, gnd)

# 4. TVS diode for surge protection
# DIO.TVS(12V, 15V, 500W).SurgeProtector(sensitive_circuit, gnd)

# 5. Photodiode as light sensor
# light_signal = DIO.PHOTO(0.5A/W, 1nA, 850nm).LightSensor(5.0V, light_output)
