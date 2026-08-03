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

// ---------------------------------------------------------------------------------------------
// Resistor Component Definitions — Final Production Version
// No enum; construction uses plain string tag
// Tolerance: integer percentage omit .0, only keep decimal when needed
// ---------------------------------------------------------------------------------------------

// =============================================================================
// Generic 2-pin fixed resistor (allow direct instantiation)
// =============================================================================
component RES(
    rs::UV.OHM,
    volt::UV.VOLT,
    power::UV.WATT,
    tol::UV.PERCENT = 5%,
    tc::UV.PPM_PER_C = 100.0ppm/℃
)
{
    name = "Resistor"
    description = "Generic two-terminal fixed resistor; use RES.SMD / RES.THT for explicit mount type"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance = rs
        voltage_rated = volt
        power_rated = power
        tolerance = tol
        temp_coeff = tc
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]

    func Pullup(net1, vcc)
    {
        net1 - this[1]
        this[2] - vcc
        return net1
    }

    func Pulldown(net1, gnd)
    {
        net1 - this[1]
        this[2] - gnd
        return net1
    }

    func Series(netA, netB)
    {
        netA - this[1]
        this[2] - netB
        return netA, netB
    }
}

// =============================================================================
// SMD Fixed Resistor (Standard Chip)
// =============================================================================
component RES.SMD(
    rs::UV.OHM,
    volt::UV.VOLT,
    power::UV.WATT,
    tol::UV.PERCENT = 5%,
    tc::UV.PPM_PER_C = 100.0ppm/℃
)
{
    name = "SMD Resistor"
    description = "Surface mount two-terminal fixed resistor"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance = rs
        voltage_rated = volt
        power_rated = power
        tolerance = tol
        temp_coeff = tc
        temp_min = _
        temp_max = _
        construction = "SMD"
        rohs = _
        derating_note = _
    ]

    func Pullup(net1, vcc)
    {
        net1 - this[1]
        this[2] - vcc
        return net1
    }

    func Pulldown(net1, gnd)
    {
        net1 - this[1]
        this[2] - gnd
        return net1
    }

    func Series(netA, netB)
    {
        netA - this[1]
        this[2] - netB
        return netA, netB
    }
}

// =============================================================================
// SMD Power Resistor
// =============================================================================
component RES.SMD_POWER(
    rs::UV.OHM,
    volt::UV.VOLT,
    power::UV.WATT,
    tol::UV.PERCENT = 5%,
    tc::UV.PPM_PER_C = 100.0ppm/℃
)
{
    name = "SMD Power Resistor"
    description = "Surface mount high-power two-terminal resistor"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance = rs
        voltage_rated = volt
        power_rated = power
        tolerance = tol
        temp_coeff = tc
        temp_min = _
        temp_max = _
        construction = "SMD_POWER"
        rohs = _
        derating_note = _
    ]

    func Series(netA, netB)
    {
        netA - this[1]
        this[2] - netB
        return netA, netB
    }
}

// =============================================================================
// THT Fixed Resistor
// =============================================================================
component RES.THT(
    rs::UV.OHM,
    volt::UV.VOLT,
    power::UV.WATT,
    tol::UV.PERCENT = 5%,
    tc::UV.PPM_PER_C = 200.0ppm/℃
)
{
    name = "Through Hole Resistor"
    description = "Axial through-hole two-terminal fixed resistor"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance = rs
        voltage_rated = volt
        power_rated = power
        tolerance = tol
        temp_coeff = tc
        temp_min = _
        temp_max = _
        construction = "THT"
        rohs = _
        derating_note = _
    ]

    func Pullup(net1, vcc)
    {
        net1 - this[1]
        this[2] - vcc
        return net1
    }

    func Pulldown(net1, gnd)
    {
        net1 - this[1]
        this[2] - gnd
        return net1
    }

    func Series(netA, netB)
    {
        netA - this[1]
        this[2] - netB
        return netA, netB
    }
}

