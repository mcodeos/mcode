# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

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
    U2J,        // high-voltage MLCC, low drift, power supply common

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
    DISC_CERAMIC,       // disk ceramic (non-MLCC)
    FILM,

    // ── Safety class (EMI X/Y) ──
    SC_NONE,
    SC_X1,
    SC_X2,
    SC_Y1,
    SC_Y2,
}

// =============================================================================
// CAP_DECOUPLE recipe (U317 reversal, 2026-10-03): the decouple method lives
// here, one definition for the whole CAP family — the pre-U317 11 per-class
// copies are not coming back. Set formal names the entry pair's roles
// ([hot, ret]; domain rail-pair law); the flat single-statement body keeps the
// decouple entry one drawing unit (B10) and lands polarized `\+` (pin 1) on
// the first-named node automatically. The column-vector return is load-bearing:
// return-shape law (vec-dianlu.md §7.7) reads it as the bridge (one cap across
// the entry pair); an implicit `return this` row face would read per-lane.
// Lane form: io33 => CAP(100nF, ...).Cap(_) -> [VDD, GND]
// =============================================================================
recipe CAP_DECOUPLE
{
    func Cap([hot, ret])
    {
        hot - this - ret
        return [hot, ret]
    }
}

// =============================================================================
// Generic Capacitor (BASE)
// Lint rule: use CAP.MLCC / CAP.ELEC etc preferred.
// =============================================================================
component CAP(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT,

    diel = CAP.X7R,
    cons = CAP.MLCC
) :: CAP_DECOUPLE
{
    name = "Capacitor"
    description = "General Capacitor"

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
        polarized = false       // unified polarity flag for DRC/BOM
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _                // RoHS / RoHS-exempt
        derating_note = _       // derating guidance note
    ]

}

// =============================================================================
// Electrolytic Capacitor (Polarized)
// =============================================================================
component CAP.ELEC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: CAP_DECOUPLE
{
    name = "Electrolytic Capacitor"
    description = "Polarized aluminum electrolytic / polymer aluminum capacitor"

    pins = [
        1 = \+ | ANODE, "Anode"
        2 = \- | CATHODE, "Cathode"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = ALUMINUM_OXIDE
        construction = _        // wet vs polymer: BOM-stage decision
        polarized = true
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

}

// =============================================================================
// MLCC Ceramic Capacitor (non-polarized)
// =============================================================================
component CAP.MLCC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT,
    diel = CAP.X7R
) :: CAP_DECOUPLE
{
    name = "MLCC Capacitor"
    description = "Multilayer Ceramic Capacitor (MLCC), non-polarized"

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

}

// =============================================================================
// Disc ceramic capacitor (non-MLCC disk ceramic)
// =============================================================================
component CAP.DISC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT,
    diel = CAP.C0G
) :: CAP_DECOUPLE
{
    name = "Disc Ceramic Capacitor"
    description = "Non-MLCC disk ceramic capacitor; common high-voltage low-cost"

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

}

// =============================================================================
// Tantalum Capacitor (Polarized)
// =============================================================================
component CAP.TANT(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: CAP_DECOUPLE
{
    name = "Tantalum Capacitor"
    description = "Polarized tantalum / polymer tantalum capacitor"

    pins = [
        1 = \+ , "Anode"
        2 = \- , "Cathode"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = tol
        dielectric = TANTALUM_PENTOXIDE
        construction = _        // wet vs polymer: BOM-stage decision
        polarized = true
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

}

// =============================================================================
// Niobium Capacitor (Polarized)
// =============================================================================
component CAP.NIOB(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: CAP_DECOUPLE
{
    name = "Niobium Capacitor"
    description = "Polarized niobium pentoxide capacitor"

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
        polarized = true
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

}

// =============================================================================
// Film Capacitor (non-polarized, general purpose)
// =============================================================================
component CAP.FILM(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT,
    diel = CAP.POLYPROPYLENE
) :: CAP_DECOUPLE
{
    name = "Film Capacitor"
    description = "Non-polarized film capacitor (PP/PET/PC/PS/PEN)"

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
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

}

// =============================================================================
// Mica Capacitor (non-polarized, high freq / precision)
// =============================================================================
component CAP.MICA(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: CAP_DECOUPLE
{
    name = "Mica Capacitor"
    description = "Mica dielectric capacitor, high stability / high frequency"

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

}

// =============================================================================
// X/Y Safety Capacitor (EMI filter, non-polarized)
// IMPORTANT: volt argument = AC RMS rating, not DC voltage
// =============================================================================
component CAP.SAFETY(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT,
    diel = CAP.POLYPROPYLENE,
    cls = CAP.SC_X2
) :: CAP_DECOUPLE
{
    name = "Safety Capacitor X/Y"
    description = "EMI safety capacitor (X1/X2 / Y1/Y2); volt = AC RMS rating"

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
        certification = _       // UL / ENEC etc.
        rohs = _
        derating_note = _
    ]

}

// =============================================================================
// Supercap / EDLC (polarized, low voltage, high capacity)
// Note: EDLC is treated as dielectric+construction by convention, not classical dielectric
// =============================================================================
component CAP.SC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: CAP_DECOUPLE
{
    name = "Supercapacitor / EDLC"
    description = "Electric Double Layer Capacitor, polarized"

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
        polarized = true
        esr = _
        ripple_rated = _
        temp_min = _
        temp_max = _
        life_hours = _
        safety_class = SC_NONE
        rohs = _
        derating_note = _
    ]

}

// =============================================================================
// Trim / Variable Capacitor (non-polarized, adjustable)
// =============================================================================
component CAP.TRIM(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: CAP_DECOUPLE
{
    name = "Trimmer Capacitor"
    description = "Adjustable trimmer / variable capacitor; cap = nominal/max capacitance"

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

}

# =============================================================================
# Usage Examples (U317 reversal, 2026-10-03)
# The family decouple method is back as the CAP_DECOUPLE recipe (one body,
# adopted by all 11 classes). Two spellings, same netlist:
#   lane form   — io33 => CAP(100nF, 50V, ±10%, X7R).Cap(_) -> [vcc, gnd]
#                 (entry pair feeds the `_` slot; one cap across the pair,
#                 tail zip-ties the pair to the rails — one drawing unit)
#   infix chain — plain series, the lane form's byte-identical expansion.
# Scalar spellings are honest errors now: Cap(vdd) = E4180 (width), bare _
# without a `=>` prefix = E4176. Polarized parts land `\+` (pin 1) on the
# first-named node in both spellings.
# =============================================================================
# vcc - CAP.MLCC(100nF, 50V, ±10%, X7R) - gnd
# line - CAP.DISC(1000pF, 1kV, ±10%, C0G) - gnd
# vcc - CAP.ELEC(100μF, 16V, ±10%) - gnd
# vdd - CAP.TANT(10μF, 10V, ±10%) - gnd
# io - CAP.NIOB(4.7μF, 6.3V, ±20%) - gnd
# audio_in - CAP.FILM(1μF, 63V, ±5%, POLYESTER) - audio_gnd
# rf_node - CAP.MICA(100pF, 500V, ±5%) - gnd
# line - CAP.SAFETY(22nF, 275VAC, ±10%, POLYPROPYLENE, SC_X2) - pe
# backup - CAP.SC(1F, 2.7V, ±20%) - gnd
# tank - CAP.TRIM(30pF, 50V, ±10%) - gnd