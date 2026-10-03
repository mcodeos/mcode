# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Radio family: the RF link faces. Union of the
// five specimen boards' declarations; comment-gated like core.mc.
//
// Axis-vs-condition split: a sheet with per-stack
// tables binds the stack as a mode AXIS argument (mode = ble1m); a sheet
// printing one merged table rides the stack on the value as
// value@condition — data side, same face.

// band window; an application's channel demand must sit inside.
// Literal: a range — window, hertz.
// meta radio_band {
//     judge = covers
//     role  = supply
// }

// PHY rate; protocol constant, an application demand reads a floor.
// A rate SET (alternatives, no x axis) is a plain set — legal value
// shape; leq over a set reads "demand ∈ set".
// Literal: a bare scalar or a plain list.
// meta radio_rate {
//     judge = leq
//     role  = supply
// }

// receiver sensitivity; link budget: peer pout + path loss must stay
// above this. mode binds the PHY when the sheet splits per PHY.
// Literal: a bare scalar (require-paired).
// meta rf_sens {
//     role   = supply
//     params = mode
// }

// transmit output power; delivered power <= peer receiver saturation
// (link budget).
// Literal: a bare scalar or a range.
// meta rf_pout {
//     judge = leq
//     role  = supply
// }

// receiver saturation; peer delivered power must not exceed it
// (link budget).
// Performance limit — NOT absmax (survival limit); the two stay separate.
// Literal: a bare scalar.
// meta rf_maxin {
//     judge = leq
//     role  = demand
// }

// clock/symbol accuracy tolerance; the peer crystal accuracy window must
// sit inside.
// Literal: a dict [freq: ..., sym: ...] or points.
// meta rf_tol {
//     judge  = covers
//     role   = demand
//     params = mode
// }

// co-channel/adjacent rejection (documentation-only landing).
// Literal: value@offset points.
// meta rf_reject {
//     role   = supply
//     params = mode
// }

// blocking (out-of-band CW or in-band jammer; documentation-only landing).
// Literal: value@band points.
// meta rf_block {
//     role   = supply
//     params = mode
// }

// spurious emissions, RX masks and TX regulatory ladders
// (documentation-only landing).
// Literal: value@band points.
// meta rf_spur {
//     role   = supply
//     params = mode
// }

// modulation quality (EVM; documentation-only landing).
// Literal: a bare scalar — percent.
// meta rf_evm {
//     role = supply
// }

// carrier offset/drift, synthesizer data (documentation-only landing).
// Literal: value@condition points.
// meta rf_phase {
//     role = supply
// }

// matching-network impedance; the antenna network pairs on the antenna
// face.
// Literal: a complex scalar (69 ohm + j29).
// meta rf_load {
//     role = supply
// }
