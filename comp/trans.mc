# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// TRANS - Generic Bipolar Junction Transistor (BJT) Component Definition
// Core Rule: current-controlled device — a small base current drives a
// collector current larger by the current gain hFE.

component TRANS(vce::UV.VOLT, ic::UV.AMP, hfe::INT)
{
    name = "Bipolar Junction Transistor"
    description = "General bipolar junction transistor"
    spec = [
        collector_emitter_voltage = vce
        collector_current = ic
        current_gain = hfe
    ]

    pins = [
        in 1 = BASE     , "Base terminal"
        in 2 = COLLECTOR, "Collector terminal"
        out 3 = EMITTER , "Emitter terminal"
    ]
}

// TRANS.NPN - NPN Transistor Component Definition
// Core Rule: conducts when the base is driven above the emitter (base current
// flows into the base; collector sits at the higher potential).

component TRANS.NPN(vce::UV.VOLT, ic::UV.AMP, hfe::INT)
{
    name = "NPN Transistor"
    description = "NPN bipolar junction transistor"
    spec = [
        collector_emitter_voltage = vce
        collector_current = ic
        current_gain = hfe
    ]

    pins = [
        in 1 = BASE     , "Base terminal"
        in 2 = COLLECTOR, "Collector terminal"
        out 3 = EMITTER , "Emitter terminal"
    ]
}

// TRANS.PNP - PNP Transistor Component Definition
// Core Rule: conducts when the base is pulled below the emitter (base current
// flows out of the base; emitter sits at the higher potential).

component TRANS.PNP(vce::UV.VOLT, ic::UV.AMP, hfe::INT)
{
    name = "PNP Transistor"
    description = "PNP bipolar junction transistor"
    spec = [
        collector_emitter_voltage = vce
        collector_current = ic
        current_gain = hfe
    ]

    pins = [
        in 1 = BASE     , "Base terminal"
        in 2 = EMITTER  , "Emitter terminal"
        out 3 = COLLECTOR, "Collector terminal"
    ]
}

// TRANS.DARLINGTON - Darlington Pair Transistor Component Definition
// Core Rule: two BJT stages cascaded on one die — current gain is the product
// of the two stages; doubled base-emitter voltage drop and higher saturation
// voltage.

component TRANS.DARLINGTON(vce::UV.VOLT, ic::UV.AMP, hfe::INT)
{
    name = "Darlington Transistor"
    description = "Darlington pair transistor"
    spec = [
        collector_emitter_voltage = vce
        collector_current = ic
        current_gain = hfe
    ]

    pins = [
        in 1 = BASE     , "Base terminal"
        in 2 = COLLECTOR, "Collector terminal"
        out 3 = EMITTER , "Emitter terminal"
    ]
}

// TRANS.IGBT - Insulated Gate Bipolar Transistor Component Definition
// Core Rule: MOSFET-style insulated gate controls a bipolar conduction path —
// voltage-driven input with the low saturation voltage of a bipolar device.

component TRANS.IGBT(vce::UV.VOLT, ic::UV.AMP)
{
    name = "IGBT"
    description = "Insulated Gate Bipolar Transistor"
    spec = [
        collector_emitter_voltage = vce
        collector_current = ic
    ]

    pins = [
        in 1 = GATE     , "Gate terminal"
        in 2 = COLLECTOR, "Collector terminal"
        out 3 = EMITTER , "Emitter terminal"
    ]
}

// TRANS.SCR - Silicon Controlled Rectifier Component Definition
// Core Rule: latches on when gate current is injected while forward biased and
// stays conducting until the anode current falls below the holding level;
// blocks in reverse.

component TRANS.SCR(vrrm::UV.VOLT, it::UV.AMP)
{
    name = "SCR"
    description = "Silicon Controlled Rectifier"
    spec = [
        reverse_repetitive_voltage = vrrm
        forward_current = it
    ]

    pins = [
        in 1 = GATE     , "Gate terminal"
        in 2 = ANODE    , "Anode terminal"
        out 3 = CATHODE , "Cathode terminal"
    ]
}

// TRANS.TRIAC - TRIAC Component Definition
// Core Rule: bidirectional latching switch — gate triggering in either
// polarity turns on conduction in either direction until the current drops
// below the holding level.

component TRANS.TRIAC(vdrm::UV.VOLT, it::UV.AMP)
{
    name = "TRIAC"
    description = "Triode for Alternating Current"
    spec = [
        repetitive_peak_off_voltage = vdrm
        forward_current = it
    ]

    pins = [
        in 1 = GATE     , "Gate terminal"
        2 = T1          , "Main terminal 1"
        3 = T2          , "Main terminal 2"
    ]
}

// Usage Examples:
// TRANS.NPN(40V, 200mA, 100) q1
// TRANS.DARLINGTON(100V, 8A, 1000) q3
// TRANS.IGBT(600V, 20A) q4
// TRANS.SCR(800V, 12A) scr1
