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
// Capacitor Component Definitions — Full Production Library
// ---------------------------------------------------------------------------------------------
// Scoped enum: values are directly accessible (bare) inside component CAP / CAP.*
// Outside, use CAP.X7R, CAP.MLCC, etc.
// NOTE: This enum mixes three logical groups; do NOT cross-group assign:
// 1) Dielectric | 2) Construction | 3) SafetyClass
// Future major version: split into CAP_DIELECTRIC / CAP_CONSTRUCTION / CAP_SAFETY_CLASS

enum CAP
{
    // ── Dielectric (MLCC temperature characteristic codes) ──
    C0G,        // NPO legacy name removed; document alias only
    X7R,
    X7S,
    X7U,
    X5R,
    Y5V,
    X8R,        // automotive high-temp MLCC
    U2J,        // ADD: high-voltage MLCC, low drift, power supply common

    // ── Dielectric (oxide / film / special) ──
    ALUMINUM_OXIDE,
    TANTALUM_PENTOXIDE,
    NIOBIUM_PENTOXIDE,
    POLYESTER,          // PET
    POLYPROPYLENE,      // PP
    POLYCARBONATE,      // PC
    POLYSTYRENE,        // PS
    PEN,                // Polyethylene Naphthalate
    MICA,
    EDLC,               // Electric Double Layer (Supercap, special: acts as type, not classical dielectric)

    // ── Construction / cathode type ──
    WET_ALUMINUM,
    POLYMER_ALUMINUM,
    WET_TANTALUM,
    POLYMER_TANTALUM,
    NIOBIUM,
    MLCC,
    DISC_CERAMIC,       // ADD: disk ceramic (non-MLCC)
    FILM,

    // ── Safety class (EMI X/Y) ──
    SC_NONE,
    SC_X1,
    SC_X2,
    SC_Y1,
    SC_Y2,
}

// =============================================================================
// Generic Capacitor (ABSTRACT BASE — DO NOT INSTANTIATE DIRECTLY)
// Lint rule: use CAP.CER / CAP.ELEC etc preferred.
// =============================================================================
component CAP(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT = ±10%, 
    diel = CAP.X7R,
    cons = CAP.MLCC
)
{
    name = "Capacitor"
    description = "General Capacitor"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1
        2 = 2
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = diel
        construction = cons
        polarized = false       // ADD: unified polarity flag for DRC/BOM
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _                // ADD: RoHS / RoHS-exempt
        derating_note = _       // ADD: derating guidance note
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }
}

// =============================================================================
// Electrolytic Capacitor (Polarized)
// =============================================================================
component CAP.ELEC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT = ±10%,
    cons = CAP.WET_ALUMINUM
)
{
    name = "Electrolytic Capacitor"
    description = "Polarized aluminum electrolytic / polymer aluminum capacitor"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = \+ , "Anode"
        2 = \- , "Cathode"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = ALUMINUM_OXIDE
        construction = cons
        polarized = true        // ADD
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }
}

// =============================================================================
// MLCC Ceramic Capacitor (non-polarized)
// =============================================================================
component CAP.MLCC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT = ±10%,
    diel = CAP.X7R
)
{
    name = "MLCC Capacitor"
    description = "Multilayer Ceramic Capacitor (MLCC), non-polarized"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = diel
        construction = MLCC
        polarized = false       // ADD
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }
}

// =============================================================================
// ADD: Disc Ceramic Capacitor (non-MLCC disk ceramic)
// =============================================================================
component CAP.DISC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT = ±10%,
    diel = CAP.C0G
)
{
    name = "Disc Ceramic Capacitor"
    description = "Non-MLCC disk ceramic capacitor; common high-voltage low-cost"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = diel
        construction = DISC_CERAMIC
        polarized = false
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }
}

