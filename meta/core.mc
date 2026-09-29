# Copyright 2026 MCode
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

// Core meta declarations: the common numeric data families every datasheet
// carries, written against meta-system-design.md v0.2 (rulings 1-9) — the
// schema layer only (ruling 12); device values ride the carrier corpora.
// Sources: mcd/doc/ee/datasheet-data-survey.md (real datasheet reads) and
// mcs/metadata/typical_params.mc (the ten validated specimens).
//
// The `meta` production does not exist in the grammar yet (arc step 2), so
// every block below is comment-gated: the library must stay loadable, and
// the meta grammar batch uncomments them in place. Do not add live
// `meta` syntax here before that batch lands.
//
// The single application form is instantiation (design rulings 15-18):
// key = MetaName(axes)(one value literal) — bare same-name values are
// retired. The literal carries everything: four shapes, four spellings
// (scalar bare / range a ~ b / dict [k: v, ...] / list — value@condition
// for envelope, (x, y) pairs for curve); shape and unit derive from it.

// 1. device-truth supply window on a body (L1). LM317: VIN 3V ~ 40V.
// meta vin_range {
//     unit  = UV.VOLT
//     shape = window
//     judge = covers
//     role  = supply
// }

// 2. protocol-constant output window on an interface face (L2): the level
// is fixed by the protocol, the device cannot choose it. RS-232: -15V ~ +15V.
// meta output {
//     unit  = UV.VOLT
//     shape = window
//     judge = covers
//     role  = supply
// }

// 3. demand window on the consumer side, symmetric to 2; role picks the
// pairing half. RS-232 receiver: -15V ~ -3V (pairs against `output`).
// meta receiver {
//     unit  = UV.VOLT
//     shape = window
//     judge = covers
//     role  = demand
// }

// 4. absolute maximum ratings: min/max limit window, no typ (survey class
// 1). GD32: VDD -0.3V ~ 3.6V. A demand point must sit inside; the limit is
// never a design target.
// meta absmax {
//     unit  = UV.VOLT
//     shape = window
//     judge = covers
//     role  = supply
// }

// 5. operating temperature range (survey classes 2/10). GD32: TJ -40C ~
// 105C. Every datasheet carries it; supply side of the ambient pairing.
// meta temp_range {
//     unit  = UV.TEMP
//     shape = window
//     judge = covers
//     role  = supply
// }

// 6. LDO dropout: three-point window, judged on max, never on typ (D1 ->
// G9; the value form is the named-slot dict literal, ruling 17).
// TPS7A8101: dropout = dropout([low: 0mV, typ: 170mV, high: 270mV]).
// meta dropout {
//     unit  = UV.VOLT
//     shape = window
//     judge = leq
//     role  = supply
// }

// 7. external BOM demand window (D4 -> G12): the counterpart is the placed
// part, not a peer pin. TPS54202: COUT 22uF ~ 68uF; TC275 EVR: 3/4.7/6.3uF
// three-point.
// meta cout {
//     unit  = UV.CAP
//     shape = window
//     judge = covers
//     role  = demand
// }

// 8. conditional reach envelope: one condition axis, named (K form, G2).
// Point form = value@condition; the point-list literal rides in the value
// parens (design ruling 17): maxspeed = maxspeed([9.6kbps@15m, 115.2kbps@5m])
// meta maxspeed {
//     unit   = UV.BAUD
//     shape  = envelope
//     judge  = in_env
//     role   = supply
//     params = distance
// }

// 9. multi-rating under one physical quantity: the kind axis separates two
// duties of the same AMP (D6 -> G14). MMD-10DZ-100M: Isat 8.5A vs Idc 7.5A.
// Pairing law: a demand pairs only against a supply whose axis values
// match; axis mismatch is a skip, not a violation.
// Use: axis args in the call parens, the value follows.
// spec = [
//     isat = current_rating(kind=sat)(8.5A)
//     idc  = current_rating(kind=heat)(7.5A)
// ]
// meta current_rating {
//     unit   = UV.AMP
//     shape  = scalar
//     judge  = leq
//     role   = supply
//     params = kind
// }

// 10. safe operating area curve: current vs drain voltage, one line per
// pulse width (D5 -> G13; the x-unit slot is meta-system §8-8).
// Canon (2026-09-29 user ruling 18): a curve spells coordinate pairs
// (x, y) — the independent variable first, the judged quantity (unit
// column) second; the x unit rides each point (closes §8-8). envelope
// keeps the value@condition spelling (ruling 14). IRF3710S:
// spec = [ soa = soa(tp=10ms)([(10V, 40A), (32V, 14A), (80V, 5A)]) ]
// meta soa {
//     unit   = UV.AMP
//     shape  = curve
//     judge  = in_env
//     role   = supply
//     params = tp
// }

// 11. thermal impedance curve: Zth vs time, one line per duty cycle
// (survey class 17). IPA60R280P7S: ZthJC = f(tP), parameter D = tp/T.
// Same canon as 10: zth = zth(d=0.02)([(t, K/W), ...]) — values read off
// the datasheet figure at landing time (survey cites the shape, not
// numbers). Unit gap closed by ruling 18: the unit column derives from
// the literals, so K/W needs no UV.* member.
// meta zth {
//     unit   = ?
//     shape  = curve
//     judge  = in_env
//     role   = supply
//     params = d
// }

// 12. package thermal resistance: one scalar per package plus its test-board
// condition (survey class 10). TC275: thetaJA 8.7K/W @ 10-layer 114x101mm.
// Use: theta_ja = theta_ja(board=10l-114x101mm)(8.7K/W) — K/W rides the
// value literal (ruling 18), no UV.* member needed.
// meta theta_ja {
//     unit   = ?
//     shape  = scalar
//     judge  = leq
//     role   = supply
//     params = board
// }
