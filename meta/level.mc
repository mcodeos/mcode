# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Level family: digital IO drive/receive pairs and pin-level analog
// trimmings (ruling 13 domain split). Union of the five rfsoc specimens'
// declarations; comment-gated like core.mc.

// driven output window; the driven input's receiver window must cover us
// (Pass C, the E4124 level-window gate).
// Drive-class axis (ruling 29): ONE word `ma` with a current argument,
// ma(4mA) / ma(8mA) / ma(20mA) — compound tokens (ma4, ma20) are retired;
// a single-class sheet drops the axis (deleted, not defaulted).
// Literal: a dict [low: ..., high: ...] — two-point window, volt.     -> Pass C
// meta drive_level {
//     judge  = covers
//     role   = supply
//     params = kind
// }

// configurable pull-up/-down. The quantity follows the datasheet fact —
// resistance (typ value) or injected current at a pad condition; the two
// quantities never pair against each other (ruling 29 side note).
// Literal: a bare scalar or value@condition points.                   -> doc (R10)
// meta io_pull {
//     role = supply
// }

// input leakage window.                                                -> doc (R10)
// Literal: a dict [max: ...] or a bare scalar.
// meta io_leak {
//     role = supply
// }

// shortest recognized reset pulse; the driving side (debugger/supervisor)
// is the pairing peer.                                                 -> doc (R10)
// Literal: a bare scalar — duration.
// meta t_reset {
//     judge = leq
//     role  = demand
// }

// shortest recognized interrupt pulse; driver-bound like t_reset.
//                                                                      -> doc (R10)
// Literal: a bare scalar — duration.
// meta t_int {
//     judge = leq
//     role  = demand
// }