// =============================================================================
// Tantalum Capacitor (Polarized)
// =============================================================================
component CAP.TANT(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT = ±10%,
    cons = CAP.WET_TANTALUM
)
{
    name = "Tantalum Capacitor"
    description = "Polarized tantalum / polymer tantalum capacitor"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = \+ , "Anode"
        2 = \- , "Cathode"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = TANTALUM_PENTOXIDE
        construction = cons
        polarized = true        // ADD
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }
}

// =============================================================================
// Niobium Capacitor (Polarized)
// =============================================================================
component CAP.NIOB(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT = ±10%
)
{
    name = "Niobium Capacitor"
    description = "Polarized niobium pentoxide capacitor"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = \+ , "Anode"
        2 = \- , "Cathode"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = NIOBIUM_PENTOXIDE
        construction = NIOBIUM
        polarized = true        // ADD
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }
}

// =============================================================================
// Film Capacitor (non-polarized, general purpose)
// =============================================================================
component CAP.FILM(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT = ±5%,
    diel = CAP.POLYPROPYLENE
)
{
    name = "Film Capacitor"
    description = "Non-polarized film capacitor (PP/PET/PC/PS/PEN)"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = diel
        construction = FILM
        polarized = false       // ADD
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }
}

// =============================================================================
// Mica Capacitor (non-polarized, high freq / precision)
// =============================================================================
component CAP.MICA(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT = ±5%
)
{
    name = "Mica Capacitor"
    description = "Mica dielectric capacitor, high stability / high frequency"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = MICA
        construction = MICA
        polarized = false       // ADD
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }
}

// =============================================================================
// X/Y Safety Capacitor (EMI filter, non-polarized)
// IMPORTANT: volt argument = AC RMS rating, not DC voltage
// =============================================================================
component CAP.SAFETY(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT = ±10%,
    diel = CAP.POLYPROPYLENE,
    cls = CAP.SC_X2
)
{
    name = "Safety Capacitor X/Y"
    description = "EMI safety capacitor (X1/X2 / Y1/Y2); volt = AC RMS rating"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = diel
        construction = FILM
        polarized = false
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = cls
        certification = _       // ADD: UL / ENEC etc.
        rohs = _
        derating_note = _
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }
}

// =============================================================================
// Supercap / EDLC (polarized, low voltage, high capacity)
// Note: EDLC is treated as dielectric+construction by convention, not classical dielectric
// =============================================================================
component CAP.SC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT = ±10%
)
{
    name = "Supercapacitor / EDLC"
    description = "Electric Double Layer Capacitor, polarized"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = \+ , "Anode"
        2 = \- , "Cathode"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = EDLC
        construction = EDLC
        polarized = true        // ADD
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }
}

// =============================================================================
// Trim / Variable Capacitor (non-polarized, adjustable)
// =============================================================================
component CAP.TRIM(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT = ±10%
)
{
    name = "Trimmer Capacitor"
    description = "Adjustable trimmer / variable capacitor; cap = nominal/max capacitance"
    partno = _
    package = _
    manufacturer = _

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = _
        construction = _
        polarized = false       // ADD
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }
}

# =============================================================================
# Usage Examples
# =============================================================================
# CAP.MLCC(100nF, 50V, ±10%, X7R).Cap(vcc, gnd)
# CAP.DISC(1000pF, 1kV, ±10%, C0G).Cap(line, gnd)
# CAP.ELEC(100μF, 16V, ±10%, POLYMER_ALUMINUM).Cap(vcc, gnd)
# CAP.TANT(10μF, 10V, ±10%, POLYMER_TANTALUM).Cap(vdd, gnd)
# CAP.NIOB(4.7μF, 6.3V).Cap(io, gnd)
# CAP.FILM(1μF, 63V, ±5%, POLYESTER).Cap(audio_in, audio_gnd)
# CAP.MICA(100pF, 500V).Cap(rf_node, gnd)
# CAP.SAFETY(22nF, 275VAC, ±10%, POLYPROPYLENE, SC_X2).Cap(line, pe)
# CAP.SC(1F, 2.7V).Cap(backup, gnd)
# CAP.TRIM(30pF, 50V).Cap(tank, gnd)