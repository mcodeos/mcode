# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Scoped enum: values are directly accessible (bare) inside component CAP /
// CAP.*. Outside, use CAP.X7R, CAP.MLCC, etc.
// Note: the enum mixes three logical groups — 1) Dielectric 2) Construction
// 3) SafetyClass — do NOT cross-group assign.

enum CAP
{
    // ── Dielectric (MLCC temperature characteristic codes) ──
    C0G,        // NPO is a legacy alias of the same dielectric class
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

// CAP_DECOUPLE - Shared Decouple Recipe for the CAP Family
// One decouple method serves every CAP class. The formal names the entry
// pair's roles ([hot, ret]); the flat single-statement body keeps the decouple
// entry one drawing unit and lands polarized `\+` (pin 1) on the first-named
// node automatically. The column-vector return is load-bearing: it reads as
// the bridge (one cap across the entry pair); an implicit `return this` row
// face would read per-lane.
recipe CAP_DECOUPLE
{
    func Cap([hot, ret])
    {
        hot - this - ret
        return [hot, ret]
    }
}

// CAP - Generic Capacitor Component Definition
// Core Rule: stores charge Q = C·V between the terminals; the dielectric and
// construction selections fix the electrical family (the enum groups must not
// be cross-assigned).

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

// CAP.ELEC - Electrolytic Capacitor (Polarized) Component Definition
// Core Rule: polarized aluminum-oxide capacitor — anode must sit at or above
// cathode potential; wet vs polymer construction stays open at BOM stage.

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

// CAP.MLCC - Multilayer Ceramic Capacitor (Non-Polarized) Component Definition
// Core Rule: non-polarized ceramic capacitor; the dielectric class (X7R, X5R,
// C0G, ...) fixes the temperature characteristic and drift behavior.

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

// CAP.DISC - Disc Ceramic Capacitor (Non-MLCC) Component Definition
// Core Rule: non-polarized single-layer disk ceramic; common high-voltage,
// low-cost service (defaults to C0G).

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

// CAP.TANT - Tantalum Capacitor (Polarized) Component Definition
// Core Rule: polarized tantalum-pentoxide capacitor — anode must sit at or
// above cathode potential; wet vs polymer construction stays open at BOM
// stage.

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

// CAP.NIOB - Niobium Capacitor (Polarized) Component Definition
// Core Rule: polarized niobium-pentoxide capacitor — anode must sit at or
// above cathode potential.

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

// CAP.FILM - Film Capacitor (Non-Polarized) Component Definition
// Core Rule: non-polarized plastic-film capacitor; the film dielectric
// (PP/PET/PC/PS/PEN) sets tolerance, stability, and self-healing behavior.

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

// CAP.MICA - Mica Capacitor (Non-Polarized) Component Definition
// Core Rule: mica dielectric gives high stability and low loss at high
// frequency and precision service.

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

// CAP.SAFETY - X/Y Safety Capacitor (EMI Filter, Non-Polarized) Component Definition
// Core Rule: certified for fail-safe EMI service across the mains; the volt
// formal is the AC RMS rating, not a DC voltage.

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

// CAP.SC - Supercapacitor / EDLC (Polarized) Component Definition
// Core Rule: electric-double-layer storage — farad-scale capacitance at low
// voltage, polarized; EDLC doubles as dielectric and construction by
// convention, not as a classical dielectric.

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

// CAP.TRIM - Trimmer / Variable Capacitor (Non-Polarized) Component Definition
// Core Rule: mechanically adjustable capacitance; the cap formal is the
// nominal (maximum) value.

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

// Usage Examples:
// The family decouple method is back as the CAP_DECOUPLE recipe (one body,
// adopted by all 11 classes). Two spellings, same netlist:
//   lane form   — io33 => CAP(100nF, 50V, ±10%, X7R).Cap(_) -> [vcc, gnd]
//                 (entry pair feeds the `_` slot; one cap across the pair,
//                 tail zip-ties the pair to the rails — one drawing unit)
//   infix chain — plain series, the lane form's byte-identical expansion.
// Scalar spellings are honest errors now: Cap(vdd) = E4180 (width), bare _
// without a `=>` prefix = E4176. Polarized parts land `\+` (pin 1) on the
// first-named node in both spellings.
// vcc - CAP.MLCC(100nF, 50V, ±10%, X7R) - gnd
// line - CAP.DISC(1000pF, 1kV, ±10%, C0G) - gnd
// vcc - CAP.ELEC(100μF, 16V, ±10%) - gnd
// vdd - CAP.TANT(10μF, 10V, ±10%) - gnd
// io - CAP.NIOB(4.7μF, 6.3V, ±20%) - gnd
// audio_in - CAP.FILM(1μF, 63V, ±5%, POLYESTER) - audio_gnd
// rf_node - CAP.MICA(100pF, 500V, ±5%) - gnd
// line - CAP.SAFETY(22nF, 275VAC, ±10%, POLYPROPYLENE, SC_X2) - pe
// backup - CAP.SC(1F, 2.7V, ±20%) - gnd
// tank - CAP.TRIM(30pF, 50V, ±10%) - gnd
