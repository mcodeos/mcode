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
