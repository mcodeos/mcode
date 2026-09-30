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

// Judge metas and closed vocabularies: the named judge primitives ride the
// mcc builtin seed (covers / leq / in_env / voc — design §3.3, the standard
// five); this file hosts the meta-layer half — vocabulary-by-reference
// declarations, in-body custom judges, and the global data-name dictionary
// this library hosts once meta replaces the attr_keys.rs seed (design
// ruling 12). Sources: mcd/doc/ee/meta-system-design.md v0.2 and
// mcs/metadata/typical_params.mc (specimens 6 and 9).
//
// Every block below stays comment-gated: 1a admits none of their shapes —
// the words column (the enum-reference arm is the G6 vocabulary batch) and
// the in-body judge fn (a grammar extension of its own, TC275 necessity
// law). They unseal with those batches, in place.

// 1. closed vocabulary by reference: the word table has one source — the
// enum; a meta never spells words inline. UART: mode = full.
// meta mode {
//     shape = enum
//     judge = voc
//     words = DUPLEX
// }

// 2. in-body custom judge (ruling 9): the law is conditional on two axes
// at once — no single primitive holds it; the in-meta fn composes
// primitives. TPS7A8101 output accuracy: ±2% within 0..85C and
// 0.1..0.5A, ±3% outside.
// meta output_accuracy {
//     unit   = UV.PERCENT
//     shape  = scalar
//     role   = supply
//     params = temp, load
//
//     judge domain_cut(demand, supply) -> verdict {
//         in_env(temp: 0..85C, load: 0.1..0.5A) ? leq(demand, 2%) : leq(demand, 3%)
//     }
// }

// 3. the global data-name dictionary (ruling 12 companion order): the
// authoritative name registry — today attr_keys.rs plus the spec/07-attrs.md
// ledger, in the meta era this table. Key name = meta name binds here
// (same-name default binding); the registry face must stay unique or
// cross-vendor comparison loses its anchor. Each meta name declared in
// core.mc (vin_range, output, receiver, absmax, temp_range, dropout, cout,
// maxspeed, current_rating, soa, zth, theta_ja) and above registers here
// exactly once.
