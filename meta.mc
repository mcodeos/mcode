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

// Aggregate of the global meta declarations (meta-system-design.md ruling
// 12): the declaration layer (schema) lives here and nowhere else — one
// authority face, like attr_keys.rs for attribute keys today. Files under
// ./meta/ hold the definitions per domain; this file is a list only.
//
// The `meta` top-level production landed with meta grammar batch 1a
// (b4305); the domain files carry the declarations live. Specimens and
// necessity evidence live in mcs/metadata/ and must not be loaded as a
// library.

// meta declarations, per domain
pub use ./meta/core.mc
pub use ./meta/judge.mc
pub use ./meta/power.mc
pub use ./meta/level.mc
pub use ./meta/radio.mc
pub use ./meta/xtal.mc
