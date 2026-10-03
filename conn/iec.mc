# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// IEC.C14 - Panel-mount earthed AC appliance inlet, mates with a C13 cord set Component Definition
// Core Rule: The mains contacts bind the single-phase AC.1P interface with the
// empty form: a panel inlet is region-neutral (100-250V), so the region
// nominal (e.g. ::AC.1P(230V, 50Hz)) belongs to the consuming module, the same
// tiering as the ::DC() socket faces. The protective-earth contact is not an
// interface member: PE carries fault current only, its authority lives in the
// protective/earth role machinery, so it stays a bare role-marked pin.

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

// IEC.C8 - Panel-mount 2-pole unearthed AC appliance inlet, mates with a C7 cord Component Definition
// Core Rule: The mains contacts bind the single-phase AC.1P interface with the
// empty form, same tiering as IEC.C14; no protective-earth contact exists.

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
