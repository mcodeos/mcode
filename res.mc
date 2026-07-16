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

# Resistor Component Definition
component RES(rs::UV.OHM, volt::UV.VOLT)
{
    name = "Resistor"
    spec = [
        resistance = rs // [1Ω, 10Ω, 100Ω, 1kΩ, 10kΩ, 100kΩ, 1MΩ]
        voltage = volt // [5V, 12V, 24V, 50V, 100V, 250V]
        tolerance = _ // [±5%, ±10%, ±20%]
    ]
    package = _

    pins = [ 
        1 = 1
        2 = 2 
    ]
    
    func Pullup(net1, vcc)
    {
        net1 - this - vcc
        return net1
    }

    func Pulldown(net1, gnd)
    {
        net1 - this - gnd
        return net1
    }
}

# Surface Mount Resistor
# Suitable for modern high-density PCB designs
component RES.SMD(rs::UV.OHM, volt::UV.VOLT)
{
    name = "Surface Mount Resistor"
    spec = [
        resistance = rs // [1Ω, 10Ω, 100Ω, 1kΩ, 10kΩ, 100kΩ, 1MΩ]
        voltage = volt // [5V, 12V, 24V, 50V, 100V, 250V]
        tolerance = _ // [±5%, ±10%, ±20%]
    ]

    pins = [ 
        1 = 1
        2 = 2 
    ]
    
    func Pullup(net1, vcc)
    {
        net1 - this - vcc
        return net1
    }

    func Pulldown(net1, gnd)
    {
        net1 - this - gnd
        return net1
    }
}

# Through Hole Resistor
# Suitable for prototyping and repair
component RES.THT(rs::UV.OHM, volt::UV.VOLT)
{
    name = "Through Hole Resistor"
    spec = [
        resistance = rs // [1Ω, 10Ω, 100Ω, 1kΩ, 10kΩ, 100kΩ, 1MΩ]
        voltage = volt // [5V, 12V, 24V, 50V, 100V, 250V]
        tolerance = _ // [±5%, ±10%, ±20%]
    ]

    pins = [ 
        1 = 1
        2 = 2 
    ]
    
    func Pullup(net1, vcc)
    {
        net1 - this - vcc
        return net1
    }

    func Pulldown(net1, gnd)
    {
        net1 - this - gnd
        return net1
    }
}

# Variable Resistor (Potentiometer)
# Suitable for applications requiring adjustable resistance
component RES.POT(rs::UV.OHM, volt::UV.VOLT)
{
    name = "Potentiometer"
    spec = [
        resistance = rs // [1kΩ, 10kΩ, 50kΩ, 100kΩ, 1MΩ]
        voltage = volt // [5V, 12V, 24V, 50V, 100V, 250V]
        tolerance = _ // [±5%, ±10%, ±20%]
    ]

    pins = [ 
        1 = 1
        2 = 2
        3 = 3 
    ]
    
    func VoltageDivider(input, output, gnd)
    {
        input - this[1]
        this[2] - output
        this[3] - gnd
        return output
    }
}

// ---------------------------------------------------------------------------------------------
// RES.THERM — Thermistors (temperature-dependent resistors)
// RES.NTC = Negative Temperature Coefficient (resistance decreases with heat)
// RES.PTC = Positive Temperature Coefficient (resistance increases with heat)
// ---------------------------------------------------------------------------------------------

# Thermistor (generic)
component RES.THERM(rs::UV.OHM, volt::UV.VOLT)
{
    name = "Thermistor"
    spec = [
        resistance = rs // [1kΩ, 10kΩ, 50kΩ, 100kΩ]
        voltage = volt // [5V, 12V, 24V, 50V, 100V, 250V]
        tolerance = _ // [±5%, ±10%, ±20%]
        temperature_coefficient = _
    ]

    pins = [
        1 = 1
        2 = 2
    ]

    func TemperatureSensor(voltage_ref, output)
    {
        voltage_ref - this - output
        return output
    }
}

# NTC Thermistor
# Resistance decreases as temperature rises — commonly used for temperature sensing
component RES.NTC(rs::UV.OHM, beta::INT, volt::UV.VOLT)
{
    name = "NTC Thermistor"
    spec = [
        resistance = rs // [1kΩ, 10kΩ, 50kΩ, 100kΩ]
        beta_coefficient = beta // B-constant (e.g. 3950, 4100)
        voltage = volt // [5V, 12V, 24V, 50V, 100V, 250V]
        tolerance = _ // [±1%, ±5%, ±10%]
        temperature_coefficient = "NTC"
    ]

    pins = [
        1 = 1
        2 = 2
    ]

    func TemperatureSensor(voltage_ref, output)
    {
        voltage_ref - this - output
        return output
    }
}

# PTC Thermistor
# Resistance increases as temperature rises — commonly used for overcurrent protection
component RES.PTC(rs::UV.OHM, i_trip::UV.AMP, volt::UV.VOLT)
{
    name = "PTC Thermistor"
    spec = [
        resistance = rs // [1Ω, 10Ω, 50Ω, 100Ω, 500Ω]
        trip_current = i_trip // Current at which resistance increases sharply
        voltage = volt // [5V, 12V, 24V, 50V, 100V, 250V]
        tolerance = _ // [±5%, ±10%, ±20%]
        temperature_coefficient = "PTC"
    ]

    pins = [
        1 = 1
        2 = 2
    ]

    func OvercurrentProtection(input, output)
    {
        input - this - output
        return output
    }
}

# Usage Examples:
# 1. Basic resistor usage
# RES(100Ω, 250V)

# 2. Pullup resistor usage
# signal = RES(10kΩ, 50V).Pullup(signal, vcc)

# 3. Pulldown resistor usage
# signal = RES(10kΩ, 50V).Pulldown(signal, gnd)

# 4. Surface mount resistor usage
# RES.SMD(470Ω, 150V)

# 5. Through hole resistor usage
# RES.THT(1kΩ, 250V)

# 6. Potentiometer as voltage divider
# output = RES.POT(10kΩ, 250V).VoltageDivider(vcc, output, gnd)

# 7. Thermistor usage (generic)
# temp_signal = RES.THERM(10kΩ, 250V).TemperatureSensor(vcc, temp_signal)

# 8. NTC thermistor (temperature sensing)
# temp_signal = RES.NTC(10kΩ, 3950, 5V).TemperatureSensor(vcc, temp_signal)

# 9. PTC thermistor (overcurrent protection)
# protected = RES.PTC(100Ω, 500mA, 12V).OvercurrentProtection(input, protected)
