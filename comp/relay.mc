# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// RELAY container: the coil-driven contact family contract. Datasheet
// evidence (5-sheet sample: SJ-M / Fujitsu A5W-K / Omron G3MB SSR /
// Littelfuse SSR / HCR-5): every head is a full phrase (Nominal switching
// capacity / NOMINAL COIL VOLTAGE / Contact ratings) with no symbol face -
// columns stand on the model face. Coil resistance, pick-up/drop-out
// voltages and operate times are extra corpus heads (305 candidate ledger).
// Terminal faces stay on the classes (COIL bus / SSR ctrl-load / SET-RESET).

recipe ANCH.RELAY {
    require = [
        coil = [
            coil_voltage = Voltage, desc: "nominal coil voltage (sheet heads: Nominal Voltage / NOMINAL COIL VOLTAGE - full phrase, no symbol face)"
        ]
        contact = [
            contact_rating = Current, desc: "contact switching capacity, the current face (sheet heads: Nominal switching capacity / Max. switching current / Contact ratings)"
        ]
    ]
}

// ANCH.RELAY.SSR container: the solid-state population - a control-side input
// drives the electronic output switch; no coil (sheet head INPUT RATINGS /
// OUTPUT RATINGS, full phrases).
recipe ANCH.RELAY.SSR {
    require = [
        input = [
            control_voltage = Voltage, desc: "control-side input voltage (sheet head INPUT RATINGS Rated voltage / Operating voltage range)"
        ]
        output = [
            load_voltage = Voltage, desc: "load-side voltage rating (sheet head Rated load voltage / Load voltage range)"
            load_current = Current, desc: "load-side current rating (sheet head Load current; the surge face is a separate table row)"
        ]
    ]
}

// RELAY - Generic Relay Component Definition
// Core Rule: coil-side energization (isolated barrier) magnetically switches
// the contact side between COM-NO (open at rest) and COM-NC (closed at rest).

abstract component RELAY(icont::UV.AMP, vcoil::UV.VOLT) :: ANCH.RELAY {
    name = "Relay"
    spec += [
        contact_rating = icont
        coil_voltage   = vcoil
    ]

    pins = [
        [1, 2] = COIL{VCC, GND}::DC() @id.barrier(coil)
        3      = NO @id.barrier(contact)
        4      = COM @id.barrier(contact)
        5      = NC @id.barrier(contact)
    ]
}

// RELAY.EM - Electromagnetic Relay Component Definition
// Core Rule: coil current creates the switching force; contacts spring back
// to the rest position when the coil de-energizes.

abstract component RELAY.EM(vcoil::UV.VOLT, icont::UV.AMP) :: ANCH.RELAY {
    name = "Electromagnetic Relay"
    spec += [
        coil_voltage   = vcoil
        contact_rating = icont
    ]

    pins = [
        [1, 2] = COIL{VCC, GND}::DC() @id.barrier(coil)
        3      = NO @id.barrier(contact)
        4      = COM @id.barrier(contact)
        5      = NC @id.barrier(contact)
    ]
}

// ANCH.RELAY.SSR - Solid State Relay Component Definition
// Core Rule: no moving parts and no coil — a control-side input drives an
// electronic output switch across the isolation barrier.

abstract component RELAY.SSR(vctrl::UV.VOLT, vload::UV.VOLT, iload::UV.AMP) :: ANCH.RELAY.SSR {
    name = "Solid State Relay"
    spec += [
        control_voltage = vctrl
        load_voltage    = vload
        load_current    = iload
    ]

    pins = [
        1 = CTRL.VCC @id.barrier(ctrl)
        2 = CTRL.GND @id.barrier(ctrl)
        3 = LOAD.VCC @id.barrier(load)
        4 = LOAD.GND @id.barrier(load)
    ]
}

// RELAY.REED - Reed Relay Component Definition
// Core Rule: coil-driven reed contact, NO/COM only (no normally-closed
// contact); low coil power, fast switching.

abstract component RELAY.REED(vcoil::UV.VOLT, icont::UV.AMP) :: ANCH.RELAY {
    name = "Reed Relay"
    spec += [
        coil_voltage   = vcoil
        contact_rating = icont
    ]

    pins = [
        [1, 2] = COIL{VCC, GND}::DC() @id.barrier(coil)
        3      = NO @id.barrier(contact)
        4      = COM @id.barrier(contact)
    ]
}

// RELAY.LATCH - Latching Relay Component Definition
// Core Rule: two coils (set and reset); the contact state persists after the
// pulse ends instead of springing back.

abstract component RELAY.LATCH(vcoil::UV.VOLT, icont::UV.AMP) :: ANCH.RELAY {
    name = "Latching Relay"
    spec += [
        coil_voltage   = vcoil
        contact_rating = icont
    ]

    pins = [
        1 = SET.VCC @id.barrier(set)
        2 = SET.GND @id.barrier(set)
        3 = RESET.VCC @id.barrier(reset)
        4 = RESET.GND @id.barrier(reset)
        5 = NO @id.barrier(contact)
        6 = COM @id.barrier(contact)
        7 = NC @id.barrier(contact)
    ]
}

// Usage Examples:
// RELAY.EM(12V, 2A) k1        // 12V coil, 2A contacts
// ANCH.RELAY.SSR(3.3V, 24V, 4A) k2 // solid state, logic-level control
// RELAY.LATCH(5V, 1A) k3      // two-coil latching
// RELAY.REED(5V, 0.5A) k4
