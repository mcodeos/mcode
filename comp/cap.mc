# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

use ../ifs/term

// Scoped enum: values are directly accessible (bare) inside component CAP /
// CAP.*. Outside, use CAP.X7R, CAP.MLCC, etc.
// Note: the enum mixes three logical groups — Dielectric, Construction and
// SafetyClass — do NOT cross-group assign.  The grouping is machine data in
// comp/cap.groups.json, held against this enum by scripts/check-enum-groups.py.

enum CAP {
    // ── Dielectric (MLCC temperature characteristic codes) ──
    C0G,            // NP0 ("NPO" legacy spelling) is the same class; JIS twin CH
    X7R,
    X7S,
    X7U,
    X5R,
    Y5V,
    X8R,            // automotive high-temp MLCC (-55...+150 C)
    X5F,            // disc ceramic class 2 (-25...+85 C)
    U2J,            // high-voltage MLCC, low drift; JIS twin 7U

    // ── Dielectric (oxide / film / special) ──
    ALUMINUM_OXIDE,
    TANTALUM_PENTOXIDE,
    NIOBIUM_PENTOXIDE,
    POLYESTER,      // PET
    POLYPROPYLENE,  // PP
    POLYCARBONATE,  // PC; legacy/EOL (industry sells replacement series)
    POLYSTYRENE,    // PS; legacy/EOL (no active production)
    PEN,            // Polyethylene Naphthalate
    MICA,
    EDLC,           // Electric Double Layer (Supercap, special: acts as type, not classical dielectric)

    // ── Construction / cathode type ──
    WET_ALUMINUM,
    POLYMER_ALUMINUM,
    WET_TANTALUM,
    POLYMER_TANTALUM,
    NIOBIUM,
    MLCC,
    DISC_CERAMIC,   // disk ceramic (non-MLCC)
    FILM,

    // ── Safety class (EMI X/Y) ──
    SC_NONE,
    SC_X1,
    SC_X2,
    SC_Y1,
    SC_Y2
}

// CAP - the CAP family container recipe for the symmetric (non-polarized)
// capacitor classes (capability-interface-model middle container). Three
// loadings (340 s0.2): the io entry face, the answer sheet (require/option
// shape only - the recipe never carries values; ideal values live in the
// component bodies below via ctor/spec defaults, actual values are filled by
// engineering parts from their datasheets), and the wiring funcs. Adoption:
// `:: ANCH.CAP`.
// The flat single-statement body keeps the decouple entry one drawing unit.
// The column-vector return is load-bearing: it reads as the bridge (one cap
// across the entry pair); an implicit `return this` row face would read
// per-lane.
// Note: the polarized classes (ELEC/TANT/NIOB/SC) do NOT adopt this recipe -
// polarity never rides implicit pad numbering. They adopt ANCH.CAP.POL below,
// whose entry pair names the terminals explicitly through the PCAP face.

use ../ifs/term
use ../ifs/pcap

