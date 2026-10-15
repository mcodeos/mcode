# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

use ../ifs/dio

// Diode family book. One recipe container per diode model; a class adopts
// the container it implements and exposes that container's funcs.
//   DIO           - junction conduction (general-purpose, Schottky)
//   DIO.CLAMP     - reverse-breakdown clamp (zener, TVS, ESD)
//   DIO.PHOTO     - photocurrent (photodiode)
//   DIO.BR        - bridge rectifier composite
//   DIO.ESD_ARRAY - multi-line ESD array
// Recipes carry structure only; values live in ctor/spec defaults and at
// the BOM layer.

recipe DIO
{
    // Entry pair anchor; adopters bind [A, K]::DIO() (bare member names
    // render on the schematic).
    io DIO{A, K}

    require = [
        electrical = [
            forward_voltage = Voltage, desc: "forward voltage VF at the rated current"
            reverse_voltage = Voltage, desc: "repetitive peak reverse voltage rating VRRM"
            rated_current   = Current, desc: "average forward rectified current rating"
            polarized       = Flag, desc: "polarity fact for DRC/BOM (true for every class here; the A/K entry names carry the connectivity polarity)"
        ]
    ]
    option = [
        engineering = [
            reverse_leakage = Current, desc: "reverse leakage current IR at the rated reverse voltage"
            junction_cap    = Capacitance, desc: "junction capacitance Cj at the stated bias (fill row, e.g. @0V, 1 MHz)"
            recovery_time   = Time, desc: "reverse recovery time trr (switching face)"
        ]
    ]

    // Series insertion, anode side first.
    func Fwd([a, k])
    {
        a - this.A
        this.K - k
        return [a, k]
    }
}

// Reverse-breakdown clamp container.
recipe DIO.CLAMP
{
    io DIO{A, K}

    require = [
        clamp = [
            breakdown_voltage = Voltage, desc: "breakdown voltage (VZ at the test current for regulators; VBR for TVS; the working standoff for ESD steer classes)"
            polarized         = Flag, desc: "polarity fact for DRC/BOM (true for every class here)"
        ]
    ]
    option = [
        clamp = [
            forward_voltage  = Voltage, desc: "forward voltage VF (conduction face)"
            reverse_leakage  = Current, desc: "reverse leakage IR below breakdown"
            rated_current    = Current, desc: "steady-state forward current rating"
            clamping_voltage = Voltage, desc: "clamping voltage VC at the peak pulse current (TVS)"
            power_rated      = Power, desc: "steady-state dissipation rating (regulator face)"
            peak_power       = Power, desc: "peak pulse power rating (transient / ESD face)"
            tolerance        = Ratio, desc: "breakdown voltage tolerance grade (zener)"
            esd_rating       = Voltage, desc: "ESD withstand class voltage (IEC 61000-4-2 face)"
        ]
    ]

    // Shunt clamp: line into the cathode, anode to the reference.
    func Clamp([line, ref])
    {
        line - this.K
        this.A - ref
        return this
    }
}

// Photocurrent container.
recipe DIO.PHOTO
{
    io DIO{A, K}

    require = [
        optical = [
            responsivity = Responsivity, desc: "generated current per incident power, at the stated wavelength"
            dark_current = Current, desc: "leakage floor without illumination"
            polarized    = Flag, desc: "polarity fact for DRC/BOM (true; reverse bias is the operating face)"
        ]
    ]
    option = [
        optical = [
            spectral_range = Length, desc: "spectral response range (wavelength bounds)"
            junction_cap   = Capacitance, desc: "junction capacitance at the stated reverse bias (bandwidth face)"
        ]
    ]

    // Reverse-bias hookup: bias into the cathode, anode is the readout.
    func Sense([bias, sig])
    {
        bias - this.K
        this.A - sig
        return sig
    }
}

// Bridge rectifier composite; contact order = ~ + ~ - around the DIP-4
// package.
recipe DIO.BR
{
    require = [
        electrical = [
            current_average = Current, desc: "average forward output current rating"
            voltage_reverse = Voltage, desc: "repetitive peak reverse voltage VRRM"
            forward_voltage = Voltage, desc: "forward voltage per element at the rated current"
            polarized       = Flag, desc: "polarity fact for DRC/BOM (true; the DC+/DC- outputs carry the connectivity polarity)"
        ]
    ]
}

// Multi-line ESD array: N signal lines steering to a common clamp
// reference.
recipe DIO.ESD_ARRAY
{
    require = [
        clamp = [
            esd_rating = Voltage, desc: "ESD withstand class voltage (IEC 61000-4-2 face)"
        ]
    ]
}

// General-purpose diode: conducts from anode to cathode above the forward
// voltage, blocks in reverse up to the reverse voltage rating.
component DIO(
    vfwd::UV.VOLT,
    vrev::UV.VOLT,
    irated::UV.AMP
) :: DIO
{
    name = "Diode"

    pins = [
        io [1, 2] = [A, K]::DIO()   // A = anode (pad 1), K = cathode
    ]

    spec = [
        forward_voltage = vfwd
        reverse_voltage = vrev
        rated_current = irated
        polarized = true
    ]
}

