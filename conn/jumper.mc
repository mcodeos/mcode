# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// JUMPER - Configuration jumper header (n pins, closed pairwise by a jumper cap) Component Definition
// Core Rule: The cap closes pins (2k-1, 2k); an odd trailing pin (e.g.
// JUMPER(3)) stays open as the standard "2 closed + 1 spare" form.

component JUMPER(n::INT)
{
    name = "Jumper Header"
    description = "Jumper header with " + n + " pins, closed pairwise by a cap"

    spec = [
        pin_count = n
        pitch = _ // [2.54mm, 1.27mm]
        closed_by = "cap"
        mount = _ // [through-hole, surface-mount]
    ]

    pins = [
        1:n = 1:n
    ]
}

// JUMPER.BRIDGE - Two-pad solder bridge for board-level configuration Component Definition

component JUMPER.BRIDGE()
{
    name = "Solder Bridge"
    description = "Two-pad solder bridge for board-level configuration"

    spec = [
        closed_by = "solder"
        pitch = _ // [1.27mm, 2.54mm]
    ]

    pins = [
        1 = A, "Bridge pad A"
        2 = B, "Bridge pad B"
    ]
}

// Usage Examples:
// JUMPER(2) boot_sel1
// boot_sel1.1 -> boot_mode
// boot_sel1.2 -> gnd
// JUMPER.BRIDGE() term_bridge1
// term_bridge1.A -> can_bus_l