recipe ANCH.CAP {
    // Two-terminal entry pair, positional: the face carries no member
    // vocabulary, position is the only contract (pad 1 = the first
    // terminal). Components bind the pads to the passive two-terminal
    // iface TERM ([1,2]::TERM()).
    io [1, 2]

    require = [
        electrical = [
            capacitance = Capacitance, alias: [Cap], desc: "rated capacitance (sheet heads: Capacitance / Rated Capacitance / Cap.(µF); the letter symbol C has no column witness in the sampled corpus)"
            voltage     = Voltage, alias: [VR, RV], desc: "rated voltage (DC; AVX spells Rated Voltage (VR), TDK uses RV in the withstand clauses; category / surge / AC faces have their own option columns)"
            tolerance   = Ratio, desc: "capacitance tolerance class (sheet heads: Capacitance Tolerance / Tolerance - same face as the canonical key, letter codes K/M are values not symbols)"
            polarized   = Flag, desc: "polarity fact for DRC/BOM (the polarized classes adopt CAP.POL, whose entry names the terminals; this flag stays the BOM/assembly face)"
        ]
    ]

    option = [
        build = [
            dielectric   = Words, desc: "dielectric class (MLCC temperature codes, oxide/film/special; EDLC doubles as construction by convention; the sheet head X7R Dielectric folds to the canonical key, no alias)"
            construction = Words, desc: "construction class (MLCC, DISC_CERAMIC, FILM, WET_ALUMINUM, POLYMER_ALUMINUM, ...)"
            temp_coeff   = Words, alias: [TCC], desc: "temperature coefficient code (class 1: C0G 0±30 ppm/°C, mica letter codes F/E/C; class 2 codes ride the dielectric word; KEMET spells the symbol TCC inside the capacitance-change phrase, TDK uses T. C.)"
        ]
        engineering = [
            esr              = Resistance, alias: [ESR], desc: "equivalent series resistance (ohms; measurement condition goes on a fill row, e.g. @100 kHz; alu-electro sheets carry impedance Z and its temperature ratios instead - a candidate column, filed not minted)"
            tan_delta        = Ratio, alias: [DF, Q], desc: "dissipation factor (DF on class-2 sheets; class-1 sheets spell Q - the reciprocal face, Q = 1/tanδ; the Greek tanδ spelling is not a lexable symbol and stays a desc note; condition = fill row, e.g. @1 kHz)"
            leakage          = Current, alias: [DCL, IL], desc: "leakage current at rated voltage (DCL on tantalum/niobium sheets; IL in the AVX qualification tables; EDLC leakage)"
            insulation_res   = Resistance, alias: [IR], desc: "insulation resistance (the per-capacitance MΩ·µF form reads as a time constant)"
            ripple_rated     = Current, desc: "rated ripple current (at stated frequency/temperature; sampled alu-electro sheets always spell it out - Rated Ripple / Ripple Current - no symbol face to register; EDLC reads continuous/peak current)"
            temp_min         = Temperature, desc: "operating temperature low bound (TDK splits the range into Min./Max. operating Temperature columns matching this pair; single-range sheets carry one Operating Temperature Range column - the range-face gap, filed in 305)"
            temp_max         = Temperature, desc: "operating temperature high bound (see temp_min)"
            life_hours       = Time, alias: [Endurance], desc: "rated life (endurance) at rated conditions (Endurance on nichicon/KEMET/AVX sheets)"
            shelf_life       = Time, desc: "shelf life at upper category temperature (aluminum electrolytics; KEMET spells Storage Life on the qualification table)"
            cycle_life       = Ratio, desc: "rated charge/discharge cycles (EDLC)"
            voltage_category = Voltage, alias: [VC], desc: "category voltage at upper category temperature (polar electrolytics: e.g. 2/3 of rated at 125 °C; AVX spells Category Voltage (VC))"
            voltage_surge    = Voltage, alias: [VS], desc: "surge voltage, non-repetitive (typically 1.15× rated; AVX spells Surge Voltage (VS))"
            voltage_ac       = Voltage, desc: "AC voltage class rating (safety X/Y caps, film AC face; sampled sheets witness only the Vrms unit in measurement conditions, no column symbol - no alias)"
            safety_class     = Words, desc: "EMI safety class (X1/X2/Y1/Y2)"
            certification    = Words, desc: "safety agency certification (UL / ENEC etc.)"
            rohs             = Flag, desc: "RoHS conformity"
            derating_note    = Words, desc: "derating guidance note"
        ]
    ]

    func Cap([hot, ret]) {
        hot - this - ret
        return [hot, ret]
    }
}

