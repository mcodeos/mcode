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
    irated::UV.AMP,
    tol::UV.PERCENT,
    dcr::UV.OHM
)
{
    name = "Inductor"
    description = "Generic two-terminal inductor"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance = ind
        rated_current = irated
        dcr = dcr
        tolerance = tol
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]
}

// =============================================================================
// SMD Inductor
// =============================================================================
component IND.SMD(
    ind::UV.IND,
    irated::UV.AMP,
    tol::UV.PERCENT,
    dcr::UV.OHM
)
{
    name = "SMD Inductor"
    description = "Surface mount two-terminal inductor"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance = ind
        rated_current = irated
        dcr = dcr
        tolerance = tol
        temp_min = _
        temp_max = _
        construction = "SMD"
        rohs = _
        derating_note = _
    ]
}

// =============================================================================
// THT Inductor
// =============================================================================
component IND.THT(
    ind::UV.IND,
    irated::UV.AMP,
    tol::UV.PERCENT,
    dcr::UV.OHM
)
{
    name = "Through Hole Inductor"
    description = "Through-hole two-terminal inductor"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance = ind
        rated_current = irated
        dcr = dcr
        tolerance = tol
        temp_min = _
        temp_max = _
        construction = "THT"
        rohs = _
        derating_note = _
    ]
}

// =============================================================================
// Power Inductor (DC-DC, add saturation current)
// =============================================================================
component IND.POWER(
    ind::UV.IND,
    irated::UV.AMP,
    isat::UV.AMP,
    tol::UV.PERCENT,
    dcr::UV.OHM
)
{
    name = "Power Inductor"
    description = "Power inductor for DC-DC converters, with saturation current"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance = ind
        rated_current = irated
        sat_current = isat
        dcr = dcr
        tolerance = tol
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]
}

// =============================================================================
// HF Inductor (RF, add self-resonant frequency)
// =============================================================================
component IND.HF(
    ind::UV.IND,
    irated::UV.AMP,
    srf::UV.HZ,
    tol::UV.PERCENT,
    dcr::UV.OHM
)
{
    name = "HF Inductor"
    description = "High-frequency / RF inductor with SRF"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance = ind
        rated_current = irated
        srf = srf
        dcr = dcr
        tolerance = tol
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]
}

// =============================================================================
// Ferrite Bead (not inductor: impedance, no inductance param)
// =============================================================================
component IND.FB(
    impd::UV.OHM,
    irated::UV.AMP,
    ftest::UV.HZ
)
{
    name = "Ferrite Bead"
    description = "Ferrite bead for high-frequency noise suppression"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        impedance = impd
        rated_current = irated
        test_frequency = ftest
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]
}

// =============================================================================
// Common Mode Choke (4-pin, topology different → independent component)
// =============================================================================
component IND.CMC(
    ind::UV.IND,
    irated::UV.AMP,
    impd::UV.OHM,
    tol::UV.PERCENT,
    ftest::UV.HZ
)
{
    name = "Common Mode Choke"
    description = "4-terminal common mode choke"

    pins = [
        1 = 1, "W1_IN"
        2 = 2, "W1_OUT"
        3 = 3, "W2_IN"
        4 = 4, "W2_OUT"
    ]

    spec = [
        inductance = ind
        rated_current = irated
        impedance = impd
        tolerance = tol
        test_frequency = ftest
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
# IND(100μH, 1A, ±10%, 0.1Ω): nodeA -> IND(100μH, 1A, ±10%, 0.1Ω) -> nodeB        // 二脚件默认 1×2 形状放置
# IND.SMD(47μH, 2A, ±10%, 0.08Ω): sw_node -> IND.SMD(47μH, 2A, ±10%, 0.08Ω) -> ldo_in
# IND.POWER(47μH, 3A, 4A, ±20%, 0.05Ω): sw -> IND.POWER(47μH, 3A, 4A, ±20%, 0.05Ω) -> out
# IND.HF(10μH, 0.5A, 50MHz, ±5%, 0.2Ω): rf_in -> IND.HF(10μH, 0.5A, 50MHz, ±5%, 0.2Ω) -> filter_out
# IND.FB(100Ω, 1A, 100MHz): io_line -> IND.FB(100Ω, 1A, 100MHz) -> soc_pin
# IND.CMC(100μH, 2A, 100Ω, ±20%, 100MHz).CommonModeSuppress(line_in, line_out, ret_in, ret_out)