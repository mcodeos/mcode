# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// FUSE - One-Shot Overcurrent Protector Component Definition
// Core Rule: an overcurrent event melts the element and opens the circuit
// permanently; the part must then be replaced.

component FUSE(irated::UV.AMP, vrated::UV.VOLT, spd::STRING)
{
    name = "Fuse"
    spec = [
        rated_current = irated // [0.1A, 0.5A, 1A, 2A, 5A, 10A, 20A]
        voltage = vrated // [5V, 12V, 24V, 120V, 240V]
        speed_rating = spd // [fast, slow, medium]
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}

// FUSE.SMD - Surface Mount Fuse Component Definition
// Core Rule: one-shot overcurrent opening in a surface-mount two-terminal body.

component FUSE.SMD(irated::UV.AMP, vrated::UV.VOLT, spd::STRING)
{
    name = "Surface Mount Fuse"
    spec = [
        rated_current = irated // [0.1A, 0.5A, 1A, 2A, 5A]
        voltage = vrated // [5V, 12V, 24V, 120V]
        speed_rating = spd // [fast, slow, medium]
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}

// FUSE.CERAMIC - Ceramic Body Fuse Component Definition
// Core Rule: one-shot overcurrent opening in a ceramic body rated for a
// specified breaking capacity (maximum fault current it can safely interrupt).

component FUSE.CERAMIC(irated::UV.AMP, vrated::UV.VOLT, ibreak::UV.AMP, spd::STRING)
{
    name = "Ceramic Fuse"
    spec = [
        rated_current = irated
        voltage = vrated
        breaking_capacity = ibreak
        speed_rating = spd // [fast, slow, medium]
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}

// FUSE.GLASS - Glass Body Fuse Component Definition
// Core Rule: one-shot overcurrent opening in a glass body (lower breaking
// capacity than ceramic at the same size).

component FUSE.GLASS(irated::UV.AMP, vrated::UV.VOLT, spd::STRING)
{
    name = "Glass Fuse"
    spec = [
        rated_current = irated // [0.5A, 1A, 2A, 5A, 10A]
        voltage = vrated // [12V, 24V, 120V, 240V]
        speed_rating = spd // [fast, slow, medium]
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}

// FUSE.PTC - Resettable PPTC Overcurrent Protector Component Definition
// Core Rule: the resettable overcurrent protector belongs to the FUSE family
// (function decides the family, not the implementation). Tripping raises its
// resistance by orders of magnitude and the trip state persists while the
// fault current flows; it resets on cooling. `resistance` stays as an
// unassigned BOM slot for the cold resistance.

component FUSE.PTC(irated::UV.AMP, vrated::UV.VOLT, itrip::UV.AMP)
{
    name = "PTC Fuse"
    description = "Resettable PPTC overcurrent protection device"
    spec = [
        rated_current = irated
        voltage = vrated
        trip_current = itrip
        resistance = _
        rohs = _
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}

// Usage Examples:
// FUSE.SMD(2A, 24V, "1206") f1
// power_in -> f1.1
// f1.2 -> protected_rail
// FUSE.PTC(1.5A, 30V, 0.1A) selfreset
// FUSE.CERAMIC(5A, 250V, 10A, "5x20") f2
