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

# Filter components
component FILTER.LP(fcut::UV.HZ, ripple::UV.DB, atten::UV.DB)
{
    name = "Low Pass Filter"
    spec = [
        cutoff_frequency = fcut
        pass_band_ripple = ripple
        stop_band_attenuation = atten
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.HP(fcut::UV.HZ, ripple::UV.DB, atten::UV.DB)
{
    name = "High Pass Filter"
    spec = [
        cutoff_frequency = fcut
        pass_band_ripple = ripple
        stop_band_attenuation = atten
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.BP(flow::UV.HZ, fhigh::UV.HZ, ripple::UV.DB, atten::UV.DB)
{
    name = "Band Pass Filter"
    spec = [
        lower_cutoff = flow
        upper_cutoff = fhigh
        pass_band_ripple = ripple
        stop_band_attenuation = atten
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.BS(flow::UV.HZ, fhigh::UV.HZ, ripple::UV.DB, atten::UV.DB)
{
    name = "Band Stop Filter"
    spec = [
        lower_cutoff = flow
        upper_cutoff = fhigh
        pass_band_ripple = ripple
        stop_band_attenuation = atten
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.NOTCH(fcenter::UV.HZ, bw::UV.HZ, atten::UV.DB)
{
    name = "Notch Filter"
    spec = [
        center_frequency = fcenter
        bandwidth = bw
        stop_band_attenuation = atten
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.AP(phase::UV.ANGLE, frange::STRING)
{
    name = "All Pass Filter"
    spec = [
        phase_shift = phase
        frequency_range = frange
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component FILTER.ACTIVE(flow::UV.HZ, fhigh::UV.HZ, gain::UV.DB, volt::UV.VOLT)
{
    name = "Active Filter"
    spec = [
        low_pass = flow
        high_pass = fhigh
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
component FILTER.SC(fcut::UV.HZ, fclk::UV.HZ, volt::UV.VOLT)
{
    name = "Switched Capacitor Filter"
    spec = [
        cutoff_frequency = fcut
        clock_frequency = fclk
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