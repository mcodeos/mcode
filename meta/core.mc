# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Core meta declarations: the common numeric data families every datasheet
// carries — the schema layer only; device values ride the carrier corpora.
//
// The `meta` production does not exist in the grammar yet, so
// every block below is comment-gated: the library must stay loadable, and
// the meta grammar batch uncomments them in place. Do not add live
// `meta` syntax here before that batch lands.
//
// The single application form is instantiation:
// key = MetaName(axes)(one value literal) — bare same-name values are
// retired. The literal carries everything: four shapes, four spellings
// (scalar bare / range a ~ b / dict [k: v, ...] / list — value@condition
// for envelope, (x, y) pairs for curve); shape and unit derive from it.
// Declarations therefore carry the load-bearing half only:
// judge / role / params / words — each block documents its accepted
// literal form (the derivation target) instead of unit/shape columns.

// 1. device-truth supply window on a body. A mainstream linear regulator: VIN 3V ~ 40V.
// Literal: a range (3V ~ 40V) — window, volt.
// meta vin_range {
//     judge = covers
//     role  = supply
// }

// 2. protocol-constant output window on an interface face: the level
// is fixed by the protocol, the device cannot choose it. RS-232: -15V ~ +15V.
// Literal: a range — window, volt.
// meta output {
//     judge = covers
//     role  = supply
// }

// 3. demand window on the consumer side, symmetric to 2; role picks the
// pairing half. RS-232 receiver: -15V ~ -3V (pairs against `output`).
// Literal: a range — window, volt.
// meta receiver {
//     judge = covers
//     role  = demand
// }

// 4. absolute maximum ratings: min/max limit window, no typ. A mainstream
// MCU family: VDD -0.3V ~ 3.6V. A demand point must sit inside; the limit is
// never a design target.
// Literal: a range — window, volt.
// meta absmax {
//     judge = covers
//     role  = supply
// }

// 5. operating temperature range. A mainstream MCU family: TJ -40C ~
// 105C. Every datasheet carries it; supply side of the ambient pairing.
// Literal: a range — window, temp (unit rides the values).
// meta temp_range {
//     judge = covers
//     role  = supply
// }

// 6. LDO dropout: three-point window, judged on high, never on typ; the
// value form is the named-slot dict literal.
// A mainstream LDO: dropout = dropout([low: 0mV, typ: 170mV, high: 270mV]).
// Literal: a named-slot dict — three-point window, volt.
// meta dropout {
//     judge = leq
//     role  = supply
// }

// 7. external BOM demand window: the counterpart is the placed
// part, not a peer pin. A mainstream buck: COUT 22uF ~ 68uF; an MCU EVR: 3/4.7/6.3uF
// three-point.
// Literal: a range — window, farad.
// meta cout {
//     judge = covers
//     role  = demand
// }

// 8. conditional reach envelope: one condition axis, named (K form).
// RS-485 reach: maxspeed = maxspeed([9.6kbps@15m, 115.2kbps@5m])
// Literal: value@condition points — envelope; baud rides the values.
// meta maxspeed {
//     judge  = in_env
//     role   = supply
//     params = distance
// }

// 9. multi-rating under one physical quantity: the kind axis separates two
// duties of the same AMP. MMD-10DZ-100M: Isat 8.5A vs Idc 7.5A.
// Pairing law: a demand pairs only against a supply whose axis values
// match; axis mismatch is a skip, not a violation.
// Literal: a bare scalar; the kind axis rides the call parens.
// spec = [
//     isat = current_rating(kind=sat)(8.5A)
//     idc  = current_rating(kind=heat)(7.5A)
// ]
// meta current_rating {
//     judge  = leq
//     role   = supply
//     params = kind
// }

// 10. safe operating area curve: current vs drain voltage, one line per
// pulse width. Canon: a curve spells coordinate pairs (x, y) — independent
// variable first, judged quantity second; the x unit rides each point.
// envelope keeps value@condition.
// A power MOSFET:
// spec = [ soa = soa(tp=10ms)([(10V, 40A), (32V, 14A), (80V, 5A)]) ]
// Literal: (x, y) pairs — curve; amp rides the y values.
// meta soa {
//     judge  = in_env
//     role   = supply
//     params = tp
// }

// 11. thermal impedance curve: Zth vs time, one line per duty cycle.
// A power MOSFET: ZthJC = f(tP), parameter D = tp/T.
// Same canon as 10: zth = zth(d=0.02)([(t, K/W), ...]) — values read off
// the datasheet figure at landing time (the landing cites the shape, not
// numbers). K/W rides the y values: no UV.* member needed.
// Literal: (x, y) pairs — curve; K/W rides the y values.
// meta zth {
//     judge  = in_env
//     role   = supply
//     params = d
// }

// 12. package thermal resistance: one scalar per package plus its test-board
// condition. A mainstream MCU: thetaJA 8.7K/W @ 10-layer 114x101mm.
// Use: theta_ja = theta_ja(board=10l-114x101mm)(8.7K/W) — K/W rides the
// value literal, no UV.* member needed.
// Literal: a bare scalar — scalar; K/W rides the value.
// meta theta_ja {
//     judge  = leq
//     role   = supply
//     params = board
// }

// 13. internal blocks with no external endpoint (internal clocks, supply
// supervisors, ESD structures): the admission gate REFUSES them a pin
// landing — instances stay data on the body spec. Second witness:
// mainstream SoC/MCU internal-clock tables.
// Literal: a dict of the block's scalars.
// meta rc_osc {
//     role = supply
// }

// 14. on-die temperature sensor (documentation-only landing).
// Literal: a dict [nom: ..., tempco: ...] or a range.
// meta temp_sense {
//     role = supply
// }

// 15. peripheral interface timing (SPI/SSI cycles, duty). Pins are muxed
// across DIOs, so the instance waits for the alias pin-face work on the
// pin anchor; rows stay body data until then (documentation-only landing).
// Literal: a dict [cycle: ..., duty: ...].
// meta spi_timing {
//     role = supply
// }
