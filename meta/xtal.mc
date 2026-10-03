# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Crystal family: DEMANDS a SoC places on the external crystal parts
// (ruling 13 domain split); they pair when the crystal is transcribed as
// a library part. Union of the five rfsoc specimens' declarations;
// comment-gated like core.mc.

// nominal frequency window.                                           -> Pass C
// Literal: a bare scalar — hertz.
// meta xtal_freq {
//     judge = covers
//     role  = demand
// }

// frequency tolerance/accuracy window; the part's window must sit
// inside. Protocol-dependent tolerances ride value@condition.         -> Pass C
// Literal: a range or points — ppm.
// meta xtal_acc {
//     judge = covers
//     role  = demand
// }

// equivalent series resistance.                            -> Pass C
// Literal: a range — ohm.
// meta xtal_esr {
//     judge = leq
//     role  = demand
// }

// shunt capacitance.                                       -> Pass C
// Literal: a range — farad.
// meta xtal_c0 {
//     judge = covers
//     role  = demand
// }

// load capacitance.                                        -> Pass C
// Literal: a range — farad.
// meta xtal_cl {
//     judge = covers
//     role  = demand
// }

// startup time budget.                                 -> doc (R10)
// Literal: a dict [typ: ...] or a bare scalar.
// meta xtal_start {
//     role = supply
// }

// power-down guard law (drive level while the oscillator is stopped).
//                                                      -> doc (R10)
// Literal: points.
// meta xtal_guard {
//     role = supply
// }
