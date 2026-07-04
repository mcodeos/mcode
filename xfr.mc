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
# - v_pri: Primary voltage rating
# - v_sec: Secondary voltage rating
# - p: Power rating
component XFR(v_pri::UV.VOLT, v_sec::UV.VOLT, p::UV.WAT)
{
    name = "Transformer"
    spec = [
        primary_voltage = v_pri // [12V, 24V, 120V, 240V]
        secondary_voltage = v_sec // [5V, 9V, 12V, 24V]
        power_rating = p // [1W, 5W, 10W, 50W, 100W]
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
component XFR.POWER(v_pri::UV.VOLT, v_sec::UV.VOLT, p::UV.WAT, f::UV.HZ)
{
    name = "Power Transformer"
    spec = [
        primary_voltage = v_pri // [12V, 24V, 120V, 240V]
        secondary_voltage = v_sec // [5V, 9V, 12V, 24V]
        power_rating = p // [1W, 5W, 10W, 50W, 100W]
        frequency = f // [50Hz, 60Hz]
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
# - z_pri: Primary impedance
# - z_sec: Secondary impedance
# - p: Power rating
# - freq_resp: Frequency response
component XFR.AUDIO(z_pri::UV.OHM, z_sec::UV.OHM, p::UV.WAT)
{
    name = "Audio Transformer"
    spec = [
        primary_impedance = z_pri // [8Ω, 50Ω, 600Ω]
        secondary_impedance = z_sec // [8Ω, 50Ω, 600Ω]
        power_rating = p // [0.1W, 0.5W, 1W, 5W]
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
# - v_pri: Primary voltage rating
# - v_sec: Secondary voltage rating
# - v_iso: Isolation voltage rating
# - p: Power rating
component XFR.ISO(v_pri::UV.VOLT, v_sec::UV.VOLT, v_iso::UV.VOLT, p::UV.WAT)
{
    name = "Isolation Transformer"
    spec = [
        primary_voltage = v_pri // [12V, 24V, 120V, 240V]
        secondary_voltage = v_sec // [12V, 24V, 120V, 240V]
        isolation_voltage = v_iso // [500V, 1000V, 2000V, 5000V]
        power_rating = p // [1W, 5W, 10W, 50W]
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
# - v_pri: Primary voltage rating
# - v_sec: Secondary voltage rating
# - p: Power rating
component XFR.CT(v_pri::UV.VOLT, v_sec::UV.VOLT, p::UV.WAT)
{
    name = "Center Tapped Transformer"
    spec = [
        primary_voltage = v_pri // [12V, 24V, 120V, 240V]
        secondary_voltage = v_sec // [9V, 12V, 24V, 36V]
        power_rating = p // [1W, 5W, 10W, 50W]
    ]
    pins = [
        1 = PRIMARY\+
        2 = PRIMARY\-
        3 = SECONDARY\+
        4 = SECONDARY.CT
        5 = SECONDARY\-
    ]
}