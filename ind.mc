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
// Inductor Component Definitions
// Aligned with RES / CAP design convention
// Two-terminal parts share Series(); topology-different parts have dedicated functions
// construction uses string tag, no enum
// Part metadata: partno / package / manufacturer moved out of spec (top-level)
// spec only contains electrical parameters
// Naming: rated_current = thermal rating; sat_current = saturation current (power inductor only)
// ---------------------------------------------------------------------------------------------

// =============================================================================
// Generic two-terminal inductor (unbound package)
// =============================================================================
component IND(
    ind::UV.IND,
    rated_current::UV.AMP,
    tol::UV.PERCENT = ±10%,
    dcr::UV.OHM
)
{
    name = "Inductor"
    description = "Generic two-terminal inductor"

    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance = ind
        rated_current = rated_current
        dcr = dcr
        tolerance = tol
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]

    func Series(netA, netB)
    {
        netA - this{1}
        this{2} - netB
        return netA, netB
    }
}

// =============================================================================
// SMD Inductor
// =============================================================================
component IND.SMD(
    ind::UV.IND,
    rated_current::UV.AMP,
    tol::UV.PERCENT = ±10%,
    dcr::UV.OHM
)
{
    name = "SMD Inductor"
    description = "Surface mount two-terminal inductor"

    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance = ind
        rated_current = rated_current
        dcr = dcr
        tolerance = tol
        temp_min = _
        temp_max = _
        construction = "SMD"
        rohs = _
        derating_note = _
    ]

    func Series(netA, netB)
    {
        netA - this{1}
        this{2} - netB
        return netA, netB
    }
}

// =============================================================================
// THT Inductor
// =============================================================================
component IND.THT(
    ind::UV.IND,
    rated_current::UV.AMP,
    tol::UV.PERCENT = ±10%,
    dcr::UV.OHM
)
{
    name = "Through Hole Inductor"
    description = "Through-hole two-terminal inductor"

    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance = ind
        rated_current = rated_current
        dcr = dcr
        tolerance = tol
        temp_min = _
        temp_max = _
        construction = "THT"
        rohs = _
        derating_note = _
    ]

    func Series(netA, netB)
    {
        netA - this{1}
        this{2} - netB
        return netA, netB
    }
}

// =============================================================================
// Power Inductor (DC-DC, add saturation current)
// =============================================================================
component IND.POWER(
    ind::UV.IND,
    rated_current::UV.AMP,
    sat_current::UV.AMP,
    tol::UV.PERCENT = ±20%,
    dcr::UV.OHM
)
{
    name = "Power Inductor"
    description = "Power inductor for DC-DC converters, with saturation current"

    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance = ind
        rated_current = rated_current
        sat_current = sat_current
        dcr = dcr
        tolerance = tol
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]

    func Series(netA, netB)
    {
        netA - this{1}
        this{2} - netB
        return netA, netB
    }
}

// =============================================================================
// HF Inductor (RF, add self-resonant frequency)
// =============================================================================
component IND.HF(
    ind::UV.IND,
    rated_current::UV.AMP,
    srf::UV.HZ,
    tol::UV.PERCENT = ±5%,
    dcr::UV.OHM
)
{
    name = "HF Inductor"
    description = "High-frequency / RF inductor with SRF"

    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance = ind
        rated_current = rated_current
        srf = srf
        dcr = dcr
        tolerance = tol
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]

    func Series(netA, netB)
    {
        netA - this{1}
        this{2} - netB
        return netA, netB
    }
}

// =============================================================================
// Ferrite Bead (not inductor: impedance, no inductance param)
// =============================================================================
component IND.FB(
    impedance::UV.OHM,
    rated_current::UV.AMP,
    test_frequency::UV.HZ
)
{
    name = "Ferrite Bead"
    description = "Ferrite bead for high-frequency noise suppression"

    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        impedance = impedance
        rated_current = rated_current
        test_frequency = test_frequency
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]

    func Series(netA, netB)
    {
        netA - this{1}
        this{2} - netB
        return netA, netB
    }
}

// =============================================================================
// Common Mode Choke (4-pin, topology different → independent component)
// =============================================================================
component IND.CMC(
    ind::UV.IND,
    rated_current::UV.AMP,
    impedance::UV.OHM,
    tol::UV.PERCENT = ±20%,
    test_frequency::UV.HZ
)
{
    name = "Common Mode Choke"
    description = "4-terminal common mode choke"

    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "W1_IN"
        2 = 2, "W1_OUT"
        3 = 3, "W2_IN"
        4 = 4, "W2_OUT"
    ]

    spec = [
        inductance = ind
        rated_current = rated_current
        impedance = impedance
        tolerance = tol
        test_frequency = test_frequency
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]

    func CommonModeSuppress(w1_in, w1_out, w2_in, w2_out)
    {
        w1_in - this{1}
        this{2} - w1_out
        w2_in - this{3}
        this{4} - w2_out
        return w1_out, w2_out
    }
}

# =============================================================================
# Usage Examples
# =============================================================================
# IND(100μH, 1A, 0.1Ω).Series(nodeA, nodeB)
# IND.SMD(47μH, 2A, 0.08Ω).Series(sw_node, ldo_in)
# IND.POWER(47μH, 3A, 4A, 0.05Ω).Series(sw, out)
# IND.HF(10μH, 0.5A, 50MHz, 0.2Ω).Series(rf_in, filter_out)
# IND.FB(100Ω, 1A, 100MHz).Series(io_line, soc_pin)
# IND.CMC(100μH, 2A, 100Ω, 100MHz).CommonModeSuppress(line_in, line_out, ret_in, ret_out)