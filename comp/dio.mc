# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// DIO - Generic Diode Component Definition
// Core Rule: conducts from anode to cathode above the forward voltage and
// blocks in reverse up to the reverse voltage rating.

component DIO(vfwd::UV.VOLT, vrev::UV.VOLT, irated::UV.AMP)
{
    name = "Diode"
    spec = [
        forward_voltage = vfwd
        reverse_voltage = vrev
        rated_current = irated
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
}

// DIO.ESD - ESD Protection Diode Component Definition
// Core Rule: clamps a protected line to the clamp reference through a diode
// drop; rated by ESD withstand voltage.

component DIO.ESD(rating::UV.VOLT)
{
    name = "ESD Diode"
    spec = [
        esd_rating = rating
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func Protect([input, gnd])
    {
        [input, gnd] - [this.CATHODE, this.ANODE]
        return [input, gnd]
    }
}

// DIO.ESD_ARRAY - ESD Protection Diode Array Component Definition
// Core Rule: two protected signal lines clamped to a common clamp reference;
// same clamp-reference law as DIO.ESD in array form.

component DIO.ESD_ARRAY(rating::UV.VOLT)
{
    name = "ESD Protection Diode Array"
    spec = [
        esd_rating = rating
    ]

    pins = [
        io [1,2] = [IO1, IO2]   # protected signal lines
        3 = GND                 # clamp reference
    ]
}

// DIO.SCH - Schottky Diode Component Definition
// Core Rule: metal-semiconductor junction — lower forward drop and faster
// recovery than a standard PN diode, at a lower reverse voltage rating.

component DIO.SCH(vfwd::UV.VOLT, vrev::UV.VOLT, irated::UV.AMP)
{
    name = "Schottky Diode"
    spec = [
        forward_voltage = vfwd
        reverse_voltage = vrev
        rated_current = irated
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func Rectify(input, output)
    {
        input - this.ANODE
        this.CATHODE - output
        return this
    }
}

// DIO.ZEN - Zener Diode Component Definition
// Core Rule: operates in reverse breakdown — clamps at the zener voltage
// while dissipating up to the rated power; the tolerance grades the clamp
// accuracy.

component DIO.ZEN(vz::UV.VOLT, prated::UV.WATT, tol::UV.PERCENT)
{
    name = "Zener Diode"
    spec = [
        zener_voltage = vz
        power_rated = prated
        tolerance = tol
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func Regulate(input, output, gnd)
    {
        input - this.CATHODE
        this.ANODE - gnd
        output - this.CATHODE
        return this
    }
}

// DIO.TVS - Transient Voltage Suppressor Component Definition
// Core Rule: stays out of the way at normal operating voltage, breaks down at
// the breakdown voltage, and absorbs the surge energy at a clamping voltage
// up to the peak power rating.

component DIO.TVS(vbr::UV.VOLT, vclamp::UV.VOLT, ppeak::UV.WATT)
{
    name = "Transient Voltage Suppressor"
    spec = [
        breakdown_voltage = vbr
        clamping_voltage = vclamp
        peak_power = ppeak
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func Protect(input, gnd)
    {
        input - this.CATHODE
        this.ANODE - gnd
        return this
    }
}

// DIO.PHOTO - Photodiode Component Definition
// Core Rule: reverse-biased junction generates a photocurrent proportional
// to incident light (responsivity) plus a leakage dark current, over the
// specified spectral range.

component DIO.PHOTO(resp::UV.RESPONSIVITY, idark::UV.AMP, srange::UV.LEN)
{
    name = "Photodiode"
    spec = [
        responsivity = resp
        dark_current = idark
        spectral_range = srange
    ]
    
    pins = [
        1 = ANODE        # Positive terminal
        2 = CATHODE      # Negative terminal
    ]
    
    func Sense(vcc, output)
    {
        vcc - this.CATHODE
        this.ANODE - output
        return output
    }
}

// DIO.BR - Bridge Rectifier Component Definition
// Core Rule: four diodes in one package full-wave rectify an AC input into
// DC outputs; the two AC terminals are interchangeable.

component DIO.BR(iavg::UV.AMP, vrrm::UV.VOLT, vfwd::UV.VOLT)
{
    name = "Bridge Rectifier"
    description = "Single-phase bridge rectifier, two AC inputs and two DC outputs"

    pins = [
        1 = AC1         # AC input 1 (tilde terminal)
        2 = DC\+        # Rectified positive output
        3 = AC2         # AC input 2 (tilde terminal)
        4 = DC\-        # Rectified negative output
    ]
    // Contact order follows the common DIP-4 bridge: ~ + ~ - around the
    // package.

    spec = [
        current_average = iavg
        voltage_reverse = vrrm
        forward_voltage = vfwd
        package_style = _
        rohs = _
    ]
}

// Usage Examples:
// 1. Basic diode as rectifier
// DIO(0.7V, 1000V, 1.0A).Rectifier(ac_signal, dc_output)

// 2. Schottky diode for fast rectification
// DIO.SCH(0.3V, 40V, 5.0A).Rectify(high_freq_ac, dc_output)

// 3. Zener diode as voltage regulator
// DIO.ZEN(5.1V, 0.5W, 5%).Regulate(unregulated_input, regulated_output, gnd)

// 4. TVS diode for surge protection
// DIO.TVS(12V, 15V, 500W).SurgeProtector(sensitive_circuit, gnd)

// 5. Photodiode as light sensor
// light_signal = DIO.PHOTO(0.5A/W, 1nA, 850nm).Sense(5.0V, light_output)