// ANCH.CAP.POL - the polarized CAP container recipe (capability-interface-model
// middle container for the explicitly polarized capacitor classes). The entry
// pair names its terminals through the PCAP face: \+ is the anode / positive
// terminal, \- is the cathode / negative terminal - polarity is a model-layer
// word, never an implicit pad number. The polarity ERC (B9) reads the sign
// words right off the adopting pads (the components bind
// [\+, \-]::PCAP(), so the pads carry the bare signs). The answer
// sheet restates the CAP columns (grammar admits no recipe-level adoption);
// the wiring func keeps the name/arity Cap([_, _]) so consumer call sites
// survive unchanged - its first lane is the \+ terminal.

recipe ANCH.CAP.POL {
    // Two-terminal entry pair on the polarized-passive face: the group
    // form carries the sign words at the recipe's entry (the schematic pad
    // names stay the bare members - the adopters bind [\+, \-]::PCAP()).
    io PCAP{\+, \-}

    require = [
        electrical = [
            capacitance = Capacitance, alias: [Cap], desc: "rated capacitance (sheet heads: Capacitance / Rated Capacitance / Cap.(µF); the letter symbol C has no column witness in the sampled corpus)"
            voltage     = Voltage, alias: [VR, RV], desc: "rated voltage (DC; AVX spells Rated Voltage (VR), TDK uses RV in the withstand clauses; category / surge / AC faces have their own option columns)"
            tolerance   = Ratio, desc: "capacitance tolerance class (sheet heads: Capacitance Tolerance / Tolerance - same face as the canonical key, letter codes K/M are values not symbols)"
            polarized   = Flag, desc: "polarity fact for DRC/BOM (true for every class on this recipe; the sign words live on the entry pair, not the flag)"
        ]
    ]

    option = [
        build = [
            dielectric   = Words, desc: "dielectric class (MLCC temperature codes, oxide/film/special; EDLC doubles as construction by convention; the sheet head X7R Dielectric folds to the canonical key, no alias)"
            construction = Words, desc: "construction class (MLCC, DISC_CERAMIC, FILM, WET_ALUMINUM, POLYMER_ALUMINUM, ...)"
            temp_coeff   = Words, alias: [TCC], desc: "temperature coefficient code (class 1: C0G 0±30 ppm/°C, mica letter codes F/E/C; class 2 codes ride the dielectric word; KEMET spells the symbol TCC inside the capacitance-change phrase, TDK uses T. C.)"
        ]
        engineering = [
            esr              = Resistance, alias: [ESR], desc: "equivalent series resistance (ohms; measurement condition goes on a fill row, e.g. @100 kHz; alu-electro sheets carry impedance Z and its temperature ratios instead - a candidate column, filed not minted)"
            tan_delta        = Ratio, alias: [DF, Q], desc: "dissipation factor (DF on class-2 sheets; class-1 sheets spell Q - the reciprocal face, Q = 1/tanδ; the Greek tanδ spelling is not a lexable symbol and stays a desc note; condition = fill row, e.g. @1 kHz)"
            leakage          = Current, alias: [DCL, IL], desc: "leakage current at rated voltage (DCL on tantalum/niobium sheets; IL in the AVX qualification tables; EDLC leakage)"
            insulation_res   = Resistance, alias: [IR], desc: "insulation resistance (the per-capacitance MΩ·µF form reads as a time constant)"
            ripple_rated     = Current, desc: "rated ripple current (at stated frequency/temperature; sampled alu-electro sheets always spell it out - Rated Ripple / Ripple Current - no symbol face to register; EDLC reads continuous/peak current)"
            temp_min         = Temperature, desc: "operating temperature low bound (TDK splits the range into Min./Max. operating Temperature columns matching this pair; single-range sheets carry one Operating Temperature Range column - the range-face gap, filed in 305)"
            temp_max         = Temperature, desc: "operating temperature high bound (see temp_min)"
            life_hours       = Time, alias: [Endurance], desc: "rated life (endurance) at rated conditions (Endurance on nichicon/KEMET/AVX sheets)"
            shelf_life       = Time, desc: "shelf life at upper category temperature (aluminum electrolytics; KEMET spells Storage Life on the qualification table)"
            cycle_life       = Ratio, desc: "rated charge/discharge cycles (EDLC)"
            voltage_category = Voltage, alias: [VC], desc: "category voltage at upper category temperature (polar electrolytics: e.g. 2/3 of rated at 125 °C; AVX spells Category Voltage (VC))"
            voltage_surge    = Voltage, alias: [VS], desc: "surge voltage, non-repetitive (typically 1.15× rated; AVX spells Surge Voltage (VS))"
            voltage_ac       = Voltage, desc: "AC voltage class rating (safety X/Y caps, film AC face; sampled sheets witness only the Vrms unit in measurement conditions, no column symbol - no alias)"
            safety_class     = Words, desc: "EMI safety class (X1/X2/Y1/Y2)"
            certification    = Words, desc: "safety agency certification (UL / ENEC etc.)"
            rohs             = Flag, desc: "RoHS conformity"
            derating_note    = Words, desc: "derating guidance note"
        ]
    ]

    func Cap([pos, neg]) {
        pos - this - neg
        return [pos, neg]
    }
}

