# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Note: construction uses a string tag (no enum). Part metadata (partno /
// package / manufacturer) is top-level; spec carries electrical parameters
// only. rated_current is the thermal rating; sat_current is the saturation
// current (power inductors only).

// IND container: the wound-inductor family contract (general / SMD / THT /
// power / HF populations). Datasheet evidence (7-sheet sample: Coilcraft
// XAL / Mag Layers MMD / Sunltech SLO / Coilank ABG / Murata BLM18K / TDK
// B82790 / Knowles A-series): Irms / Isat / DCR / Rdc / SRF all witnessed
// as table symbols; inductance and tolerance heads are full words. The
// operating-temperature heads are the range face (305) - temp_min/temp_max
// stay unregistered.

recipe IND {
    require = [
        electrical = [
            inductance    = Inductance, desc: "rated inductance (sheet heads: Inductance (µH) / Inductance ±20% - full word, no symbol face)"
            rated_current = Current, alias: [Irms], desc: "thermal current rating (sheet head Irms / Heat rating current, 20°C/40°C-rise classes)"
            dcr           = Resistance, alias: [DCR, Rdc], desc: "DC winding resistance (sheet heads DCR (mΩ) / Rdc / DC Resistance)"
            tolerance     = Ratio, desc: "inductance tolerance (letter codes M / Y / K are values, not symbols)"
        ]
    ]
    option = [
        build = [
            construction  = Words, desc: "mount / construction class (SMD / THT; shielded-construction notes)"
            temp_min      = Temperature, desc: "operating temperature low bound (sheet heads: Operating Temperature Range / Ambient temperature - range face, 305)"
            temp_max      = Temperature, desc: "operating temperature high bound (see temp_min)"
            rohs          = Flag, desc: "RoHS conformity"
            derating_note = Words, desc: "derating guidance note"
        ]
        engineering = [
            sat_current = Current, alias: [Isat], desc: "saturation current, the inductance-collapse limit (sheet head Isat / Saturation current; power population)"
            srf         = Frequency, alias: [SRF], desc: "self-resonant frequency (sheet head SRF typ; HF population)"
        ]
    ]
}

// IND.FB container: the ferrite-bead population - lossy high-frequency
// impedance specified at a test frequency, no inductance face (bead sheet
// witness: Rated Current / DC Resistance / Impedance (at 100MHz)).
recipe IND.FB {
    require = [
        electrical = [
            impedance      = Resistance, desc: "lossy impedance at the stated test frequency (sheet head Impedance (at 100MHz/1GHz) - full word, no symbol face)"
            rated_current  = Current, desc: "rated current (sheet head Rated Current - full phrase)"
            test_frequency = Frequency, desc: "measurement frequency for the impedance value (sheet head Test frequency)"
        ]
    ]
    option = [
        build = [
            construction  = Words, desc: "mount / construction class"
            temp_min      = Temperature, desc: "operating temperature low bound (range face, 305)"
            temp_max      = Temperature, desc: "operating temperature high bound"
            rohs          = Flag, desc: "RoHS conformity"
            derating_note = Words, desc: "derating guidance note"
        ]
    ]
}

// IND.CMC container: the common-mode-choke population - two windings on one
// core (CMC sheets carry their own head family: LR / Lstray / IR / Rtyp;
// the model keeps the two-winding contract faces).
recipe IND.CMC {
    require = [
        electrical = [
            inductance     = Inductance, desc: "winding inductance (CMC sheet head LR - full word face)"
            rated_current  = Current, desc: "rated current (CMC sheet head IR (mA))"
            impedance      = Resistance, desc: "common-mode impedance at the stated test frequency"
            tolerance      = Ratio, desc: "inductance tolerance (letter codes are values, not symbols)"
            test_frequency = Frequency, desc: "measurement frequency for the impedance value (sheet head Test frequency)"
        ]
    ]
    option = [
        build = [
            construction  = Words, desc: "mount / construction class"
            temp_min      = Temperature, desc: "operating temperature low bound (range face, 305)"
            temp_max      = Temperature, desc: "operating temperature high bound"
            rohs          = Flag, desc: "RoHS conformity"
            derating_note = Words, desc: "derating guidance note"
        ]
    ]
}

// IND - Generic Two-Terminal Inductor Component Definition
// Core Rule: V = L dI/dt between the terminals; carries the rated thermal
// current and a DC winding resistance.

abstract component IND(
    ind::UV.IND,
    irated::UV.AMP,
    tol::UV.PERCENT,
    dcr::UV.OHM
) :: IND {
    name        = "Inductor"
    description = "Generic two-terminal inductor"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance    = ind
        rated_current = irated
        dcr           = dcr
        tolerance     = tol
        temp_min      = _
        temp_max      = _
        construction  = _
        rohs          = _
        derating_note = _
    ]
}

// IND.SMD - Surface Mount Inductor Component Definition
// Core Rule: V = L dI/dt with SMD-mount construction; rated thermal current
// and DCR apply.

