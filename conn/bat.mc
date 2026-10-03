# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// BAT.HOLDER - Coin-cell battery holder (RTC backup and similar) Component Definition
// Core Rule: Mechanical contact face only; the cell itself is a DC.BAT source.
// Pins bind the DC interface: pin 1 positive contact, pin 2 negative contact.

component BAT.HOLDER()
{
    name = "Battery Holder"
    description = "Coin-cell battery holder, contact face only (cell is a DC.BAT source)"

    spec = [
        cell = _ // [CR2032, CR2025, CR2016, CR1220, LR44]
        mount = _ // [through-hole, surface-mount]
        retention = _ // [snap, screw]
    ]

    pins = [
        [1,2] = [\+, \-]::DC()        // contact face: pin 1 positive, pin 2 negative
    ]
}

// Usage Examples:
// BAT.HOLDER() rtc_bat1
// rtc_bat1.1 -> rtc_vbak        // pin 1 = "+" contact
// rtc_bat1.2 -> gnd             // pin 2 = "-" contact
