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
        1 = Ant            # Antenna connection
    ]
    
    func RFReceiver(radio)
    {
        radio - this.Ant
        return this
    }
    
    func RFSender(radio)
    {
        radio - this.Ant
        return this
    }
}

# Whip Antenna
# Common telescoping antenna for handheld devices
component ANT.WHIP(freq::UV.HZ, gain::UV.DB)
{
    name = "Whip Antenna"
    spec = [
        frequency = freq // [433MHz, 868MHz, 900MHz, 2.4GHz]
        gain = gain // [1dBi, 1.5dBi, 2dBi]
        wave_length = _ // [0.1m, 0.2m, 0.3m]
    ]
    
    pins = [
        1 = Ant            # Antenna connection
    ]
    
    func HandheldRadio(radio)
    {
        radio - this.Ant
        return this
    }
}

# Patch Antenna
# Flat antenna commonly used in wireless devices
component ANT.PATCH(freq::UV.HZ, gain::UV.DB)
{
    name = "Patch Antenna"
    spec = [
        frequency = freq // [2.4GHz, 5.8GHz, 10GHz]
        gain = gain // [2dBi, 3dBi, 5dBi]
        polarization = _ // [linear, circular]
    ]
    
    pins = [
        1 = Ant            # Antenna connection
        2 = GND            # Ground plane
    ]
    
    func WirelessDevice(transceiver)
    {
        transceiver - this.Ant
        return this
    }
}

# Dipole Antenna
# Balanced antenna with two conductive elements
component ANT.DIPOLE(freq::UV.HZ, gain::UV.DB)
{
    name = "Dipole Antenna"
    spec = [
        frequency = freq // [433MHz, 868MHz, 900MHz, 2.4GHz]
        gain = gain // [2dBi, 3dBi]
        length = _ // [0.1m, 0.15m, 0.2m]
    ]
    
    pins = [
        1 = Ant            # Antenna connection
    ]
    
    func BaseStation(transceiver)
    {
        transceiver - this.Ant
        return this
    }
}

# Helical Antenna
# Spiral antenna for circular polarization
component ANT.HELICAL(freq::UV.HZ, gain::UV.DB)
{
    name = "Helical Antenna"
    spec = [
        frequency = freq // [1GHz, 1.5GHz, 2.4GHz]
        gain = gain // [5dBi, 8dBi, 10dBi]
        turns = _ // [5, 10, 15, 20]
    ]
    
    pins = [
        1 = Ant            # Antenna connection
        2 = GND            # Ground plane
    ]
    
    func SatelliteCommunication(transceiver)
    {
        transceiver - this.Ant
        return this
    }
}

# Log Periodic Antenna
# Wideband antenna with logarithmic periodic structure
component ANT.LOGPERIODIC(freq_start::UV.HZ, freq_end::UV.HZ, gain::UV.DB)
{
    name = "Log Periodic Antenna"
    spec = [
        frequency_start = freq_start // [88MHz, 1MHz, 100MHz]
        frequency_end = freq_end // [108MHz, 1GHz, 2GHz]
        gain = gain // [3dBi, 5dBi, 8dBi]
    ]
    
    pins = [
        1 = Ant            # Antenna connection
    ]
    
    func WidebandReceiver(receiver)
    {
        receiver - this.Ant
        return this
    }
}

# Usage Examples:
# 1. Basic antenna usage
# ANT(2.4GHz, 2.1dBi, 50Ω)

# 2. Whip antenna for handheld radio
# ANT.WHIP(433MHz, 1.5dBi).HandheldRadio(transceiver)

# 3. Patch antenna for WiFi device
# ANT.PATCH(5.8GHz, 3.2dBi).WirelessDevice(wifi_module)

# 4. Dipole antenna for base station
# ANT.DIPOLE(900MHz, 2.1dBi).BaseStation(base_station)

# 5. Helical antenna for satellite communication
# ANT.HELICAL(1.575GHz, 8.0dBi).SatelliteCommunication(sat_modem)

# 6. Log periodic antenna for wideband reception
# ANT.LOGPERIODIC(88MHz, 108MHz, 3.0dBi).WidebandReceiver(fm_receiver)
