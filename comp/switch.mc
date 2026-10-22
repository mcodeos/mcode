# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// SWITCH container: the mechanical-switch family contract. Datasheet
// evidence (3-sheet sample: Omron B3F tact / GANGYUAN tact / NKK GW slide):
// no pin-count or pitch column exists in the corpus (part numbers carry the
// variants); contact-form words (SPST-NO, Angle of Throw) witness the style
// face; the electrical ratings heads (Rating (resistive load), Contact
// resistance, Dielectric Strength) are extra corpus heads (305 candidate
// ledger). The five no-parameter classes adopt this container as-is (option
// faces only); the terminal faces stay on the classes.

recipe ANCH.SWITCH {
    option = [
        build = [
            style = Words, desc: "contact form / actuator style (sheet heads: Contact form SPST-NO / Angle of Throw)"
            mount = Words, desc: "mounting class (no corpus column witness - model face)"
        ]
    ]
}

// ANCH.SWITCH.DIP container: the DIP-switch population - the total pin count is
// the require face (the formal), pitch / style / mount are BOM faces. No
// DIP-switch component sheet in the sampled corpus - columns stand on the
// model face.
recipe ANCH.SWITCH.DIP {
    require = [
        build = [
            pin_count = Count, desc: "total pin count (the formal; switch k joins pin k with pin pin_count+1-k)"
        ]
    ]
    option = [
        build = [
            pitch = Length, desc: "pin pitch (2.54mm class)"
            style = Words, desc: "slide / rotary actuation"
            mount = Words, desc: "through-hole / surface-mount"
        ]
    ]
}

// SWITCH - Basic SPST Switch Component Definition
// Core Rule: user-actuated open/close between COM and NO; no closed-at-rest
// contact.

abstract component SWITCH :: ANCH.SWITCH {
    name        = "Basic Switch"
    description = "on/off switch with two terminals"

    pins = [
        1 = COM, "Common terminal"
        2 = NO, "Normally Open terminal"
    ]
}

// SWITCH.DOUBLE - Double Pole Switch Component Definition
// Core Rule: one actuation switches two independent poles (COM1-NO1,
// COM2-NO2) together.

abstract component SWITCH.DOUBLE :: ANCH.SWITCH {
    name        = "Double Pole Switch"
    description = "Double pole switch with four terminals"

    pins = [
        1 = COM1, "Common terminal 1"
        2 = NO1, "Normally Open terminal 1"
        3 = COM2, "Common terminal 2"
        4 = NO2, "Normally Open terminal 2"
    ]
}

// SWITCH.TOGGLE - Toggle (SPDT) Switch Component Definition
// Core Rule: the actuator selects which of NC / NO is connected to COM and
// stays in that position without power.

abstract component SWITCH.TOGGLE :: ANCH.SWITCH {
    name        = "Toggle Switch"
    description = "Toggle switch with on/off positions"

    pins = [
        1 = COM, "Common terminal"
        2 = NO, "Normally Open terminal"
        3 = NC, "Normally Closed terminal"
    ]
}

// SWITCH.MOM - Momentary Switch Component Definition
// Core Rule: contact closes only while actuated and opens on release.

abstract component SWITCH.MOM :: ANCH.SWITCH {
    name        = "Momentary Switch"
    description = "Momentary push button switch"

    pins = [
        1 = COM, "Common terminal"
        2 = NO, "Normally Open terminal"
    ]
}

// SWITCH.BUTTON - Momentary Push Button Component Definition
// Core Rule: momentary COM-NO closure while pressed (tact-switch style).

abstract component SWITCH.BUTTON :: ANCH.SWITCH {
    name        = "Momentary Push Button"
    description = "Momentary push button (tact switch) with common and normally-open terminals"

    pins = [
        1 = COM, "Common terminal"
        2 = NO, "Normally Open terminal"
    ]
}

// ANCH.SWITCH.DIP - DIP Switch Component Definition
// Core Rule: independent SPST slides; the formal is the total pin count.
// Note: physical contact map — switch k joins pin k with pin (pin_count+1-k),
// i.e. an 8-pin part shorts 1-8, 2-7, 3-6, 4-5 when closed.

abstract component SWITCH.DIP(pincnt::INT) :: ANCH.SWITCH.DIP {
    name        = "DIP Switch"
    description = "DIP switch with independent SPST slides (pin count on the spec face)"
    spec        = [
        pin_count = pincnt
        pitch     = _  // [2.54mm]
        style     = _  // [slide, rotary]
        mount     = _  // [through-hole, surface-mount]
    ]

    pins = [
        1:pin_count = 1:pin_count
    ]
}

// Usage Examples:
// SWITCH sw1
// vcc -> sw1.COM
// sw1.NO -> switched_signal
// SWITCH.BUTTON btn1
// SWITCH.TOGGLE tog1
// SWITCH.MOM mom1
// ANCH.SWITCH.DIP(8) addr_sel1          // 8 pins = 4 positions
// addr_sel1.1 -> gnd
// addr_sel1.8 -> i2c_addr0
