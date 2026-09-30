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

// Power family: supply windows and current budgets (ruling 13 domain
// split). Union of the five rfsoc specimens' declarations, transcribed
// identically in mcs/rfsoc/*/ — that corpus is the necessity evidence.
// Unsealed in place by the meta grammar batch (1a, b4305).

// supply window on the consumer side of a regulator pair. The key
// registers cross-vendor, so no chip pin name may bake in (vdd_range
// renamed supply_range on that law).
// Literal: a range — window, volt.                                   -> Pass C
meta supply_range {
    judge = covers
    role  = demand
}

// whole-device or per-mode current demand on a supply face; demand.high
// must stay <= capacity on the source face (Pass D, per-mode slots).
// Mode words are the DATASHEET'S OWN power-mode names; a parameter rides
// the word as an argument (ruling 25): tx(4.5dBm), pm(1), em(2),
// standby(rcosc_lf), sce(24MHz). Vendor vocabularies differ by design —
// the words are data, never a fixed enum here.
// Literal: a bare scalar, or a dict [typ: ..., max: ...].             -> Pass D
meta current_draw {
    judge  = leq
    role   = demand
    params = mode
}

// axis-free capacity on the SOURCE face: pairs any demand axis (the
// regulator counterpart of current_draw).
// Literal: a bare scalar.                                             -> Pass D
meta current_capacity {
    judge = leq
    role  = supply
}

// wake/resume time envelope; a require's latency limit must sit inside
// the point matching its `from` mode.
// Literal: value@mode points — envelope.                    -> Pass C-2 (require)
meta wake_time {
    judge  = in_env
    role   = supply
    params = from
}

// additive per-peripheral current, summed onto the rail budget next to
// current_draw ("adds to core current for each peripheral unit
// activated"). Unit words are the datasheet's own row names; the shared
// enum home (words = enum) waits for the G6 vocabulary batch — the words
// column is out of 1a by ruling.
// Literal: a bare scalar, or a dict.                                  -> Pass D
meta peri_current {
    judge  = leq
    role   = demand
    params = unit
}
