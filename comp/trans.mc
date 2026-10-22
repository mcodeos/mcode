# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

use ../ifs/dio

// Transistor family book. One recipe container per model population; a
// class adopts the container it implements and exposes that container's
// terminal face. The NPN/PNP twins carry the same equation family
// (current-controlled junction), polarity living in the family name and
// the terminal senses; the terminal set is isomorphic across NPN/PNP.
// Recipes carry structure only; values live in ctor/spec defaults and at
// the BOM layer.
//   NPN / PNP   - junction BJT (general purpose, power)
//   IGBT        - insulated-gate bipolar conduction
//   SCR / TRIAC - latching thyristor (unidirectional / bidirectional)

// NPN junction BJT container. Terminal senses: the base is the control
// input; collector and emitter carry the load path (bidirectional face).
recipe DEV.ACTIVE.NPN {
    name = "NPN bipolar junction transistor discrete electrical recipe"
    in B
    io C
    io E
    require = [
        abs_max = [
            pin  = [B, C, E]
            vceo = Voltage(range), alias: [VCEO], desc: "collector-emitter voltage rating, the absolute-maximum face (base open)"
            ic   = Current, alias: [IC], desc: "continuous collector current rating, the absolute-maximum face"
        ]
        hfe = Ratio(cond(ic: Current, vce: Voltage)), alias: [hFE], desc: "DC current gain; the cond group registers the field axis vocabulary, condition rows carry the axis word, one condition per row"
    ]
    option = [
        abs_max = [
            vcbo = Voltage(range), alias: [VCBO], desc: "collector-base voltage rating, the absolute-maximum face (emitter open)"
            vebo = Voltage(range), alias: [VEBO], desc: "emitter-base voltage rating, the absolute-maximum face (collector open)"
        ]
    ]
}

// PNP junction BJT container. Twin of NPN: same equation family, opposite
// polarity (the base pulled below the emitter turns conduction on).
recipe DEV.ACTIVE.PNP {
    name = "PNP bipolar junction transistor discrete electrical recipe"
    in B
    io C
    io E
    require = [
        abs_max = [
            pin  = [B, C, E]
            vceo = Voltage(range), alias: [VCEO], desc: "collector-emitter voltage rating, the absolute-maximum face (base open)"
            ic   = Current, alias: [IC], desc: "continuous collector current rating, the absolute-maximum face"
        ]
        hfe = Ratio(cond(ic: Current, vce: Voltage)), alias: [hFE], desc: "DC current gain; the cond group registers the field axis vocabulary, condition rows carry the axis word, one condition per row"
    ]
    option = [
        abs_max = [
            vcbo = Voltage(range), alias: [VCBO], desc: "collector-base voltage rating, the absolute-maximum face (emitter open)"
            vebo = Voltage(range), alias: [VEBO], desc: "emitter-base voltage rating, the absolute-maximum face (collector open)"
        ]
    ]
}

// IGBT container: a MOS-style insulated gate controls a bipolar conduction
// path - voltage-driven input, low bipolar saturation.
recipe DEV.ACTIVE.IGBT {
    name = "Insulated-gate bipolar transistor discrete electrical recipe"
    in GATE
    io COLLECTOR
    io EMITTER
    require = [
        abs_max = [
            pin  = [GATE, COLLECTOR, EMITTER]
            vces = Voltage(range), alias: [VCES], desc: "collector-emitter blocking voltage rating (gate-emitter shorted), the absolute-maximum face; breakdown spelled BVCES on IGBT sheets"
            ic   = Current, alias: [IC], desc: "continuous collector current rating, the absolute-maximum face; pulsed face: ICM/ICP"
        ]
    ]
    option = [
        conduction = [
            vce_sat = Voltage, alias: [VCE(sat)], desc: "collector-emitter saturation voltage at the stated collector current and gate drive; the sheet spelling is VCE(sat) with parens (no paren-free VCEsat witness in the sampled corpus)"
        ]
    ]
}

// SCR container: latches on when gate current is injected while forward
// biased; the anode/cathode pair adopts the DIO terminal face.
recipe DEV.ACTIVE.SCR {
    name = "Silicon controlled rectifier discrete electrical recipe"
    in GATE
    io A
    io K
    require = [
        abs_max = [
            pin  = [GATE, A, K]
            vrrm = Voltage(range), alias: [VRRM, VDRM], desc: "repetitive peak reverse voltage rating, the absolute-maximum face"
            it   = Current, alias: [IT(AV), IT(RMS)], desc: "on-state (forward) current rating; datasheets spell IT(AV) average and IT(RMS) RMS - the parenthesized qualifiers stay desc notes"
        ]
    ]
    option = [
        trigger = [
            igt = Current, alias: [IGT], desc: "gate trigger current (DC gate current to latch)"
        ]
    ]
}

// TRIAC container: bidirectional latching switch - gate triggering in
// either polarity turns on conduction in either direction.
recipe DEV.ACTIVE.TRIAC {
    name = "TRIAC discrete electrical recipe"
    in GATE
    io T1
    io T2
    require = [
        abs_max = [
            pin  = [GATE, T1, T2]
            vdrm = Voltage(range), alias: [VDRM], desc: "repetitive peak off-state voltage rating, the absolute-maximum face (either polarity)"
            it   = Current, alias: [IT(AV), IT(RMS)], desc: "on-state current rating; datasheets spell IT(AV) average and IT(RMS) RMS - the parenthesized qualifiers stay desc notes"
        ]
    ]
    option = [
        trigger = [
            igt = Current, alias: [IGT], desc: "gate trigger current (either polarity)"
        ]
    ]
}

