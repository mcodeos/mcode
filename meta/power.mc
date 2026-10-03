# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Power family: supply windows and current budgets. Union of the five
// specimen boards' declarations, transcribed identically — that corpus is
// the necessity evidence.
// Comment-gated like core.mc: the meta grammar batch uncomments in place.

// supply window on the consumer side of a regulator pair. The key
// registers cross-vendor, so no chip pin name may bake in (vdd_range
// renamed supply_range on that law).
// Literal: a range — window, volt.
// meta supply_range {
//     judge = covers
//     role  = demand
// }

// whole-device or per-mode current demand on a supply face; demand.high
// must stay <= capacity on the source face (per-mode slots).
// Mode words are the DATASHEET'S OWN power-mode names; a parameter rides
// the word as an argument: tx(4.5dBm), pm(1), em(2),
// standby(rcosc_lf), sce(24MHz). Vendor vocabularies differ by design —
// the words are data, never a fixed enum here.
// Literal: a bare scalar, or a dict [typ: ..., max: ...].
// meta current_draw {
//     judge  = leq
//     role   = demand
//     params = mode
// }

// axis-free capacity on the SOURCE face: pairs any demand axis (the
// regulator counterpart of current_draw).
// Literal: a bare scalar.
// meta current_capacity {
//     judge = leq
//     role  = supply
// }

// wake/resume time envelope; a require's latency limit must sit inside
// the point matching its `from` mode.
// Literal: value@mode points — envelope (require-paired).
// meta wake_time {
//     judge  = in_env
//     role   = supply
//     params = from
// }

// additive per-peripheral current, summed onto the rail budget next to
// current_draw ("adds to core current for each peripheral unit
// activated"). Unit words are the datasheet's own row names; the shared
// enum home (words = enum) waits for the meta grammar batch.
// Literal: a bare scalar, or a dict.
// meta peri_current {
//     judge  = leq
//     role   = demand
//     params = unit
// }
