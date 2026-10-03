# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

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
