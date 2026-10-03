# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// XFR - Generic Transformer Component Definition
// Core Rule: galvanically isolated windings coupled magnetically — voltage
// scales with the turns ratio, power transfers at the rated capacity.

component XFR(vpri::UV.VOLT, vsec::UV.VOLT, prated::UV.WATT)
{
    name = "Transformer"
    spec = [
        primary_voltage = vpri // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec // [5V, 9V, 12V, 24V]
        power_rated = prated // [1W, 5W, 10W, 50W, 100W]
    ]
    pins = [
        1 = PRIMARY\+ @barrier(pri)
        2 = PRIMARY\- @barrier(pri)
        3 = SECONDARY\+ @barrier(sec)
        4 = SECONDARY\- @barrier(sec)
    ]
}

// XFR.POWER - Power Transformer Component Definition
// Core Rule: mains-frequency power transfer — the core is rated for a
// specified line frequency; running below it drives the core into
// saturation.

component XFR.POWER(vpri::UV.VOLT, vsec::UV.VOLT, prated::UV.WATT, freq::UV.HZ)
{
    name = "Power Transformer"
    spec = [
        primary_voltage = vpri // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec // [5V, 9V, 12V, 24V]
        power_rated = prated // [1W, 5W, 10W, 50W, 100W]
        frequency = freq // [50Hz, 60Hz]
    ]
    pins = [
        1 = PRIMARY\+ @barrier(pri)
        2 = PRIMARY\- @barrier(pri)
        3 = SECONDARY\+ @barrier(sec)
        4 = SECONDARY\- @barrier(sec)
    ]
}

// XFR.AUDIO - Audio Transformer Component Definition
// Core Rule: impedance-matching transformer — primary and secondary
// impedances are the design quantities, with a specified flat frequency
// response band.

component XFR.AUDIO(zpri::UV.OHM, zsec::UV.OHM, prated::UV.WATT, fresp::STRING)
{
    name = "Audio Transformer"
    spec = [
        primary_impedance = zpri // [8Ω, 50Ω, 600Ω]
        secondary_impedance = zsec // [8Ω, 50Ω, 600Ω]
        power_rated = prated // [0.1W, 0.5W, 1W, 5W]
        frequency_response = fresp // [20Hz-20kHz, 50Hz-15kHz]
    ]
    pins = [
        1 = PRIMARY\+ @barrier(pri)
        2 = PRIMARY\- @barrier(pri)
        3 = SECONDARY\+ @barrier(sec)
        4 = SECONDARY\- @barrier(sec)
    ]
}

// XFR.ISO - Isolation Transformer Component Definition
// Core Rule: 1:1-class windings whose purpose is the isolation barrier
// itself, rated to a specified isolation voltage.

component XFR.ISO(vpri::UV.VOLT, vsec::UV.VOLT, viso::UV.VOLT, prated::UV.WATT)
{
    name = "Isolation Transformer"
    spec = [
        primary_voltage = vpri // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec // [12V, 24V, 120V, 240V]
        isolation_voltage = viso // [500V, 1000V, 2000V, 5000V]
        power_rated = prated // [1W, 5W, 10W, 50W]
    ]
    pins = [
        1 = PRIMARY\+ @barrier(pri)
        2 = PRIMARY\- @barrier(pri)
        3 = SECONDARY\+ @barrier(sec)
        4 = SECONDARY\- @barrier(sec)
    ]
}

// XFR.CT - Center-Tapped Transformer Component Definition
// Core Rule: secondary winding carries a center tap, giving two half
// windings for split-supply or full-wave rectifier use.

component XFR.CT(vpri::UV.VOLT, vsec::UV.VOLT, prated::UV.WATT)
{
    name = "Center Tapped Transformer"
    spec = [
        primary_voltage = vpri // [12V, 24V, 120V, 240V]
        secondary_voltage = vsec // [9V, 12V, 24V, 36V]
        power_rated = prated // [1W, 5W, 10W, 50W]
    ]
    pins = [
        1 = PRIMARY\+ @barrier(pri)
        2 = PRIMARY\- @barrier(pri)
        3 = SECONDARY\+ @barrier(sec)
        4 = SECONDARY.CT @barrier(sec)
        5 = SECONDARY\- @barrier(sec)
    ]
}

// Usage Examples:
// XFR.POWER(230V, 12V, 10W, 50Hz) t1
// XFR.ISO(120V, 120V, 4kV, 5W) t2
// XFR.AUDIO(600Ω, 8Ω, 2W, "20Hz~20kHz") t3
// XFR.CT(230V, 6V, 3W) t4
