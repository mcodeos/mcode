# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Resistor family book. One recipe container per resistor model; a class
// adopts the containers it implements and exposes those containers' funcs.
//   RES        - fixed two-terminal resistor (the generic answer sheet)
//   PULL       - shared pull-up / pull-down hookup helpers
//   RES.NTC    - NTC thermistor (beta characteristic)
//   RES.LDR    - light dependent resistor (illuminance face)
//   RES.ARRAY  - multi-channel resistor network (instance-topology pins)
// Recipes carry structure only; values live in ctor/spec defaults and at
// the BOM layer. Note: construction uses a plain string tag (no enum).
// Tolerance: integer percentage omits .0; keep decimals only when needed.

// PULL - shared pull-up / pull-down hookup recipe. Bare-row anchor; the
// adopter's [T1, T2]::TERM() binding satisfies it by member name.

recipe PULL {
    io T1
    io T2
    func Pullup([node, hot]) {
        node - this.T1
        hot - this.T2
    }

    func Pulldown([node, ret]) {
        node - this.T1
        ret - this.T2
    }
}

// RES - fixed resistor family container. The generic answer sheet shared by
// every two-terminal fixed resistor class.
recipe RES {
    io [1, 2]
    require = [
        electrical = [
            resistance  = Resistance, desc: "nominal resistance element value (Ohm law face)"
            voltage     = Voltage, desc: "maximum working voltage rating"
            power_rated = Power, desc: "power dissipation rating"
            tolerance   = Ratio, desc: "resistance tolerance grade (integer percentage omits .0)"
        ]
    ]
    option = [
        engineering = [
            temp_coeff    = TempCo, desc: "temperature coefficient of resistance (e.g. 100 ppm/°C)"
            temp_min      = Temperature, desc: "minimum operating temperature"
            temp_max      = Temperature, desc: "maximum operating temperature"
            construction  = Words, desc: "construction class (SMD, SMD_POWER, THT, ...)"
            rohs          = Flag, desc: "RoHS compliance fact for BOM"
            derating_note = Words, desc: "derating rule note (power vs ambient temperature face)"
        ]
    ]
}

// RES - Generic Two-Terminal Fixed Resistor Component Definition
// Core Rule: obeys Ohm's law between the terminals; dissipation limited to
// the rated power, value drift bounded by the temperature coefficient.

component RES(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
) :: RES, PULL {
    name        = "Resistor"
    description = "Generic resistor"

    pins = [
        io [1, 2] = [T1, T2]::TERM()  // interchangeable terminals, positional binding
    ]

    spec = [
        resistance    = rs
        voltage       = volt
        power_rated   = prated
        tolerance     = tol
        temp_coeff    = tc  //e.g. 100.0ppm/℃
        temp_min      = _
        temp_max      = _
        construction  = _
        rohs          = _
        derating_note = _
    ]
}

// RES.SMD - Surface Mount Fixed Resistor Component Definition
// Core Rule: standard chip resistor — Ohm's law with SMD-mount construction
// tag.

component RES.SMD(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
) :: RES, PULL {
    name        = "SMD Resistor"
    description = "Surface mount two-terminal fixed resistor"

    pins = [
        io [1, 2] = [T1, T2]::TERM()  // interchangeable terminals, positional binding
    ]

    spec = [
        resistance    = rs
        voltage       = volt
        power_rated   = prated
        tolerance     = tol
        temp_coeff    = tc
        temp_min      = _
        temp_max      = _
        construction  = "SMD"
        rohs          = _
        derating_note = _
    ]
}

// RES.SMD_POWER - Surface Mount Power Resistor Component Definition
// Core Rule: chip construction rated for substantially higher dissipation
// than a standard chip resistor; thermal pad/derating governs the usable
// power.

component RES.SMD_POWER(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
) :: RES, PULL {
    name        = "SMD Power Resistor"
    description = "Surface mount high-power two-terminal resistor"

    pins = [
        io [1, 2] = [T1, T2]::TERM()  // interchangeable terminals, positional binding
    ]

    spec = [
        resistance    = rs
        voltage       = volt
        power_rated   = prated
        tolerance     = tol
        temp_coeff    = tc
        temp_min      = _
        temp_max      = _
        construction  = "SMD_POWER"
        rohs          = _
        derating_note = _
    ]
}

