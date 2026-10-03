# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Note: construction uses a string tag (no enum). Part metadata (partno /
// package / manufacturer) is top-level; spec carries electrical parameters
// only. rated_current is the thermal rating; sat_current is the saturation
// current (power inductors only).

// IND - Generic Two-Terminal Inductor Component Definition
// Core Rule: V = L dI/dt between the terminals; carries the rated thermal
// current and a DC winding resistance.

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

// IND.SMD - Surface Mount Inductor Component Definition
// Core Rule: V = L dI/dt with SMD-mount construction; rated thermal current
// and DCR apply.

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

// IND.THT - Through-Hole Inductor Component Definition
// Core Rule: V = L dI/dt with THT-mount construction; rated thermal current
// and DCR apply.

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

// IND.POWER - Power Inductor Component Definition
// Core Rule: inductor for converter service — adds the saturation current
// limit; beyond it the inductance collapses regardless of the thermal rating.

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

// IND.HF - High-Frequency / RF Inductor Component Definition
// Core Rule: usable only below the self-resonant frequency (SRF), where the
// winding capacitance turns the inductor resonant.

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

// IND.FB - Ferrite Bead Component Definition
// Core Rule: lossy high-frequency impedance, not an inductor — specified by
// impedance at a test frequency, with no inductance parameter.

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

// IND.CMC - Common Mode Choke Component Definition
// Core Rule: two windings on one core — high impedance to common-mode
// currents, low impedance to differential currents; four-pin topology,
// modeled as an independent component.

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

// Usage Examples:
// =============================================================================
// IND(100μH, 1A, ±10%, 0.1Ω): nodeA -> IND(100μH, 1A, ±10%, 0.1Ω) -> nodeB        // two-terminal part, default 1x2 shape placement
// IND.SMD(47μH, 2A, ±10%, 0.08Ω): sw_node -> IND.SMD(47μH, 2A, ±10%, 0.08Ω) -> ldo_in
// IND.POWER(47μH, 3A, 4A, ±20%, 0.05Ω): sw -> IND.POWER(47μH, 3A, 4A, ±20%, 0.05Ω) -> out
// IND.HF(10μH, 0.5A, 50MHz, ±5%, 0.2Ω): rf_in -> IND.HF(10μH, 0.5A, 50MHz, ±5%, 0.2Ω) -> filter_out
// IND.FB(100Ω, 1A, 100MHz): io_line -> IND.FB(100Ω, 1A, 100MHz) -> soc_pin
// IND.CMC(100μH, 2A, 100Ω, ±20%, 100MHz).CommonModeSuppress(line_in, line_out, ret_in, ret_out)