// CAP - Generic Capacitor Component Definition
// Core Rule: stores charge Q = C·V between the terminals; the dielectric and
// construction selections fix the electrical family (the enum groups must not
// be cross-assigned).

general component CAP(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT,
    diel = CAP.X7R,
    cons = CAP.MLCC
) :: ANCH.CAP {
    name        = "Capacitor"
    description = "General Capacitor"

    pins = [
        io [1, 2] = [1, 2]::TERM()
    ]

    spec += [
        capacitance  = cap
        voltage      = volt
        tolerance    = tol
        dielectric   = diel
        construction = cons
        polarized = false  // unified polarity flag for DRC/BOM
        safety_class = SC_NONE
    ]

    model = M.CAP(C = capacitance)
}

// CAP.ELEC - Electrolytic Capacitor (Polarized) Component Definition
// Core Rule: polarized aluminum-oxide capacitor — anode must sit at or above
// cathode potential; wet vs polymer construction stays open at BOM stage.
// Polarity is declared: \+ is the anode pad, \- the cathode (PCAP face).

general component CAP.ELEC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: ANCH.CAP.POL {
    name        = "Electrolytic Capacitor"
    description = "Polarized aluminum electrolytic / polymer aluminum capacitor"

    pins = [
        io [1, 2] = [\+, \-]::PCAP()  // \+ = anode (pad 1), \- = cathode — bare member names (schematic face)
    ]

    spec += [
        capacitance = cap
        voltage     = volt
        tolerance   = tol
        dielectric  = ALUMINUM_OXIDE
        polarized = true  // construction (wet vs polymer) stays open at BOM stage
        safety_class = SC_NONE
    ]
}

// CAP.MLCC - Multilayer Ceramic Capacitor (Non-Polarized) Component Definition
// Core Rule: non-polarized ceramic capacitor; the dielectric class (X7R, X5R,
// C0G, ...) fixes the temperature characteristic and drift behavior.

general component CAP.MLCC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT,
    diel = CAP.X7R
) :: ANCH.CAP {
    name        = "MLCC Capacitor"
    description = "Multilayer Ceramic Capacitor (MLCC), non-polarized"

    pins = [
        io [1, 2] = [1, 2]::TERM()
    ]

    spec += [
        capacitance  = cap
        voltage      = volt
        tolerance    = tol
        dielectric   = diel
        construction = MLCC
        polarized    = false
        safety_class = SC_NONE
    ]
}

// CAP.DISC - Disc Ceramic Capacitor (Non-MLCC) Component Definition
// Core Rule: non-polarized single-layer disk ceramic; common high-voltage,
// low-cost service (defaults to C0G).

general component CAP.DISC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT,
    diel = CAP.C0G
) :: ANCH.CAP {
    name        = "Disc Ceramic Capacitor"
    description = "Non-MLCC disk ceramic capacitor; common high-voltage low-cost"

    pins = [
        io [1, 2] = [1, 2]::TERM()
    ]

    spec += [
        capacitance  = cap
        voltage      = volt
        tolerance    = tol
        dielectric   = diel
        construction = DISC_CERAMIC
        polarized    = false
        safety_class = SC_NONE
    ]
}

