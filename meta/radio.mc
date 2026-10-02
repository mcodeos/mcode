# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Radio family: the RF link faces (ruling 13 domain split). Union of the
// five rfsoc specimens' declarations; comment-gated like core.mc.
//
// Axis-vs-condition split (rulings 25/26 narrow): a sheet with per-stack
// tables binds the stack as a mode AXIS argument (mode = ble1m); a sheet
// printing one merged table rides the stack on the value as
// value@condition — data side, same face.

// band window; an application's channel demand must sit inside.  -> Pass C
// Literal: a range — window, hertz.
// meta radio_band {
//     judge = covers
//     role  = supply
// }

// PHY rate; protocol constant, an application demand reads a floor.
// A rate SET (alternatives, no x axis) is a plain set — legal value
// shape; leq over a set reads "demand ∈ set" (ruling 29 side note).
// Literal: a bare scalar or a plain list.                             -> Pass C
// meta radio_rate {
//     judge = leq
//     role  = supply
// }

// receiver sensitivity; link budget: peer pout + path loss must stay
// above this. mode binds the PHY when the sheet splits per PHY.
// Literal: a bare scalar.                          -> Pass C-2 (require-paired)
// meta rf_sens {
//     role   = supply
//     params = mode
// }

// transmit output power; delivered power <= peer receiver saturation.
// Literal: a bare scalar or a range.                -> Pass C-2 (link budget)
// meta rf_pout {
//     judge = leq
//     role  = supply
// }

// receiver saturation; peer delivered power must not exceed it.
// Performance limit — NOT absmax (survival limit); the two stay separate.
// Literal: a bare scalar.                           -> Pass C-2 (link budget)
// meta rf_maxin {
//     judge = leq
//     role  = demand
// }

// clock/symbol accuracy tolerance; the peer crystal accuracy window must
// sit inside.                                            -> Pass C-2
// Literal: a dict [freq: ..., sym: ...] or points.
// meta rf_tol {
//     judge  = covers
//     role   = demand
//     params = mode
// }

// co-channel/adjacent rejection.          -> doc (coexistence walk absent; R10)
// Literal: value@offset points.
// meta rf_reject {
//     role   = supply
//     params = mode
// }

// blocking (out-of-band CW or in-band jammer).     -> doc (R10)
// Literal: value@band points.
// meta rf_block {
//     role   = supply
//     params = mode
// }

// spurious emissions, RX masks and TX regulatory ladders.     -> doc (R10)
// Literal: value@band points.
// meta rf_spur {
//     role   = supply
//     params = mode
// }

// modulation quality (EVM).                            -> doc (R10)
// Literal: a bare scalar — percent.
// meta rf_evm {
//     role = supply
// }

// carrier offset/drift, synthesizer data.              -> doc (R10)
// Literal: value@condition points.
// meta rf_phase {
//     role = supply
// }

// matching-network impedance; the antenna network pairs on the Pass A
// face.                                                -> Pass A
// Literal: a complex scalar (69 ohm + j29).
// meta rf_load {
//     role = supply
// }
