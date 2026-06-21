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

# Filter components
component FILTER.LP(f_cut::UV.HZ, ripple::UV.DB, atten::UV.DB)
{
    name = "Low Pass Filter"
    spec = [
        cutoff_frequency = f_cut
        pass_band_ripple = ripple
        stop_band_attenuation = atten
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.HP(f_cut::UV.HZ, ripple::UV.DB, atten::UV.DB)
{
    name = "High Pass Filter"
    spec = [
        cutoff_frequency = f_cut
        pass_band_ripple = ripple
        stop_band_attenuation = atten
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.BP(f_low::UV.HZ, f_high::UV.HZ, ripple::UV.DB, atten::UV.DB)
{
    name = "Band Pass Filter"
    spec = [
        lower_cutoff = f_low
        upper_cutoff = f_high
        pass_band_ripple = ripple
        stop_band_attenuation = atten
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.BS(f_low::UV.HZ, f_high::UV.HZ, ripple::UV.DB, atten::UV.DB)
{
    name = "Band Stop Filter"
    spec = [
        lower_cutoff = f_low
        upper_cutoff = f_high
        pass_band_ripple = ripple
        stop_band_attenuation = atten
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.NOTCH(f_center::UV.HZ, bw::UV.HZ, atten::UV.DB)
{
    name = "Notch Filter"
    spec = [
        center_frequency = f_center
        bandwidth = bw
        stop_band_attenuation = atten
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.AP(phase::UV.ANGLE, freq_range::STRING)
{
    name = "All Pass Filter"
    spec = [
        phase_shift = phase
        frequency_range = freq_range
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.ACTIVE(f_low::UV.HZ, f_high::UV.HZ, gain::UV.DB, volt::UV.VOLT)
{
    name = "Active Filter"
    spec = [
        low_pass = f_low
        high_pass = f_high
        gain = gain
        supply_voltage = volt
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = VCC
        4 = GND
    ]
}
component FILTER.SC(f_cut::UV.HZ, f_clk::UV.HZ, volt::UV.VOLT)
{
    name = "Switched Capacitor Filter"
    spec = [
        cutoff_frequency = f_cut
        clock_frequency = f_clk
        supply_voltage = volt
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = CLOCK
        4 = VCC
        5 = GND
    ]
}