// CAP.TANT - Tantalum Capacitor (Polarized) Component Definition
// Core Rule: polarized tantalum-pentoxide capacitor — anode must sit at or
// above cathode potential; wet vs polymer construction stays open at BOM
// stage. Polarity is declared: \+ is the anode pad, \- the cathode (PCAP
// face).

general component CAP.TANT(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: ANCH.CAP.POL {
    name        = "Tantalum Capacitor"
    description = "Polarized tantalum / polymer tantalum capacitor"

    pins = [
        io [1, 2] = [\+, \-]::PCAP()  // \+ = anode (pad 1), \- = cathode — bare member names (schematic face)
    ]

    spec += [
        capacitance = cap
        voltage     = volt
        tolerance   = tol
        dielectric  = TANTALUM_PENTOXIDE
        polarized = true  // construction (wet vs polymer) stays open at BOM stage
        safety_class = SC_NONE
    ]
}

// CAP.NIOB - Niobium Capacitor (Polarized) Component Definition
// Core Rule: polarized niobium-pentoxide capacitor — anode must sit at or
// above cathode potential. Polarity is declared: \+ is the anode pad, \- the
// cathode (PCAP face).

general component CAP.NIOB(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: ANCH.CAP.POL {
    name        = "Niobium Capacitor"
    description = "Polarized niobium pentoxide capacitor"

    pins = [
        io [1, 2] = [\+, \-]::PCAP()  // \+ = anode (pad 1), \- = cathode — bare member names (schematic face)
    ]

    spec += [
        capacitance  = cap
        voltage      = volt
        tolerance    = tol
        dielectric   = NIOBIUM_PENTOXIDE
        construction = NIOBIUM
        polarized    = true
        safety_class = SC_NONE
    ]
}

// CAP.FILM - Film Capacitor (Non-Polarized) Component Definition
// Core Rule: non-polarized plastic-film capacitor; the film dielectric
// (PP/PET/PC/PS/PEN) sets tolerance, stability, and self-healing behavior.

general component CAP.FILM(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT,
    diel = CAP.POLYPROPYLENE
) :: ANCH.CAP {
    name        = "Film Capacitor"
    description = "Non-polarized film capacitor (PP/PET/PC/PS/PEN)"

    pins = [
        io [1, 2] = [1, 2]::TERM()
    ]

    spec += [
        capacitance  = cap
        voltage      = volt
        tolerance    = tol
        dielectric   = diel
        construction = FILM
        polarized    = false
        safety_class = SC_NONE
    ]
}

// CAP.MICA - Mica Capacitor (Non-Polarized) Component Definition
// Core Rule: mica dielectric gives high stability and low loss at high
// frequency and precision service.

general component CAP.MICA(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: ANCH.CAP {
    name        = "Mica Capacitor"
    description = "Mica dielectric capacitor, high stability / high frequency"

    pins = [
        io [1, 2] = [1, 2]::TERM()
    ]

    spec += [
        capacitance  = cap
        voltage      = volt
        tolerance    = tol
        dielectric   = MICA
        construction = MICA
        polarized    = false
        safety_class = SC_NONE
    ]
}

// CAP.SAFETY - X/Y Safety Capacitor (EMI Filter, Non-Polarized) Component Definition
// Core Rule: certified for fail-safe EMI service across the mains; the volt
// formal is the AC RMS rating, not a DC voltage.

general component CAP.SAFETY(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT,
    diel = CAP.POLYPROPYLENE,
    cls  = CAP.SC_X2
) :: ANCH.CAP {
    name        = "Safety Capacitor X/Y"
    description = "EMI safety capacitor (X1/X2 / Y1/Y2); volt = AC RMS rating"

    pins = [
        io [1, 2] = [1, 2]::TERM()
    ]

    spec += [
        capacitance = cap
        voltage = volt     // the volt formal is the AC RMS rating here
        tolerance    = tol
        dielectric   = diel
        construction = FILM
        polarized    = false
        voltage_ac = volt  // AC class face rides its own column
        safety_class = cls
    ]
}

// CAP.SC - Supercapacitor / EDLC (Polarized) Component Definition
// Core Rule: electric-double-layer storage — farad-scale capacitance at low
// voltage, polarized; EDLC doubles as dielectric and construction by
// convention, not as a classical dielectric. Polarity is declared: \+ is the
// anode pad, \- the cathode (PCAP face).

general component CAP.SC(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: ANCH.CAP.POL {
    name        = "Supercapacitor / EDLC"
    description = "Electric Double Layer Capacitor, polarized"

    pins = [
        io [1, 2] = [\+, \-]::PCAP()  // \+ = anode (pad 1), \- = cathode — bare member names (schematic face)
    ]

    spec += [
        capacitance  = cap
        voltage      = volt
        tolerance    = tol
        dielectric   = EDLC
        construction = EDLC
        polarized    = true
        safety_class = SC_NONE
    ]
}

// CAP.TRIM - Trimmer / Variable Capacitor (Non-Polarized) Component Definition
// Core Rule: mechanically adjustable capacitance; the cap formal is the
// nominal (maximum) value.

general component CAP.TRIM(
    cap::UV.CAP,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: ANCH.CAP {
    name        = "Trimmer Capacitor"
    description = "Adjustable trimmer / variable capacitor; cap = nominal/max capacitance"

    pins = [
        io [1, 2] = [1, 2]::TERM()
    ]

    spec += [
        capacitance = cap
        voltage     = volt
        tolerance   = tol
        polarized = false  // dielectric/construction stay open at BOM stage
        safety_class = SC_NONE
    ]
}

// Usage Examples:
// The family decouple method rides the CAP family container recipe (one body,
// adopted by all 11 classes). Two spellings, EQUIVALENT IN NETLIST ONLY:
//   lane form   — io33 => CAP(100nF, 50V, ±10%, X7R).Cap(_) -> [vcc, gnd]
//                 (entry pair feeds the `_` slot; one cap across the pair,
//                 tail zip-ties the pair to the rails — one drawing unit)
//   infix chain — plain series, the lane form's netlist-level expansion.
// THE SEMANTICS ARE NOT EQUIVALENT (semantic-encapsulation axioms A4/S7):
// the lane form carries the trunk semantics down to viz, simulation and
// statistics reconciliation; the infix form is plain wiring — skipped.
// Decoupling/bypass caps are ALWAYS lane form.
// Multi-stage trunks read strictly left to right — each stage's recipe eats
// the current port pair, its returned pair feeds the next stage via `->`;
// chaining two caps on one `=>` hop is the SAME stage (different semantics):
//   [PWR, GND] => CAP(10uF,16V).Cap(_) -> [this.VIN, this.GND] => CAP(100nF,16V).Cap(_)
// Scalar spellings are honest errors now: Cap(vdd) = E4180 (width), bare _
// without a `=>` prefix = E4176. On the polarized classes (ANCH.CAP.POL adopters)
// the first lane of Cap(_) is the \+ terminal - polarity is named on the
// entry pair (PCAP{\+, \-}), never implied by position.
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

// M.CAP - the two-terminal capacitor's model block.
// The charge on the dielectric is C times the voltage across the two
// terminals; the current runs into T1 and out of T2. T2 doubles as the
// reference terminal of the model on its own.
model M.CAP {
    port cur T1::DC()
    port cur T2::DC()
    arg C = Capacitance
    state vc = Voltage = 0V
    eq i(T1) = C * deriv(vc)
    eq i(T2) = 0 - i(T1)
    eq v(T1) - v(T2) = vc
    mat reference = T2
}
