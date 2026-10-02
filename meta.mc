# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

// Aggregate of the global meta declarations (meta-system-design.md ruling
// 12): the declaration layer (schema) lives here and nowhere else — one
// authority face, like attr_keys.rs for attribute keys today. Files under
// ./meta/ hold the definitions per domain; this file is a list only.
//
// The `meta` top-level production does not exist in the grammar yet (arc
// step 2); the domain files carry their scope as comments until the meta
// grammar batch lands. Specimens and necessity evidence live in
// mcs/metadata/ and must not be loaded as a library.

// meta declarations, per domain
pub use ./meta/core.mc
pub use ./meta/judge.mc
pub use ./meta/power.mc
pub use ./meta/level.mc
pub use ./meta/radio.mc
pub use ./meta/xtal.mc
