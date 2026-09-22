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

# Basic Antenna Component
# Generic antenna with fundamental parameters
component ANT(freq::UV.HZ, gain::UV.DB, impd::UV.OHM)
{
    name = "Antenna"
    spec = [
        frequency = freq // [433MHz, 868MHz, 900MHz, 2.4GHz, 5.8GHz]
        gain = gain // [1dBi, 2dBi, 3dBi, 5dBi, 8dBi]
        impedance = impd // [50Ω, 75Ω]
    ]

    pins = [
        1 = ANT @class(analog)    # Antenna connection, RF continuous-wave port
    ]
}

# Whip Antenna
# Common telescoping antenna for handheld devices
component ANT.WHIP(freq::UV.HZ, gain::UV.DB, impd::UV.OHM)
{
    name = "Whip Antenna"
    spec = [
        frequency = freq // [433MHz, 868MHz, 900MHz, 2.4GHz]
        gain = gain // [1dBi, 1.5dBi, 2dBi]
        impedance = impd // [50Ω, 75Ω]
        wave_length = _ // [0.1m, 0.2m, 0.3m]
    ]

    pins = [
        1 = ANT @class(analog)    # Antenna connection, RF continuous-wave port
    ]
}

# Patch Antenna
# Flat antenna commonly used in wireless devices
component ANT.PATCH(freq::UV.HZ, gain::UV.DB, impd::UV.OHM)
{
    name = "Patch Antenna"
    spec = [
        frequency = freq // [2.4GHz, 5.8GHz, 10GHz]
        gain = gain // [2dBi, 3dBi, 5dBi]
        impedance = impd // [50Ω, 75Ω]
        polarization = _ // [linear, circular]
    ]

    pins = [
        1 = ANT @class(analog)    # Antenna connection, RF continuous-wave port
        2 = GND            # Ground plane
    ]
}

# Dipole Antenna
# Balanced antenna with two conductive elements
component ANT.DIPOLE(freq::UV.HZ, gain::UV.DB, impd::UV.OHM)
{
    name = "Dipole Antenna"
    spec = [
        frequency = freq // [433MHz, 868MHz, 900MHz, 2.4GHz]
        gain = gain // [2dBi, 3dBi]
        impedance = impd // [50Ω, 75Ω]
        length = _ // [0.1m, 0.15m, 0.2m]
    ]

    pins = [
        1 = ANT @class(analog)    # Antenna connection, RF continuous-wave port
    ]
}

# Helical Antenna
# Spiral antenna for circular polarization
component ANT.HELICAL(freq::UV.HZ, gain::UV.DB, impd::UV.OHM)
{
    name = "Helical Antenna"
    spec = [
        frequency = freq // [1GHz, 1.5GHz, 2.4GHz]
        gain = gain // [5dBi, 8dBi, 10dBi]
        impedance = impd // [50Ω, 75Ω]
        turns = _ // [5, 10, 15, 20]
    ]

    pins = [
        1 = ANT @class(analog)    # Antenna connection, RF continuous-wave port
        2 = GND            # Ground plane
    ]
}

# Log Periodic Antenna
# Wideband antenna with logarithmic periodic structure
component ANT.LOGPERIODIC(fstart::UV.HZ, fend::UV.HZ, gain::UV.DB, impd::UV.OHM)
{
    name = "Log Periodic Antenna"
    spec = [
        frequency_start = fstart // [88MHz, 1MHz, 100MHz]
        frequency_end = fend // [108MHz, 1GHz, 2GHz]
        gain = gain // [3dBi, 5dBi, 8dBi]
        impedance = impd // [50Ω, 75Ω]
    ]

    pins = [
        1 = ANT @class(analog)    # Antenna connection, RF continuous-wave port
    ]
}

# Usage Examples:
# The antenna port is a single RF pin; wire it straight to the radio's
# antenna terminal. Application-specific wrappers (HandheldRadio etc.)
# were demo call sites promoted to API shape and retired in U189.
# ANT(2.4GHz, 2.1dBi, 50Ω) ant1
# rf_out -> ant1.ANT
# ANT.WHIP(433MHz, 1.5dBi, 50Ω) whp1
# trx.ANT -> whp1.ANT
# ANT.PATCH(5.8GHz, 3.2dBi, 50Ω) pat1
# wifi_module.ANT -> pat1.ANT
# pat1.GND -> board_gnd
