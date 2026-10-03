# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

# Fuse components
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
// Canonical PTC face (U185 B3 ruling): the resettable overcurrent protector
// belongs to the FUSE family (function decides the family, U178 S3); the
// former RES.PTC resistor-family face is deleted. `resistance` stays as an
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

# Usage Examples:
# FUSE.SMD(2A, 24V, "1206") f1
# power_in -> f1.1
# f1.2 -> protected_rail
# FUSE.PTC(1.5A, 30V, 0.1A) selfreset
# FUSE.CERAMIC(5A, 250V, 10A, "5x20") f2
