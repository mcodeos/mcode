# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// RELAY - Generic Relay Component Definition
// Core Rule: coil-side energization (isolated barrier) magnetically switches
// the contact side between COM-NO (open at rest) and COM-NC (closed at rest).

component RELAY(icont::UV.AMP, vcoil::UV.VOLT)
{
    name = "Relay"
    spec = [
        contact_rating = icont
        coil_voltage = vcoil
    ]
    pins = [
        [1,2] = COIL{VCC,GND}::DC() @barrier(coil)
        3 = NO @barrier(contact)
        4 = COM @barrier(contact)
        5 = NC @barrier(contact)
    ]
}

// RELAY.EM - Electromagnetic Relay Component Definition
// Core Rule: coil current creates the switching force; contacts spring back
// to the rest position when the coil de-energizes.

component RELAY.EM(vcoil::UV.VOLT, icont::UV.AMP)
{
    name = "Electromagnetic Relay"
    spec = [
        coil_voltage = vcoil
        contact_rating = icont
    ]
    pins = [
        [1,2] = COIL{VCC,GND}::DC() @barrier(coil)
        3 = NO @barrier(contact)
        4 = COM @barrier(contact)
        5 = NC @barrier(contact)
    ]
}

// RELAY.SSR - Solid State Relay Component Definition
// Core Rule: no moving parts and no coil — a control-side input drives an
// electronic output switch across the isolation barrier.

component RELAY.SSR(vctrl::UV.VOLT, vload::UV.VOLT, iload::UV.AMP)
{
    name = "Solid State Relay"
    spec = [
        control_voltage = vctrl
        load_voltage = vload
        load_current = iload
    ]
    pins = [
        1 = CTRL.VCC @barrier(ctrl)
        2 = CTRL.GND @barrier(ctrl)
        3 = LOAD.VCC @barrier(load)
        4 = LOAD.GND @barrier(load)
    ]
}

// RELAY.REED - Reed Relay Component Definition
// Core Rule: coil-driven reed contact, NO/COM only (no normally-closed
// contact); low coil power, fast switching.

component RELAY.REED(vcoil::UV.VOLT, icont::UV.AMP)
{
    name = "Reed Relay"
    spec = [
        coil_voltage = vcoil
        contact_rating = icont
    ]
    pins = [
        [1,2] = COIL{VCC,GND}::DC() @barrier(coil)
        3 = NO @barrier(contact)
        4 = COM @barrier(contact)
    ]
}

// RELAY.LATCH - Latching Relay Component Definition
// Core Rule: two coils (set and reset); the contact state persists after the
// pulse ends instead of springing back.

component RELAY.LATCH(vcoil::UV.VOLT, icont::UV.AMP)
{
    name = "Latching Relay"
    spec = [
        coil_voltage = vcoil
        contact_rating = icont
    ]
    pins = [
        1 = SET.VCC @barrier(set)
        2 = SET.GND @barrier(set)
        3 = RESET.VCC @barrier(reset)
        4 = RESET.GND @barrier(reset)
        5 = NO @barrier(contact)
        6 = COM @barrier(contact)
        7 = NC @barrier(contact)
    ]
}

// Usage Examples:
// RELAY.EM(12V, 2A) k1        // 12V coil, 2A contacts
// RELAY.SSR(3.3V, 24V, 4A) k2 // solid state, logic-level control
// RELAY.LATCH(5V, 1A) k3      // two-coil latching
// RELAY.REED(5V, 0.5A) k4
