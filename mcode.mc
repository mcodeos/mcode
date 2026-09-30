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

// MCode is an industrial-grade circuit programming language aimed at precise
// and efficient circuit programming. This file aggregates the standard
// components and interfaces of the language as the mcode basic library.

// import modules
pub use ./ifs/ifs.mc
pub use ./conn/conn.mc

// import metas (declarations only, meta-system-design.md ruling 12)
pub use ./meta.mc

// import files
pub use ./comp/comp.mc
