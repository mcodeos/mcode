# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// ---------------------------------------------------------------------------------------------
// IEC 60320 Appliance Inlet Definitions
// ---------------------------------------------------------------------------------------------
// Panel-mount AC inlets. Mating cord families are C13 (for C14) and C7
// (for C8). The mains contacts bind the single-phase interface AC.1P with
// the empty form: a panel inlet is region-neutral (100-240V), so the region
// nominal (e.g. ::AC.1P(230V, 50Hz)) belongs to the consuming module, the
// same tiering as the ::DC() socket faces. The protective-earth contact
// exists only on the earthed families and is not an interface member: PE
// carries fault current only, its authority lives in the protective/earth
// role machinery, so it stays a bare role-marked pin (U217, ac-interface-
// design.md).

// IEC C14 Appliance Inlet (earthed, mates with a C13 cord set)
component IEC.C14()
{
    name = "IEC C14 Appliance Inlet"
    description = "IEC 60320 C14 panel inlet, earthed, mates with a C13 cord set"

    spec = [
        current = 10A
        voltage = 250V
        earth = "yes"
        rohs = _
    ]

    pins = [
        [1,2] = [L,N]::AC.1P(), ["Line","Neutral"]
        3 = PE @role(protective), "Protective earth"
    ]
}

// IEC C8 Appliance Inlet (2-pole, no earth, mates with a C7 cord)
component IEC.C8()
{
    name = "IEC C8 Appliance Inlet"
    description = "IEC 60320 C8 panel inlet, 2-pole without earth, mates with a C7 cord"

    spec = [
        current = 2.5A
        voltage = 250V
        earth = "no"
        rohs = _
    ]

    pins = [
        [1,2] = [L,N]::AC.1P(), ["Line","Neutral"]
    ]
}

// Usage Examples:
// 1. Earthed desktop appliance inlet
// IEC.C14()
//
// 2. Floating audio accessory inlet
// IEC.C8()
