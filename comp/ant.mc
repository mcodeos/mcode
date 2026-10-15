# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ANT container: the radiator family contract. Datasheet evidence (5-sheet
// sample: Johanson 2450AT / Quectel YEBT062W1AM / Hirose U.FL / Murata GNSS
// app note): every head is a full phrase (Frequency Range / Peak Gain /
// Impedance / Polarization) with no symbol face; band bounds appear only as
// start-end literals inside one Frequency column (the range face, 305);
// the wavelength column has no corpus witness and stands on the model face.
// The pad face stays on the classes (radio-class tag lives on the pad row).

recipe ANT {
    require = [
        electrical = [
            gain      = Ratio, desc: "peak / average gain in dBi (sheet heads Peak Gain (dBi typ.) / Average Gain)"
            impedance = Resistance, desc: "feed point impedance (sheet head Impedance / Nominal Impedance, 50Ω class)"
        ]
    ]
    option = [
        band = [
            frequency       = Frequency, desc: "operating frequency or band center (range sheets carry one Frequency Range column with start-end literals)"
            frequency_start = Frequency, desc: "band start (log-periodic population; single-column sheets fold this into frequency)"
            frequency_end   = Frequency, desc: "band end (log-periodic population)"
            polarization    = Words, desc: "linear / circular (sheet head Polarization - full word)"
            wavelength      = Length, desc: "design wavelength (no corpus witness in the sampled antenna sheets - model face)"
        ]
        geometry = [
            length = Length, desc: "element length (dipole population)"
            turns  = Count, desc: "helix turn count (helical population)"
        ]
    ]
}

// ANT - Generic Antenna Component Definition
// Core Rule: converts between conducted RF on its port and radiated waves;
// characterized by frequency, gain, and feed impedance.
// Note: the antenna port carries @class(radio) as the library-default signal
// class (radio is a subtype of analog: an analog-class expectation still
// accepts a radio-class line, and a radio expectation rejects an analog line).

component ANT(freq::UV.HZ, gain::UV.DB, impd::UV.OHM) :: ANT {
    name = "Antenna"
    spec = [
        frequency = freq  // [433MHz, 868MHz, 900MHz, 2.4GHz, 5.8GHz]
        gain      = gain  // [1dBi, 2dBi, 3dBi, 5dBi, 8dBi]
        impedance = impd  // [50Ω, 75Ω]
    ]

    pins = [
        1 = ANT @class(radio)  # Antenna connection, RF continuous-wave port
    ]
}

// ANT.WHIP - Whip Antenna Component Definition
// Core Rule: monopole over the surrounding ground; single RF port, no ground
// pin on the part.

component ANT.WHIP(freq::UV.HZ, gain::UV.DB, impd::UV.OHM) :: ANT {
    name = "Whip Antenna"
    spec = [
        frequency  = freq  // [433MHz, 868MHz, 900MHz, 2.4GHz]
        gain       = gain  // [1dBi, 1.5dBi, 2dBi]
        impedance  = impd  // [50Ω, 75Ω]
        wavelength = _     // [0.1m, 0.2m, 0.3m]
    ]

    pins = [
        1 = ANT @class(radio)  # Antenna connection, RF continuous-wave port
    ]
}

// ANT.PATCH - Patch Antenna Component Definition
// Core Rule: radiating element that requires a ground plane (separate GND
// pin); polarization is a design choice.

component ANT.PATCH(freq::UV.HZ, gain::UV.DB, impd::UV.OHM) :: ANT {
    name = "Patch Antenna"
    spec = [
        frequency    = freq  // [2.4GHz, 5.8GHz, 10GHz]
        gain         = gain  // [2dBi, 3dBi, 5dBi]
        impedance    = impd  // [50Ω, 75Ω]
        polarization = _     // [linear, circular]
    ]

    pins = [
        1 = ANT @class(radio)  # Antenna connection, RF continuous-wave port
        2 = GND                # Ground plane
    ]
}

// ANT.DIPOLE - Dipole Antenna Component Definition
// Core Rule: balanced two-element radiator fed at the center; single RF port
// on the part, length tied to the operating frequency.

component ANT.DIPOLE(freq::UV.HZ, gain::UV.DB, impd::UV.OHM) :: ANT {
    name = "Dipole Antenna"
    spec = [
        frequency = freq  // [433MHz, 868MHz, 900MHz, 2.4GHz]
        gain      = gain  // [2dBi, 3dBi]
        impedance = impd  // [50Ω, 75Ω]
        length    = _     // [0.1m, 0.15m, 0.2m]
    ]

    pins = [
        1 = ANT @class(radio)  # Antenna connection, RF continuous-wave port
    ]
}

// ANT.HELICAL - Helical Antenna Component Definition
// Core Rule: spiral radiator for circular polarization; requires a ground
// pin, with the number of turns as a structural parameter.

component ANT.HELICAL(freq::UV.HZ, gain::UV.DB, impd::UV.OHM) :: ANT {
    name = "Helical Antenna"
    spec = [
        frequency = freq  // [1GHz, 1.5GHz, 2.4GHz]
        gain      = gain  // [5dBi, 8dBi, 10dBi]
        impedance = impd  // [50Ω, 75Ω]
        turns     = _     // [5, 10, 15, 20]
    ]

    pins = [
        1 = ANT @class(radio)  # Antenna connection, RF continuous-wave port
        2 = GND                # Ground plane
    ]
}

// ANT.LOGPERIODIC - Log-Periodic Antenna Component Definition
// Core Rule: logarithmically periodic element structure gives near-constant
// gain across a wide band, bounded by the start and end frequencies.

component ANT.LOGPERIODIC(fstart::UV.HZ, fend::UV.HZ, gain::UV.DB, impd::UV.OHM) :: ANT {
    name = "Log Periodic Antenna"
    spec = [
        frequency_start = fstart  // [88MHz, 1MHz, 100MHz]
        frequency_end   = fend    // [108MHz, 1GHz, 2GHz]
        gain            = gain    // [3dBi, 5dBi, 8dBi]
        impedance       = impd    // [50Ω, 75Ω]
    ]

    pins = [
        1 = ANT @class(radio)  # Antenna connection, RF continuous-wave port
    ]
}

// Usage Examples:
// The antenna port is a single RF pin; wire it straight to the radio's
// antenna terminal.
// ANT(2.4GHz, 2.1dBi, 50Ω) ant1
// rf_out -> ant1.ANT
// ANT.WHIP(433MHz, 1.5dBi, 50Ω) whp1
// trx.ANT -> whp1.ANT
// ANT.PATCH(5.8GHz, 3.2dBi, 50Ω) pat1
// wifi_module.ANT -> pat1.ANT
// pat1.GND -> board_gnd