// RES.THT - Through-Hole Fixed Resistor Component Definition
// Core Rule: axial through-hole resistor — Ohm's law with THT-mount
// construction tag.

component RES.THT(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
) :: RES, PULL {
    name        = "Through Hole Resistor"
    description = "Axial through-hole two-terminal fixed resistor"

    pins = [
        io [1, 2] = [T1, T2]::TERM()  // interchangeable terminals, positional binding
    ]

    spec = [
        resistance    = rs
        voltage       = volt
        power_rated   = prated
        tolerance     = tol
        temp_coeff    = tc
        temp_min      = _
        temp_max      = _
        construction  = "THT"
        rohs          = _
        derating_note = _
    ]
}

// RES.POT - Potentiometer Component Definition
// Core Rule: three-terminal variable resistor — the wiper (pin 3) taps the
// element between the two ends, supporting divider or rheostat mode. The
// end pair rides the RES anchor face; the wiper stays a bare row (the
// terminal iface is strictly two-pin).

component RES.POT(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
) :: RES, PULL {
    name        = "Potentiometer / Trim Pot"
    description = "3-terminal adjustable resistor, support divider or rheostat mode"

    pins = [
        io [1, 2] = [T1, T2]::TERM()  // element ends, positional binding
        3         = 3, "Wiper"        // wiper tap (bare row - third terminal)
    ]

    spec = [
        resistance    = rs
        voltage       = volt
        power_rated   = prated
        tolerance     = tol
        temp_coeff    = tc
        temp_min      = _
        temp_max      = _
        construction  = _
        rohs          = _
        derating_note = _
    ]

    func Divider(input, output, gnd) {
        [input, gnd] - this{1, 3 | 2, 3} - [output, gnd]
        return output
    }

    func Rheostat([end_a, end_b]) {
        end_a - this{1 | 2} - end_b
        // Pin3 floating
        return end_b
    }
}

// RES.NTC - NTC thermistor container. The beta characteristic is the
// family face; the fixed-resistor temperature columns stay open.
recipe RES.NTC {
    io [1, 2]
    require = [
        electrical = [
            resistance       = Resistance, alias: [R25], desc: "nominal resistance at the reference temperature (25 °C zero-power face; sheet heads: Resistance @25 (R25) / R25 Resistance Value at Rated Zero-power, both NTC sheets)"
            beta_coefficient = Ratio, alias: [B], desc: "beta characteristic constant (dimensionless, e.g. 3950; sheet head B Value with B-25/50 B-25/85 categories, MF52 sheet)"
            voltage          = Voltage, desc: "maximum working voltage rating"
            tolerance        = Ratio, desc: "resistance tolerance grade"
        ]
    ]
}

// RES.NTC - NTC Thermistor Component Definition
// Core Rule: resistance falls with temperature following the beta
// characteristic; used for temperature sensing and inrush limiting.

component RES.NTC(
    rs::UV.OHM,
    beta::INT,
    volt::UV.VOLT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP
) :: RES.NTC, PULL {
    name        = "NTC Thermistor"
    description = "Negative temperature coefficient thermistor"

    pins = [
        io [1, 2] = [T1, T2]::TERM()  // interchangeable terminals, positional binding
    ]

    spec = [
        resistance       = rs
        beta_coefficient = beta
        voltage          = volt
        power_rated      = _
        tolerance        = tol
        temp_coeff       = tc
        temp_min         = _
        temp_max         = _
        construction     = _
        rohs             = _
        derating_note    = _
    ]
}

// RES.ARRAY - resistor network container. No pin anchor: the channel count
// is an instance-topology fact (expansion rows), answered per part.
recipe RES.ARRAY {
    require = [
        electrical = [
            resistance  = Resistance, desc: "nominal resistance per element"
            voltage     = Voltage, desc: "maximum working voltage rating"
            power_rated = Power, desc: "power dissipation rating per element"
            tolerance   = Ratio, desc: "resistance tolerance grade"
        ]
    ]
    option = [
        engineering = [
            channel_count = Counter, desc: "number of independent resistor channels"
            temp_coeff    = TempCo, desc: "temperature coefficient of resistance"
            construction  = Words, desc: "construction class (ARRAY_SMD, ARRAY_THT, ...)"
            rohs          = Flag, desc: "RoHS compliance fact for BOM"
            derating_note = Words, desc: "derating rule note"
        ]
    ]
}

