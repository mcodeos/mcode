# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// ---------------------------------------------------------------------------------------------
// Resistor Component Definitions
// No enum; construction uses plain string tag
// Tolerance: integer percentage omit .0, only keep decimal when needed
// ---------------------------------------------------------------------------------------------

// =============================================================================
// Generic 2-pin fixed resistor (allow direct instantiation)
// =============================================================================
recipe PullTie
{
    func Pull([node, supply])
    {
        node - this.1
        supply - this.2
    }
}

component RES(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
) :: PullTie
{
    name = "Resistor"
    description = "Generic resistor"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance = rs
        voltage = volt
        power_rated = prated
        tolerance = tol
        temp_coeff = tc         //e.g. 100.0ppm/℃
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]

}

// =============================================================================
// SMD Fixed Resistor (Standard Chip)
// =============================================================================
component RES.SMD(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
)
{
    name = "SMD Resistor"
    description = "Surface mount two-terminal fixed resistor"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance = rs
        voltage = volt
        power_rated = prated
        tolerance = tol
        temp_coeff = tc
        temp_min = _
        temp_max = _
        construction = "SMD"
        rohs = _
        derating_note = _
    ]

}

// =============================================================================
// SMD Power Resistor
// =============================================================================
component RES.SMD_POWER(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
)
{
    name = "SMD Power Resistor"
    description = "Surface mount high-power two-terminal resistor"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance = rs
        voltage = volt
        power_rated = prated
        tolerance = tol
        temp_coeff = tc
        temp_min = _
        temp_max = _
        construction = "SMD_POWER"
        rohs = _
        derating_note = _
    ]
}

// =============================================================================
// THT Fixed Resistor
// =============================================================================
component RES.THT(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
)
{
    name = "Through Hole Resistor"
    description = "Axial through-hole two-terminal fixed resistor"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance = rs
        voltage = volt
        power_rated = prated
        tolerance = tol
        temp_coeff = tc
        temp_min = _
        temp_max = _
        construction = "THT"
        rohs = _
        derating_note = _
    ]

}

// =============================================================================
// Potentiometer (3-terminal variable resistor)
// =============================================================================
component RES.POT(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
)
{
    name = "Potentiometer / Trim Pot"
    description = "3-terminal adjustable resistor, support divider or rheostat mode"

    pins = [
        1 = 1, "End 1"
        2 = 2, "Wiper"
        3 = 3, "End 2"
    ]

    spec = [
        resistance = rs
        voltage = volt
        power_rated = prated
        tolerance = tol
        temp_coeff = tc
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]

    func VoltageDivider(input, output, gnd)
    {
        [input, gnd] - this{1,3|2,3} - [output, gnd]
        return output
    }

    func Rheostat([net_a, net_b])
    {
        net_a - this{1|2} - net_b
        // Pin3 floating
        return net_b
    }
}

// =============================================================================
// NTC Thermistor
// =============================================================================
component RES.NTC(
    rs::UV.OHM,
    beta::INT,
    volt::UV.VOLT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
)
{
    name = "NTC Thermistor"
    description = "Negative temperature coefficient thermistor"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance = rs
        beta_coefficient = beta
        voltage = volt
        power_rated = _
        tolerance = tol
        temp_coeff = tc
        temp_min = _
        temp_max = _
        construction = _
        rohs = _
        derating_note = _
    ]
}

// =============================================================================
// Resistor Array — Independent component, NO single-resistor funcs
// =============================================================================
component RES.ARRAY(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP,
    chcount::INT,
    mount::STRING
)
{
    name = "Resistor Array"
    description = "Multi-channel integrated resistor network; separate model from discrete resistor"

    pins = [
        1 = 1
        2 = 2
        3 = 3
        4 = 4
    ]

    spec = [
        resistance = rs
        voltage = volt
        power_rated = prated
        tolerance = tol
        temp_coeff = tc
        temp_min = _
        temp_max = _
        channel_count = chcount
        construction = mount
        rohs = _
        derating_note = _
    ]
    // No pull-up/pull-down helpers here; series placement uses default 1×2 shape
    // Extend with dedicated channel binding functions later if needed
}

// =============================================================================
// LDR — Light Dependent Resistor (photoresistor)
// =============================================================================
component RES.LDR(
    rlight::UV.OHM,
    rdark::UV.OHM,
    volt::UV.VOLT,
    tol::UV.PERCENT
)
{
    name = "LDR Photoresistor"
    description = "Light dependent resistor, resistance falls with illuminance"

    pins = [
        1 = 1, "Term 1"
        2 = 2, "Term 2"
    ]

    spec = [
        resistance_light = rlight
        resistance_dark = rdark
        voltage = volt
        tolerance = tol
        peak_wavelength = _
        response_rise = _
        response_fall = _
        rohs = _
    ]
}

# =============================================================================
# Usage Examples
# =============================================================================
# signal - RES(10kΩ, 50V, 0.125W, 5%, 100ppm/℃) - vcc                       // plain infix
# RES(10kΩ, 50V, 0.125W, 5%, 100ppm/℃).Pull([signal, vcc])                  // pull-up via the PullTie recipe
# RES.SMD(470Ω, 50V, 0.125W, 5%, 100ppm/℃).Pull([enable, gnd])              // pull-down via the PullTie recipe
# vcc -> RES.THT(1kΩ, 250V, 0.25W, 5%, 200ppm/℃) -> load                  // two-terminal part, default 1x2 shape placement
# vout -> RES.SMD_POWER(0.1Ω, 100V, 2W, 5%, 100ppm/℃) -> load
# RES.POT(10kΩ, 50V, 0.1W, 20%).VoltageDivider(vcc, fb, gnd)
# ntc_node -> RES.NTC(10kΩ, 3950, 5V, 5%) -> gnd
# vin -> FUSE.PTC(500mA, 24V, 100mA) -> load
# RES.ARRAY(220Ω, 50V, 0.1W, 5%, 100ppm/℃, 4, "ARRAY_SMD")
# RES.ARRAY(220Ω, 50V, 0.1W, 5%, 100ppm/℃, 4, "ARRAY_THT")