// =============================================================================
// Potentiometer (3-terminal variable resistor)
// =============================================================================
component RES.POT(
    rs::UV.OHM,
    volt::UV.VOLT,
    power::UV.WATT,
    tol::UV.PERCENT = 20%
)
{
    name = "Potentiometer / Trim Pot"
    description = "3-terminal adjustable resistor, support divider or rheostat mode"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "End 1"
        2 = 2, "Wiper"
        3 = 3, "End 2"
    ]

    spec = [
        resistance = rs
        voltage_rated = volt
        power_rated = power
        tolerance = tol
        temp_coeff = _
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]

    func VoltageDivider(input, output, gnd)
    {
        input - this[1]
        this[2] - output
        this[3] - gnd
        return output
    }

    func Rheostat(netA, netB)
    {
        netA - this[1]
        this[2] - netB
        // Pin3 floating
        return netA, netB
    }
}

// =============================================================================
// NTC Thermistor
// =============================================================================
component RES.NTC(
    rs::UV.OHM,
    beta::INT,
    volt::UV.VOLT,
    tol::UV.PERCENT = 5%
)
{
    name = "NTC Thermistor"
    description = "Negative temperature coefficient thermistor"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance = rs
        beta_coefficient = beta
        voltage_rated = volt
        power_rated = _
        tolerance = tol
        temp_coeff = _
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]

    func Series(netA, netB)
    {
        netA - this[1]
        this[2] - netB
        return netA, netB
    }
}

// =============================================================================
// PTC / PPTC Self-resetting Fuse
// =============================================================================
component RES.PTC(
    rs::UV.OHM,
    i_trip::UV.AMP,
    volt::UV.VOLT,
    tol::UV.PERCENT = 20%
)
{
    name = "PTC / PPTC Resettable Fuse"
    description = "Positive temperature coefficient overcurrent protection device"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance = rs
        trip_current = i_trip
        voltage_rated = volt
        power_rated = _
        tolerance = tol
        temp_coeff = _
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]

    func Series(netA, netB)
    {
        netA - this[1]
        this[2] - netB
        return netA, netB
    }
}

// =============================================================================
// Resistor Array — Independent component, NO Pullup/Pulldown/Series
// =============================================================================
component RES.ARRAY(
    rs::UV.OHM,
    volt::UV.VOLT,
    power::UV.WATT,
    tol::UV.PERCENT = 5%,
    tc::UV.PPM_PER_C = 100.0ppm/℃,
    channel_count::INT = 4,
    mount::STRING = "ARRAY_SMD"
)
{
    name = "Resistor Array"
    description = "Multi-channel integrated resistor network; separate model from discrete resistor"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1
        2 = 2
        3 = 3
        4 = 4
    ]

    spec = [
        resistance = rs
        voltage_rated = volt
        power_rated = power
        tolerance = tol
        temp_coeff = tc
        temp_min = _
        temp_max = _
        channel_count = channel_count
        construction = mount
        rohs = _
        derating_note = _
    ]
    // No single-resistor functions (Pullup / Pulldown / Series)
    // Extend with dedicated channel binding functions later if needed
}

# =============================================================================
# Usage Examples
# =============================================================================
# RES(10kΩ, 50V, 0.125W, 5%, 100.0ppm/℃).Pullup(signal, vcc)
# RES.SMD(470Ω, 50V, 0.125W, 5%, 100.0ppm/℃).Pulldown(enable, gnd)
# RES.THT(1kΩ, 250V, 0.25W, 5%, 200.0ppm/℃).Series(vcc, load)
# RES.SMD_POWER(0.1Ω, 100V, 2W, 5%, 100.0ppm/℃).Series(vout, load)
# RES.POT(10kΩ, 50V, 0.1W, 20%).VoltageDivider(vcc, fb, gnd)
# RES.NTC(10kΩ, 3950, 5V, 5%).Series(ntc_node, gnd)
# RES.PTC(100mΩ, 500mA, 24V, 20%).Series(vin, load)
# RES.ARRAY(220Ω, 50V, 0.1W, 5%, 100.0ppm/℃, 4, "ARRAY_SMD")
# RES.ARRAY(220Ω, 50V, 0.1W, 5%, 100.0ppm/℃, 4, "ARRAY_THT")