// RES.ARRAY - Resistor Array Component Definition
// Core Rule: independent multi-channel resistor network, modeled separately
// from discrete resistors.
// Note: no single-resistor pull-up/pull-down helpers; series placement uses
// the default 1x2 shape. Channels get two pins each (CH1T1, CH1T2, CH2T1, ...).

component RES.ARRAY(
    rs::UV.OHM,
    volt::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT,
    tc::UV.PPM/UV.TEMP,
    channels::INT,
    cons::STRING
) :: RES.ARRAY {
    name        = "Resistor Array"
    description = "Multi-channel integrated resistor network; separate model from discrete resistor"

    pins = [
        1 : 2 * channels = CH[1:channels]T[1:2]  // 2 pins per channel: CH1T1, CH1T2, CH2T1, ...
    ]

    spec = [
        resistance    = rs
        voltage       = volt
        power_rated   = prated
        tolerance     = tol
        temp_coeff    = tc
        temp_min      = _
        temp_max      = _
        channel_count = channels
        construction  = cons
        rohs          = _
        derating_note = _
    ]
}

// RES.LDR - light dependent resistor container. The illuminance face is
// the family answer: light/dark resistance instead of one fixed value.
recipe RES.LDR {
    io [1, 2]
    require = [
        electrical = [
            resistance_light = Resistance, desc: "resistance at the reference illuminance"
            resistance_dark  = Resistance, desc: "dark resistance floor (maximum resistance, no illumination)"
            voltage          = Voltage, desc: "maximum working voltage rating"
            tolerance        = Ratio, desc: "resistance tolerance grade"
        ]
    ]
    option = [
        optical = [
            peak_wavelength = Length, desc: "peak spectral response wavelength"
            response_rise   = Time, desc: "response rise time at the stated illuminance"
            response_fall   = Time, desc: "response fall time at the stated illuminance"
        ]
        engineering = [
            rohs = Flag, desc: "RoHS compliance fact for BOM"
        ]
    ]
}

// RES.LDR - Light Dependent Resistor (Photoresistor) Component Definition
// Core Rule: resistance falls with illuminance, bounded by the dark
// resistance.

component RES.LDR(
    rlight::UV.OHM,
    rdark::UV.OHM,
    volt::UV.VOLT,
    tol::UV.PERCENT
) :: RES.LDR, PULL {
    name        = "LDR Photoresistor"
    description = "Light dependent resistor, resistance falls with illuminance"

    pins = [
        io [1, 2] = [T1, T2]::TERM()  // interchangeable terminals, positional binding
    ]

    spec = [
        resistance_light = rlight
        resistance_dark  = rdark
        voltage          = volt
        tolerance        = tol
        peak_wavelength  = _
        response_rise    = _
        response_fall    = _
        rohs             = _
    ]
}

// Usage Examples:
// =============================================================================
// signal - RES(10kΩ, 50V, 0.125W, 5%, 100ppm/℃) - vcc                       // plain infix
// RES(10kΩ, 50V, 0.125W, 5%, 100ppm/℃).Pullup([signal, vcc])                  // pull-up via the PULL recipe
// RES.SMD(470Ω, 50V, 0.125W, 5%, 100ppm/℃).Pulldown([enable, gnd])              // pull-down via the PULL recipe
// vcc -> RES.THT(1kΩ, 250V, 0.25W, 5%, 200ppm/℃) -> load                  // two-terminal part, default 1x2 shape placement
// vout -> RES.SMD_POWER(0.1Ω, 100V, 2W, 5%, 100ppm/℃) -> load
// RES.POT(10kΩ, 50V, 0.1W, 20%, 100ppm/℃).Divider(vcc, fb, gnd)
// ntc_node -> RES.NTC(10kΩ, 3950, 5V, 5%, 100ppm/℃) -> gnd
// vin -> FUSE.PTC(500mA, 24V, 100mA) -> load
// RES.ARRAY(220Ω, 50V, 0.1W, 5%, 100ppm/℃, 4, "ARRAY_SMD")
// RES.ARRAY(220Ω, 50V, 0.1W, 5%, 100ppm/℃, 4, "ARRAY_THT")
