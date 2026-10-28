# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// XFR container: the coupled-windings family contract. Datasheet evidence is
// thin (2-sheet sample: Coilcraft WBC planar / EPC planar overview - both
// wideband RF; no 50/60 Hz power-transformer sheet in the corpus): winding
// voltage columns have no witness (RF sheets rate by ratio and current),
// isolation appears as interwinding-isolation / AC-isolation-test heads,
// and the audio faces appear as Bandwidth / Insertion loss heads. Columns
// stand on the model face with the corpus shape recorded in the descs.

recipe ANCH.XFR {
    require = [
        windings = [
            primary_voltage   = Voltage, desc: "primary winding voltage rating (RF/planar sheets rate by turns ratio and current instead)"
            secondary_voltage = Voltage, desc: "secondary winding voltage rating"
            power_rated       = Power, desc: "power transfer rating (witnessed only as a features bullet in the sampled RF sheets)"
        ]
    ]
    option = [
        windings = [
            frequency         = Frequency, desc: "rated line / operating frequency (power population)"
            isolation_voltage = Voltage, desc: "interwinding isolation rating (sheet heads: interwinding isolation / AC isolation test voltage)"
        ]
        audio = [
            primary_impedance   = Resistance, desc: "primary impedance (audio population; planar RF sheets state winding inductance and DCR instead)"
            secondary_impedance = Resistance, desc: "secondary impedance (audio population)"
            frequency_response  = Words, desc: "flat response band (sheet heads: Bandwidth / Insertion loss)"
        ]
    ]
}

// ANCH.XFR.AUDIO container: the impedance-matching population - the winding
// impedances and the flat band are the design quantities.
recipe ANCH.XFR.AUDIO {
    require = [
        windings = [
            primary_impedance   = Resistance, desc: "primary impedance (8Ω / 50Ω / 600Ω classes)"
            secondary_impedance = Resistance, desc: "secondary impedance"
            power_rated         = Power, desc: "power transfer rating"
            frequency_response  = Words, desc: "flat response band (sheet heads: Bandwidth / Insertion loss)"
        ]
    ]
}

// XFR - Generic Transformer Component Definition
// Core Rule: galvanically isolated windings coupled magnetically — voltage
// scales with the turns ratio, power transfers at the rated capacity.

general component XFR(vpri::UV.VOLT, vsec::UV.VOLT, prated::UV.WATT) :: ANCH.XFR {
    name = "Transformer"
    spec += [
        primary_voltage   = vpri    // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec    // [5V, 9V, 12V, 24V]
        power_rated       = prated  // [1W, 5W, 10W, 50W, 100W]
    ]

    pins = [
        1 = PRIMARY\+ @id.barrier(pri)
        2 = PRIMARY\- @id.barrier(pri)
        3 = SECONDARY\+ @id.barrier(sec)
        4 = SECONDARY\- @id.barrier(sec)
    ]
}

// XFR.POWER - Power Transformer Component Definition
// Core Rule: mains-frequency power transfer — the core is rated for a
// specified line frequency; running below it drives the core into
// saturation.

general component XFR.POWER(vpri::UV.VOLT, vsec::UV.VOLT, prated::UV.WATT, freq::UV.HZ) :: ANCH.XFR {
    name = "Power Transformer"
    spec += [
        primary_voltage   = vpri    // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec    // [5V, 9V, 12V, 24V]
        power_rated       = prated  // [1W, 5W, 10W, 50W, 100W]
        frequency         = freq    // [50Hz, 60Hz]
    ]

    pins = [
        1 = PRIMARY\+ @id.barrier(pri)
        2 = PRIMARY\- @id.barrier(pri)
        3 = SECONDARY\+ @id.barrier(sec)
        4 = SECONDARY\- @id.barrier(sec)
    ]
}

// ANCH.XFR.AUDIO - Audio Transformer Component Definition
// Core Rule: impedance-matching transformer — primary and secondary
// impedances are the design quantities, with a specified flat frequency
// response band.

general component XFR.AUDIO(zpri::UV.OHM, zsec::UV.OHM, prated::UV.WATT, fresp::STRING) :: ANCH.XFR.AUDIO {
    name = "Audio Transformer"
    spec += [
        primary_impedance   = zpri    // [8Ω, 50Ω, 600Ω]
        secondary_impedance = zsec    // [8Ω, 50Ω, 600Ω]
        power_rated         = prated  // [0.1W, 0.5W, 1W, 5W]
        frequency_response  = fresp   // [20Hz-20kHz, 50Hz-15kHz]
    ]

    pins = [
        1 = PRIMARY\+ @id.barrier(pri)
        2 = PRIMARY\- @id.barrier(pri)
        3 = SECONDARY\+ @id.barrier(sec)
        4 = SECONDARY\- @id.barrier(sec)
    ]
}

// XFR.ISO - Isolation Transformer Component Definition
// Core Rule: 1:1-class windings whose purpose is the isolation barrier
// itself, rated to a specified isolation voltage.

general component XFR.ISO(vpri::UV.VOLT, vsec::UV.VOLT, viso::UV.VOLT, prated::UV.WATT) :: ANCH.XFR {
    name = "Isolation Transformer"
    spec += [
        primary_voltage   = vpri    // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec    // [12V, 24V, 120V, 240V]
        isolation_voltage = viso    // [500V, 1000V, 2000V, 5000V]
        power_rated       = prated  // [1W, 5W, 10W, 50W]
    ]

    pins = [
        1 = PRIMARY\+ @id.barrier(pri)
        2 = PRIMARY\- @id.barrier(pri)
        3 = SECONDARY\+ @id.barrier(sec)
        4 = SECONDARY\- @id.barrier(sec)
    ]
}

// XFR.CT - Center-Tapped Transformer Component Definition
// Core Rule: secondary winding carries a center tap, giving two half
// windings for split-supply or full-wave rectifier use.

general component XFR.CT(vpri::UV.VOLT, vsec::UV.VOLT, prated::UV.WATT) :: ANCH.XFR {
    name = "Center Tapped Transformer"
    spec += [
        primary_voltage   = vpri    // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec    // [9V, 12V, 24V, 36V]
        power_rated       = prated  // [1W, 5W, 10W, 50W]
    ]

    pins = [
        1 = PRIMARY\+ @id.barrier(pri)
        2 = PRIMARY\- @id.barrier(pri)
        3 = SECONDARY\+ @id.barrier(sec)
        4 = SECONDARY.CT @id.barrier(sec)
        5 = SECONDARY\- @id.barrier(sec)
    ]
}

// Usage Examples:
// XFR.POWER(230V, 12V, 10W, 50Hz) t1
// XFR.ISO(120V, 120V, 4kV, 5W) t2
// ANCH.XFR.AUDIO(600Ω, 8Ω, 2W, "20Hz~20kHz") t3
// XFR.CT(230V, 6V, 3W) t4