// General-purpose junction transistor: polarity-neutral ideal element
// (schematic-level placeholder; polarity-specific contracts adopt the
// NPN/PNP containers).
abstract component TRANS(vce::UV.VOLT, ic::UV.AMP, hfe::INT) {
    name        = "Bipolar Junction Transistor"
    description = "General bipolar junction transistor"
    spec        = [
        collector_emitter_voltage = vce
        collector_current         = ic
        current_gain              = hfe
    ]

    pins = [
        in 1  = B, "Base terminal"
        in 2  = C, "Collector terminal"
        out 3 = E, "Emitter terminal"
    ]
}

// NPN transistor: conducts when the base is driven above the emitter;
// adopts the NPN container.
abstract component TRANS.NPN(vce::UV.VOLT, icur::UV.AMP, gain::INT) :: DEV.ACTIVE.NPN {
    name        = "NPN Transistor"
    description = "NPN bipolar junction transistor"
    spec        = [
        vceo = vce
        ic   = icur
        hfe  = gain
    ]

    pins = [
        in 1 = B, "Base terminal"
        io 2 = C, "Collector terminal"
        io 3 = E, "Emitter terminal"
    ]
}

// PNP transistor: conducts when the base is pulled below the emitter;
// adopts the PNP container.
abstract component TRANS.PNP(vce::UV.VOLT, icur::UV.AMP, gain::INT) :: DEV.ACTIVE.PNP {
    name        = "PNP Transistor"
    description = "PNP bipolar junction transistor"
    spec        = [
        vceo = vce
        ic   = icur
        hfe  = gain
    ]

    pins = [
        in 1 = B, "Base terminal"
        io 2 = E, "Emitter terminal"
        io 3 = C, "Collector terminal"
    ]
}

// Darlington pair transistor: two BJT stages cascaded on one die - the
// current gain is the product of the two stages; adopts the NPN container
// (the common polarity; the doubled VBE drop rides the model, not the
// ratings).
abstract component TRANS.DARLINGTON(vce::UV.VOLT, icur::UV.AMP, gain::INT) :: DEV.ACTIVE.NPN {
    name        = "Darlington Transistor"
    description = "Darlington pair transistor"
    spec        = [
        vceo = vce
        ic   = icur
        hfe  = gain
    ]

    pins = [
        in 1 = B, "Base terminal"
        io 2 = C, "Collector terminal"
        io 3 = E, "Emitter terminal"
    ]
}

// IGBT: a MOSFET-style insulated gate controls a bipolar conduction path;
// adopts the IGBT container.
abstract component TRANS.IGBT(vce::UV.VOLT, icur::UV.AMP) :: DEV.ACTIVE.IGBT {
    name        = "IGBT"
    description = "Insulated Gate Bipolar Transistor"
    spec        = [
        vces = vce
        ic   = icur
    ]

    pins = [
        in 1 = GATE, "Gate terminal"
        io 2 = COLLECTOR, "Collector terminal"
        io 3 = EMITTER, "Emitter terminal"
    ]
}

// SCR: latches on when gate current is injected while forward biased and
// stays conducting until the anode current falls below the holding level;
// adopts the SCR container.
abstract component TRANS.SCR(vrev::UV.VOLT, icur::UV.AMP) :: DEV.ACTIVE.SCR {
    name        = "SCR"
    description = "Silicon Controlled Rectifier"
    spec        = [
        vrrm = vrev
        it   = icur
    ]

    pins = [
        in 1      = GATE, "Gate terminal"
        io [2, 3] = [A, K]::DIO()  // A = anode (pad 2), K = cathode (pad 3); DIO face adoption, bare member names (schematic face)
    ]
}

// TRIAC: bidirectional latching switch - gate triggering in either
// polarity turns on conduction in either direction; adopts the TRIAC
// container.
abstract component TRANS.TRIAC(vd::UV.VOLT, icur::UV.AMP) :: DEV.ACTIVE.TRIAC {
    name        = "TRIAC"
    description = "Triode for Alternating Current"
    spec        = [
        vdrm = vd
        it   = icur
    ]

    pins = [
        in 1 = GATE, "Gate terminal"
        io 2 = T1, "Main terminal 1"
        io 3 = T2, "Main terminal 2"
    ]
}

// Usage Examples:
// 1. NPN transistor as a low-side switch
// TRANS.NPN(40V, 200mA, 100) q1
//
// 2. PNP high-side switch
// TRANS.PNP(40V, 200mA, 100) q2
//
// 3. Darlington pair for high gain
// TRANS.DARLINGTON(100V, 8A, 1000) q3
//
// 4. IGBT for high-voltage switching
// TRANS.IGBT(600V, 20A) q4
//
// 5. SCR for latching AC control
// TRANS.SCR(800V, 12A) scr1
//
// 6. TRIAC for AC phase control
// TRANS.TRIAC(600V, 8A) tri1