abstract component IND.SMD(
    ind::UV.IND,
    irated::UV.AMP,
    tol::UV.PERCENT,
    dcr::UV.OHM
) :: IND {
    name        = "SMD Inductor"
    description = "Surface mount two-terminal inductor"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance    = ind
        rated_current = irated
        dcr           = dcr
        tolerance     = tol
        temp_min      = _
        temp_max      = _
        construction  = "SMD"
        rohs          = _
        derating_note = _
    ]
}

// IND.THT - Through-Hole Inductor Component Definition
// Core Rule: V = L dI/dt with THT-mount construction; rated thermal current
// and DCR apply.

abstract component IND.THT(
    ind::UV.IND,
    irated::UV.AMP,
    tol::UV.PERCENT,
    dcr::UV.OHM
) :: IND {
    name        = "Through Hole Inductor"
    description = "Through-hole two-terminal inductor"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance    = ind
        rated_current = irated
        dcr           = dcr
        tolerance     = tol
        temp_min      = _
        temp_max      = _
        construction  = "THT"
        rohs          = _
        derating_note = _
    ]
}

// IND.POWER - Power Inductor Component Definition
// Core Rule: inductor for converter service — adds the saturation current
// limit; beyond it the inductance collapses regardless of the thermal rating.

abstract component IND.POWER(
    ind::UV.IND,
    irated::UV.AMP,
    isat::UV.AMP,
    tol::UV.PERCENT,
    dcr::UV.OHM
) :: IND {
    name        = "Power Inductor"
    description = "Power inductor for DC-DC converters, with saturation current"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance    = ind
        rated_current = irated
        sat_current   = isat
        dcr           = dcr
        tolerance     = tol
        temp_min      = _
        temp_max      = _
        construction  = _
        rohs          = _
        derating_note = _
    ]
}

// IND.HF - High-Frequency / RF Inductor Component Definition
// Core Rule: usable only below the self-resonant frequency (SRF), where the
// winding capacitance turns the inductor resonant.

abstract component IND.HF(
    ind::UV.IND,
    irated::UV.AMP,
    srf::UV.HZ,
    tol::UV.PERCENT,
    dcr::UV.OHM
) :: IND {
    name        = "HF Inductor"
    description = "High-frequency / RF inductor with SRF"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        inductance    = ind
        rated_current = irated
        srf           = srf
        dcr           = dcr
        tolerance     = tol
        temp_min      = _
        temp_max      = _
        construction  = _
        rohs          = _
        derating_note = _
    ]
}

// IND.FB - Ferrite Bead Component Definition
// Core Rule: lossy high-frequency impedance, not an inductor — specified by
// impedance at a test frequency, with no inductance parameter.

abstract component IND.FB(
    impd::UV.OHM,
    irated::UV.AMP,
    ftest::UV.HZ
) :: IND.FB {
    name        = "Ferrite Bead"
    description = "Ferrite bead for high-frequency noise suppression"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        impedance      = impd
        rated_current  = irated
        test_frequency = ftest
        temp_min       = _
        temp_max       = _
        construction   = _
        rohs           = _
        derating_note  = _
    ]
}

// IND.CMC - Common Mode Choke Component Definition
// Core Rule: two windings on one core — high impedance to common-mode
// currents, low impedance to differential currents; four-pin topology,
// modeled as an independent component.

abstract component IND.CMC(
    ind::UV.IND,
    irated::UV.AMP,
    impd::UV.OHM,
    tol::UV.PERCENT,
    ftest::UV.HZ
) :: IND.CMC {
    name        = "Common Mode Choke"
    description = "4-terminal common mode choke"

    pins = [
        1 = 1, "W1_IN"
        2 = 2, "W1_OUT"
        3 = 3, "W2_IN"
        4 = 4, "W2_OUT"
    ]

    spec = [
        inductance     = ind
        rated_current  = irated
        impedance      = impd
        tolerance      = tol
        test_frequency = ftest
        temp_min       = _
        temp_max       = _
        construction   = _
        rohs           = _
        derating_note  = _
    ]

    func CommonModeSuppress(w1_in, w1_out, w2_in, w2_out) {
        w1_in - this{1}
        this{2} - w1_out
        w2_in - this{3}
        this{4} - w2_out
        return w1_out, w2_out
    }
}

// Usage Examples:
// =============================================================================
// IND(100μH, 1A, ±10%, 0.1Ω): nodeA -> IND(100μH, 1A, ±10%, 0.1Ω) -> nodeB        // two-terminal part, default 1x2 shape placement
// IND.SMD(47μH, 2A, ±10%, 0.08Ω): sw_node -> IND.SMD(47μH, 2A, ±10%, 0.08Ω) -> ldo_in
// IND.POWER(47μH, 3A, 4A, ±20%, 0.05Ω): sw -> IND.POWER(47μH, 3A, 4A, ±20%, 0.05Ω) -> out
// IND.HF(10μH, 0.5A, 50MHz, ±5%, 0.2Ω): rf_in -> IND.HF(10μH, 0.5A, 50MHz, ±5%, 0.2Ω) -> filter_out
// IND.FB(100Ω, 1A, 100MHz): io_line -> IND.FB(100Ω, 1A, 100MHz) -> soc_pin
// IND.CMC(100μH, 2A, 100Ω, ±20%, 100MHz).CommonModeSuppress(line_in, line_out, ret_in, ret_out)