// Schottky diode: metal-semiconductor junction - lower forward drop and
// faster recovery than a standard PN diode, at a lower reverse voltage
// rating. Same conduction equation as DIO; only the ratings differ.
component DIO.SCH(
    vfwd::UV.VOLT,
    vrev::UV.VOLT,
    irated::UV.AMP
) :: DIO
{
    name = "Schottky Diode"

    pins = [
        io [1, 2] = [A, K]::DIO()   // A = anode (pad 1), K = cathode
    ]

    spec = [
        forward_voltage = vfwd
        reverse_voltage = vrev
        rated_current = irated
        polarized = true
    ]
}

// Zener diode: operates in reverse breakdown - clamps at the zener voltage
// while dissipating up to the rated power; the tolerance grades the clamp
// accuracy.
component DIO.ZEN(
    vz::UV.VOLT,
    prated::UV.WATT,
    tol::UV.PERCENT
) :: DIO.CLAMP
{
    name = "Zener Diode"

    pins = [
        io [1, 2] = [A, K]::DIO()   // A = anode (pad 1), K = cathode
    ]

    spec = [
        breakdown_voltage = vz
        power_rated = prated
        tolerance = tol
        polarized = true
    ]
}

// Transient voltage suppressor: inactive at normal operating voltage,
// breaks down at the breakdown voltage, absorbs the surge energy at the
// clamping voltage up to the peak power rating.
component DIO.TVS(
    vbr::UV.VOLT,
    vclamp::UV.VOLT,
    ppeak::UV.WATT
) :: DIO.CLAMP
{
    name = "Transient Voltage Suppressor"

    pins = [
        io [1, 2] = [A, K]::DIO()   // A = anode (pad 1), K = cathode
    ]

    spec = [
        breakdown_voltage = vbr
        clamping_voltage = vclamp
        peak_power = ppeak
        polarized = true
    ]
}

// ESD protection diode: steers a protected line to the clamp reference -
// junction conduction on the steering side, breakdown standoff on the
// working face; rated by the working standoff / ESD withstand voltage.
component DIO.ESD(
    rating::UV.VOLT
) :: DIO.CLAMP
{
    name = "ESD Diode"

    pins = [
        io [1, 2] = [A, K]::DIO()   // A = anode (pad 1), K = cathode
    ]

    spec = [
        breakdown_voltage = rating
        esd_rating = rating
        polarized = true
    ]
}

// ESD protection diode array: two protected signal lines steering to a
// common clamp reference; same clamp law as DIO.ESD in a multi-line
// topology.
component DIO.ESD_ARRAY(
    rating::UV.VOLT
) :: DIO.ESD_ARRAY
{
    name = "ESD Protection Diode Array"

    pins = [
        io [1, 2] = [IO1, IO2]   # protected signal lines
        3 = GND                  # clamp reference
    ]

    spec = [
        esd_rating = rating
    ]
}

// Photodiode: a reverse-biased junction generating a photocurrent
// proportional to incident light (responsivity) plus a leakage dark
// current, over the specified spectral range.
component DIO.PHOTO(
    resp::UV.RESPONSIVITY,
    idark::UV.AMP,
    srange::UV.LEN
) :: DIO.PHOTO
{
    name = "Photodiode"

    pins = [
        io [1, 2] = [A, K]::DIO()   // A = anode (pad 1), K = cathode
    ]

    spec = [
        responsivity = resp
        dark_current = idark
        spectral_range = srange
        polarized = true
    ]
}

// Bridge rectifier: four diodes in one package full-wave rectify an AC
// input into DC outputs; the two AC terminals are interchangeable.
component DIO.BR(
    iavg::UV.AMP,
    vrrm::UV.VOLT,
    vfwd::UV.VOLT
) :: DIO.BR
{
    name = "Bridge Rectifier"
    description = "Single-phase bridge rectifier, two AC inputs and two DC outputs"

    pins = [
        1 = AC1         # AC input 1 (tilde terminal)
        2 = DC\+        # Rectified positive output
        3 = AC2         # AC input 2 (tilde terminal)
        4 = DC\-        # Rectified negative output
    ]

    spec = [
        current_average = iavg
        voltage_reverse = vrrm
        forward_voltage = vfwd
        polarized = true
    ]
}

// Usage Examples:
// 1. Basic diode as a series rectifier element
// DIO(0.7V, 1000V, 1.0A).Fwd([ac_net, dc_net])
//
// 2. Schottky diode for fast rectification
// DIO.SCH(0.3V, 40V, 5.0A).Fwd([high_freq_ac, dc_output])
//
// 3. Zener diode clamping a line to its reference
// DIO.ZEN(5.1V, 0.5W, 5%).Clamp([unregulated_line, gnd])
//
// 4. TVS diode absorbing a surge on a sensitive line
// DIO.TVS(12V, 15V, 500W).Clamp([sensitive_line, gnd])
//
// 5. Photodiode sensing light through a reverse bias
// DIO.PHOTO(0.5A/W, 1nA, 850nm).Sense([5.0V, light_output])
