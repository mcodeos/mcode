# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// AC.1P - Single-Phase AC Mains Interface Standard Definition
// Core Rule: AC mains over one live conductor (L) and one neutral return
//            (N). The neutral is nominally at earth potential but is a
//            current-carrying member; the protective-earth conductor is
//            never a member — an earthed face binds this interface and
//            carries PE as its own pin tagged @role(protective).
//            Role-less: direction rides the adopting terminal's direction
//            word (psrc source / psnk sink), and region nominals belong to
//            the consumer — connector faces bind the empty form
//            ::AC.1P(), module power faces carry the nominal
//            (::AC.1P(230V, 50Hz)).
// Note: the family name AC.SPLIT (L1, L2, N) is reserved.

interface AC.1P(volt::UV.VOLT, freq::UV.HZ) // Single-phase AC mains interface
{
    topology = "point to point"
    mode = ["unidirectional"]
    voltage = volt
    frequency = freq

    pins = [
        1 = L, "Line (live conductor)"
        2 = N, "Neutral (return conductor)"
    ]
}

// AC.3P - Three-Phase AC Mains Interface (4-wire Y) Standard Definition
// Core Rule: Three live phase conductors (L1, L2, L3) over one shared
//            neutral return (N), the four-wire Y face; phase order is the
//            member order. The neutral is nominally at earth potential but
//            is a current-carrying member; PE is not — an earthed face
//            binds this interface and carries PE as its own pin tagged
//            @role(protective). Role-less, same law as AC.1P.

interface AC.3P(volt::UV.VOLT, freq::UV.HZ) // Three-phase AC mains interface (4-wire Y)
{
    topology = "point to point"
    mode = ["unidirectional"]
    voltage = volt
    frequency = freq

    pins = [
        1 = L1, "Phase 1 (live conductor)"
        2 = L2, "Phase 2 (live conductor)"
        3 = L3, "Phase 3 (live conductor)"
        4 = N, "Neutral (return conductor)"
    ]
}

// AC.3P3W - Three-Phase AC Mains Interface (3-wire delta) Standard Definition
// Core Rule: Three live phase conductors (L1, L2, L3) and no neutral
//            member, the three-wire delta face: the return runs
//            phase-to-phase, so no member is the return conductor and any
//            two phases close a line-voltage loop. The name states the
//            wire count, not the winding — "3W" reads exactly as "no
//            neutral member". PE is not a member — an earthed face binds
//            this interface and carries PE as its own pin tagged
//            @role(protective). Role-less, same law as AC.1P.

interface AC.3P3W(volt::UV.VOLT, freq::UV.HZ) // Three-phase AC mains interface (3-wire delta)
{
    topology = "point to point"
    mode = ["unidirectional"]
    voltage = volt
    frequency = freq

    pins = [
        1 = L1, "Phase 1 (live conductor)"
        2 = L2, "Phase 2 (live conductor)"
        3 = L3, "Phase 3 (live conductor)"
    ]
}
