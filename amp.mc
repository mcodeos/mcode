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

# General Purpose Operational Amplifier
# Basic op-amp with power supply pins
component AMP(volt::UV.VOLT)
{
    pins = [
        1 = \+ | IN\+      # Non-inverting input
        2 = \- | IN\-      # Inverting input
        3 = VOUT          # Output
        [4,5] = DC{VCC,VEE}::DC(volt), ["Positive power supply", "Negative power supply (or ground)"]
    ]
}

# Instrumentation Amplifier
# High-precision amplifier with differential inputs and high common-mode rejection
component AMP.INSTRUMENTATION(gain::UV.DB, cmrr::UV.DB, bw::UV.HZ, volt::UV.VOLT)
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
        4 = VOUT           # Output
        [5,6] = DC{VCC,VEE}::DC(volt), ["Positive power supply", "Negative power supply (or ground)"]
    ]
    
    func DifferentialAmplifier(input1, input2, ref)
    {
        input1 - this.IN\+
        input2 - this.IN\-
        ref - this.REF
        return this.VOUT
    }
}

# Comparator
# Voltage comparator with open-drain or push-pull output
component AMP.COMPARATOR(hyst::UV.VOLT, tresp::UV.TIME, volt::UV.VOLT)
{
    name = "Comparator"
    spec = [
        hysteresis = hyst
        response_time = tresp
        voltage = volt
    ]
    
    pins = [
        1 = \+ | IN\+      # Non-inverting input
        2 = \- | IN\-      # Inverting input
        3 = VOUT          # Output
        [4,5] = DC{VCC,GND}::DC(volt), ["Positive power supply", "Ground"]
    ]
    
    func VoltageComparator(reference, input)
    {
        reference - this.IN\-
        input - this.IN\+
        return this.VOUT
    }
}

# Operational Transconductance Amplifier (OTA)
# Voltage-to-current converter
component AMP.OTA(gm::UV.SIEMENS, iout::UV.AMP, volt::UV.VOLT)
{
    name = "Operational Transconductance Amplifier"
    spec = [
        transconductance = gm
        maximum_output_current = iout
        voltage = volt
    ]
    
    pins = [
        1 = \+ | IN\+      # Non-inverting input
        2 = \- | IN\-      # Inverting input
        3 = OUT            # Output
        [4,5] = DC{VCC,VEE}::DC(volt), ["Positive power supply", "Negative power supply (or ground)"]
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
component AMP.BUFFER(zin::UV.OHM, iout::UV.AMP, volt::UV.VOLT)
{
    name = "Buffer Amplifier"
    spec = [
        input_impedance = zin
        maximum_output_current = iout
        voltage = volt
    ]
    
    pins = [
        1 = IN             # Input
        2 = OUT            # Output
        [3,4] = DC{VCC,VEE}::DC(volt), ["Positive power supply", "Negative power supply (or ground)"]
    ]
    
    func UnityGainBuffer(input)
    {
        input - this.IN
        return this.OUT
    }
}

# Usage Examples:
# 1. Basic operational amplifier
# AMP(12V)

# 2. Instrumentation amplifier as differential amplifier
# output = AMP.INSTRUMENTATION(60dB, 120dB, 1MHz, 15V).DifferentialAmplifier(sensor_pos, sensor_neg, ground)

# 3. Comparator as voltage level detector
# output = AMP.COMPARATOR(50mV, 10ns, 5V).VoltageComparator(reference_voltage, input_voltage)

# 4. OTA as voltage-controlled current source
# current_output = AMP.OTA(1mS, 100mA, 12V).VoltageToCurrentConverter(control_voltage, bias_current)

# 5. Buffer amplifier for impedance matching
# buffered_signal = AMP.BUFFER(1TΩ, 50mA, 9V).UnityGainBuffer(high_impedance_input)
