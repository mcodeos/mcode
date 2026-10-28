# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// FUSE container: the one-shot overcurrent-protector contract. Datasheet
// evidence (3-sheet sample: Littelfuse 877 / SIBA / Hollyfuse): every head
// is a full phrase (Ampere Rating / Voltage Rating / Interrupting Rating /
// Nominal Cold Resistance) with no symbol face; speed rating lives in
// time-current tables and class words (aM, time-lag), not symbols.

recipe ANCH.FUSE {
    require = [
        rating = [
            rated_current = Current, desc: "nominal current rating (sheet head Ampere Rating / Bemessungsstrom Rated Current)"
            voltage       = Voltage, desc: "voltage rating (sheet head Voltage Rating)"
        ]
    ]
    option = [
        rating = [
            speed_rating      = Words, desc: "time-lag / quick-acting class (sheets carry time-current tables and operation-class words; no symbol face)"
            breaking_capacity = Current, desc: "interrupting rating at the stated voltage (sheet head Interrupting Rating / Breaking Capacity)"
            resistance        = Resistance, desc: "nominal cold resistance (sheet head Nominal Cold Resistance; some sheets state voltage drop instead)"
            rohs              = Flag, desc: "RoHS conformity"
        ]
    ]
}

// ANCH.FUSE.PTC container: the resettable PPTC population - hold/trip current
// faces replace the one-shot melting face. No resettable-fuse datasheet in
// the sampled corpus (prose mentions only), so the columns stand on the
// model face.
recipe ANCH.FUSE.PTC {
    require = [
        rating = [
            rated_current = Current, desc: "hold current (the current the PPTC carries without tripping)"
            voltage       = Voltage, desc: "voltage rating"
            trip_current  = Current, desc: "trip current (the fault current that flips the element to the high-resistance state)"
        ]
    ]
    option = [
        rating = [
            resistance = Resistance, desc: "cold resistance BOM slot"
            rohs       = Flag, desc: "RoHS conformity"
        ]
    ]
}

// FUSE - One-Shot Overcurrent Protector Component Definition
// Core Rule: an overcurrent event melts the element and opens the circuit
// permanently; the part must then be replaced.

general component FUSE(irated::UV.AMP, vrated::UV.VOLT, spd::STRING) :: ANCH.FUSE {
    name = "Fuse"
    spec += [
        rated_current = irated  // [0.1A, 0.5A, 1A, 2A, 5A, 10A, 20A]
        voltage       = vrated  // [5V, 12V, 24V, 120V, 240V]
        speed_rating  = spd     // [fast, slow, medium]
    ]

    pins = [
        1 = 1
        2 = 2
    ]
}

// FUSE.SMD - Surface Mount Fuse Component Definition
// Core Rule: one-shot overcurrent opening in a surface-mount two-terminal body.

general component FUSE.SMD(irated::UV.AMP, vrated::UV.VOLT, spd::STRING) :: ANCH.FUSE {
    name = "Surface Mount Fuse"
    spec += [
        rated_current = irated  // [0.1A, 0.5A, 1A, 2A, 5A]
        voltage       = vrated  // [5V, 12V, 24V, 120V]
        speed_rating  = spd     // [fast, slow, medium]
    ]

    pins = [
        1 = 1
        2 = 2
    ]
}

// FUSE.CERAMIC - Ceramic Body Fuse Component Definition
// Core Rule: one-shot overcurrent opening in a ceramic body rated for a
// specified breaking capacity (maximum fault current it can safely interrupt).

general component FUSE.CERAMIC(irated::UV.AMP, vrated::UV.VOLT, ibreak::UV.AMP, spd::STRING) :: ANCH.FUSE {
    name = "Ceramic Fuse"
    spec += [
        rated_current     = irated
        voltage           = vrated
        breaking_capacity = ibreak
        speed_rating      = spd  // [fast, slow, medium]
    ]

    pins = [
        1 = 1
        2 = 2
    ]
}

// FUSE.GLASS - Glass Body Fuse Component Definition
// Core Rule: one-shot overcurrent opening in a glass body (lower breaking
// capacity than ceramic at the same size).

general component FUSE.GLASS(irated::UV.AMP, vrated::UV.VOLT, spd::STRING) :: ANCH.FUSE {
    name = "Glass Fuse"
    spec += [
        rated_current = irated  // [0.5A, 1A, 2A, 5A, 10A]
        voltage       = vrated  // [12V, 24V, 120V, 240V]
        speed_rating  = spd     // [fast, slow, medium]
    ]

    pins = [
        1 = 1
        2 = 2
    ]
}

// ANCH.FUSE.PTC - Resettable PPTC Overcurrent Protector Component Definition
// Core Rule: the resettable overcurrent protector belongs to the FUSE family
// (function decides the family, not the implementation). Tripping raises its
// resistance by orders of magnitude and the trip state persists while the
// fault current flows; it resets on cooling. `resistance` stays as an
// unassigned BOM slot for the cold resistance.

general component FUSE.PTC(irated::UV.AMP, vrated::UV.VOLT, itrip::UV.AMP) :: ANCH.FUSE.PTC {
    name        = "PTC Fuse"
    description = "Resettable PPTC overcurrent protection device"
    spec        = [
        rated_current = irated
        voltage       = vrated
        trip_current  = itrip
        resistance    = _
        rohs          = _
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
// ANCH.FUSE.PTC(1.5A, 30V, 0.1A) selfreset
// FUSE.CERAMIC(5A, 250V, 10A, "5x20") f2
