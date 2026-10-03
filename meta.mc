# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Aggregate of the global meta declarations: the declaration layer
// (schema) lives here and nowhere else — one authority face. Files under
// ./meta/ hold the definitions per domain; this file is a list only.
//
// The `meta` top-level production does not exist in the grammar yet; the
// domain files carry their scope as comments until the meta
// grammar batch lands. Specimens and necessity evidence live in a separate
// corpus tree and must not be loaded as a library.

// meta declarations, per domain
pub use ./meta/core.mc
pub use ./meta/judge.mc
pub use ./meta/power.mc
pub use ./meta/level.mc
pub use ./meta/radio.mc
pub use ./meta/xtal.mc
