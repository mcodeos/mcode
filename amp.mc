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

# General Purpose Operational Amplifier
# Basic op-amp with power supply pins
component Amplifier(volt::UV.VOLT = 5V)
{
    pins = [
        1 = \+ | IN\+      # Non-inverting input
        2 = \- | IN\-      # Inverting input
        3 = Vout          # Output
        [4,5] = DC{Vcc,Vee}::DC(volt), ["Positive power supply", "Negative power supply (or ground)"]
    ]
}

# Instrumentation Amplifier
# High-precision amplifier with differential inputs and high common-mode rejection
component Amplifier.INSTRUMENTATION(gain::UV.DB, cmrr::UV.DB, bw::UV.HZ, volt::UV.VOLT = 5V)
{
    name = "Instrumentation Amplifier"
    spec = [
        gain = gain
        common_mode_rejection_ratio = cmrr
        bandwidth = bw
        voltage = volt
    ]
    
    pins = [
        1 = \+ | IN\+      # Non-inverting input
        2 = \- | IN\-      # Inverting input
        3 = REF            # Reference voltage
        4 = Vout           # Output
        [5,6] = DC{Vcc,Vee}::DC(volt), ["Positive power supply", "Negative power supply (or ground)"]
    ]
    
    func DifferentialAmplifier(input1, input2, ref)
    {
        input1 - this.IN\+
        input2 - this.IN\-
        ref - this.REF
        return this.Vout
    }
}

# Comparator
# Voltage comparator with open-drain or push-pull output
component Amplifier.COMPARATOR(hyst::UV.VOLT, t_resp::UV.TIME, volt::UV.VOLT = 5V)
{
    name = "Comparator"
    spec = [
        hysteresis = hyst
        response_time = t_resp
        voltage = volt
    ]
    
    pins = [
        1 = \+ | IN\+      # Non-inverting input
        2 = \- | IN\-      # Inverting input
        3 = Vout          # Output
        [4,5] = DC{Vcc,GND}::DC(volt), ["Positive power supply", "Ground"]
    ]
    
    func VoltageComparator(reference, input)
    {
        reference - this.IN\-
        input - this.IN\+
        return this.Vout
    }
}

# Operational Transconductance Amplifier (OTA)
# Voltage-to-current converter
component Amplifier.OTA(gm::UV.SIEMENS, i_out::UV.AMP, volt::UV.VOLT = 5V)
{
    name = "Operational Transconductance Amplifier"
    spec = [
        transconductance = gm
        maximum_output_current = i_out
        voltage = volt
    ]
    
    pins = [
        1 = \+ | IN\+      # Non-inverting input
        2 = \- | IN\-      # Inverting input
        3 = OUT            # Output
        [4,5] = DC{Vcc,Vee}::DC(volt), ["Positive power supply", "Negative power supply (or ground)"]
        6 = BIAS           # Bias current control
    ]
    
    func VoltageToCurrentConverter(input, bias)
    {
        input - this.IN\+
        bias - this.BIAS
        return this.OUT
    }
}

# Buffer Amplifier
# Unity gain buffer with high input impedance
component Amplifier.BUFFER(z_in::UV.OHM, i_out::UV.AMP, volt::UV.VOLT = 5V)
{
    name = "Buffer Amplifier"
    spec = [
        input_impedance = z_in
        maximum_output_current = i_out
        voltage = volt
    ]
    
    pins = [
        1 = IN             # Input
        2 = OUT            # Output
        [3,4] = DC{Vcc,Vee}::DC(volt), ["Positive power supply", "Negative power supply (or ground)"]
    ]
    
    func UnityGainBuffer(input)
    {
        input - this.IN
        return this.OUT
    }
}

# Usage Examples:
# 1. Basic operational amplifier
# Amplifier(12V)

# 2. Instrumentation amplifier as differential amplifier
# output = Amplifier.INSTRUMENTATION(60dB, 120dB, 1MHz, 15V).DifferentialAmplifier(sensor_pos, sensor_neg, ground)

# 3. Comparator as voltage level detector
# output = Amplifier.COMPARATOR(50mV, 10ns, 5V).VoltageComparator(reference_voltage, input_voltage)

# 4. OTA as voltage-controlled current source
# current_output = Amplifier.OTA(1mS, 100mA, 12V).VoltageToCurrentConverter(control_voltage, bias_current)

# 5. Buffer amplifier for impedance matching
# buffered_signal = Amplifier.BUFFER(1TΩ, 50mA, 9V).UnityGainBuffer(high_impedance_input)
