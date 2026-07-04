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

# Basic Inductor Component
# Generic inductor with fundamental parameters
component IND(ind::UV.IND, maxi::UV.AMP, esr::UV.OHM)
{
    name = "Inductor"
    spec = [
        inductance = ind
        maximum_current = maxi
        equivalent_series_resistance = esr
    ]
    
    pins = [
        1 = PIN1            # First terminal
        2 = PIN2            # Second terminal
    ]
    
    func Filter(input, output)
    {
        input - this.PIN1
        this.PIN2 - output
        return this
    }
    
    func EnergyStorage(power_supply, load)
    {
        power_supply - this.PIN1
        this.PIN2 - load
        return this
    }
}

# Power Inductor
# Inductor designed for power supply applications
component IND.POWER(ind::UV.IND, maxi::UV.AMP, isat::UV.AMP, esr::UV.OHM)
{
    name = "Power Inductor"
    spec = [
        inductance = ind
        maximum_current = maxi
        saturation_current = isat
        equivalent_series_resistance = esr
    ]
    
    pins = [
        1 = PIN1            # First terminal
        2 = PIN2            # Second terminal
    ]
    
    func DcToDcConverter(input, output)
    {
        input - this.PIN1
        this.PIN2 - output
        return this
    }
}

# High Frequency Inductor
# Inductor designed for high frequency applications
component IND.HF(ind::UV.IND, maxi::UV.AMP, srf::UV.HZ, esr::UV.OHM)
{
    name = "High Frequency Inductor"
    spec = [
        inductance = ind
        maximum_current = maxi
        self_resonant_frequency = srf
        equivalent_series_resistance = esr
    ]
    
    pins = [
        1 = PIN1            # First terminal
        2 = PIN2            # Second terminal
    ]
    
    func RFFilter(input, output)
    {
        input - this.PIN1
        this.PIN2 - output
        return this
    }
}

# Common Mode Choke
# Inductor designed to suppress common mode noise
component IND.CMC(ind::UV.IND, maxi::UV.AMP, imp::UV.OHM, freq::UV.HZ)
{
    name = "Common Mode Choke"
    spec = [
        inductance = ind
        maximum_current = maxi
        impedance = imp
        test_frequency = freq
    ]
    
    pins = [
        1 = IN1             # Input for first winding
        2 = OUT1            # Output for first winding
        3 = IN2             # Input for second winding
        4 = OUT2            # Output for second winding
    ]
    
    func NoiseSuppressor(signal_in, signal_out, ground_in, ground_out)
    {
        signal_in - this.IN1
        this.OUT1 - signal_out
        ground_in - this.IN2
        this.OUT2 - ground_out
        return this
    }
}

# Ferrite Bead
# Ferrite component for high frequency noise suppression
component IND.FB(imp::UV.OHM, maxi::UV.AMP, freq::UV.HZ)
{
    name = "Ferrite Bead"
    spec = [
        impedance = imp
        maximum_current = maxi
        test_frequency = freq
    ]
    
    pins = [
        1 = PIN1            # First terminal
        2 = PIN2            # Second terminal
    ]
    
    func NoiseSuppressor(signal_in, signal_out)
    {
        signal_in - this.PIN1
        this.PIN2 - signal_out
        return this
    }
}

# Usage Examples:
# 1. Basic inductor as filter
# IND(100μH, 1.0A, 0.1Ω).Filter(input_signal, filtered_output)

# 2. Power inductor for DC-DC converter
# IND.POWER(47μH, 3.0A, 4.0A, 0.05Ω).DcToDcConverter(input_voltage, output_voltage)

# 3. High frequency inductor for RF filter
# IND.HF(10μH, 0.5A, 50MHz, 0.2Ω).RFFilter(rf_input, filtered_rf)

# 4. Common mode choke for noise suppression
# IND.CMC(100μH, 2.0A, 100Ω, 100MHz).NoiseSuppressor(data_in, data_out, gnd_in, gnd_out)

# 5. Ferrite bead for high frequency noise suppression
# IND.FB(100Ω, 1.0A, 100MHz).NoiseSuppressor(signal_in, signal_out)
