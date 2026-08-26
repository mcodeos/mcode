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

# ---------------------------------------------------------------------------------------------
# Transformer Components
# ---------------------------------------------------------------------------------------------

# This file defines various transformer components for electrical and electronic circuits.

# Components included:

# - XFR: Basic transformer with primary and secondary windings
# - XFR.POWER: Power transformer with frequency specification
# - XFR.AUDIO: Audio transformer with impedance matching
# - XFR.ISO: Isolation transformer with isolation voltage rating
# - XFR.CT: Center-tapped transformer with center tap on secondary winding
# Basic Transformer Component
# Generic transformer with primary and secondary windings
# Parameters:
# - vpri: Primary voltage rating
# - vsec: Secondary voltage rating
# - prated: Power rating
component XFR(vpri::UV.VOLT, vsec::UV.VOLT, prated::UV.WATT)
{
    name = "Transformer"
    spec = [
        primary_voltage = vpri // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec // [5V, 9V, 12V, 24V]
        power_rating = prated // [1W, 5W, 10W, 50W, 100W]
    ]
    pins = [
        1 = PRIMARY\+
        2 = PRIMARY\-
        3 = SECONDARY\+
        4 = SECONDARY\-
    ]
}
# Power Transformer Component
# Transformer designed for power supply applications
component XFR.POWER(vpri::UV.VOLT, vsec::UV.VOLT, prated::UV.WATT, freq::UV.HZ)
{
    name = "Power Transformer"
    spec = [
        primary_voltage = vpri // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec // [5V, 9V, 12V, 24V]
        power_rating = prated // [1W, 5W, 10W, 50W, 100W]
        frequency = freq // [50Hz, 60Hz]
    ]
    pins = [
        1 = PRIMARY\+
        2 = PRIMARY\-
        3 = SECONDARY\+
        4 = SECONDARY\-
    ]
}
# Audio Transformer Component
# Transformer designed for audio applications with impedance matching
# Parameters:
# - zpri: Primary impedance
# - zsec: Secondary impedance
# - prated: Power rating
# - freq_resp: Frequency response
component XFR.AUDIO(zpri::UV.OHM, zsec::UV.OHM, prated::UV.WATT)
{
    name = "Audio Transformer"
    spec = [
        primary_impedance = zpri // [8Ω, 50Ω, 600Ω]
        secondary_impedance = zsec // [8Ω, 50Ω, 600Ω]
        power_rating = prated // [0.1W, 0.5W, 1W, 5W]
        frequency_response = _ // [20Hz-20kHz, 50Hz-15kHz]
    ]
    pins = [
        1 = PRIMARY\+
        2 = PRIMARY\-
        3 = SECONDARY\+
        4 = SECONDARY\-
    ]
}
# Isolation Transformer Component
# Transformer designed for electrical isolation between circuits
# Parameters:
# - vpri: Primary voltage rating
# - vsec: Secondary voltage rating
# - viso: Isolation voltage rating
# - prated: Power rating
component XFR.ISO(vpri::UV.VOLT, vsec::UV.VOLT, viso::UV.VOLT, prated::UV.WATT)
{
    name = "Isolation Transformer"
    spec = [
        primary_voltage = vpri // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec // [12V, 24V, 120V, 240V]
        isolation_voltage = viso // [500V, 1000V, 2000V, 5000V]
        power_rating = prated // [1W, 5W, 10W, 50W]
    ]
    pins = [
        1 = PRIMARY\+
        2 = PRIMARY\-
        3 = SECONDARY\+
        4 = SECONDARY\-
    ]
}
# Center-Tapped Transformer Component
# Transformer with center tap on secondary winding for split voltage applications
# Parameters:
# - vpri: Primary voltage rating
# - vsec: Secondary voltage rating
# - prated: Power rating
component XFR.CT(vpri::UV.VOLT, vsec::UV.VOLT, prated::UV.WATT)
{
    name = "Center Tapped Transformer"
    spec = [
        primary_voltage = vpri // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec // [9V, 12V, 24V, 36V]
        power_rating = prated // [1W, 5W, 10W, 50W]
    ]
    pins = [
        1 = PRIMARY\+
        2 = PRIMARY\-
        3 = SECONDARY\+
        4 = SECONDARY.CT
        5 = SECONDARY\-
    ]
}