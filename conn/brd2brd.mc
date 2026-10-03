# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// CONN.B2B - Generic board-to-board connector Component Definition

component CONN.B2B(pincnt::INT)
{
    name = "Board-to-Board Connector"
    description = "Board-to-board connector"

    spec = [
        pin_count = pincnt // [2, 4, 6, 8, 10, 12, 16, 20, 24, 28, 32, 40]
        pitch = _ // [0.5mm, 0.65mm, 0.8mm, 1.0mm, 1.27mm, 2.0mm]
        stack_height = _ // [0.5mm, 1.0mm, 1.5mm, 2.0mm, 2.5mm, 3.0mm, 4.0mm, 5.0mm]
    ]

    pins = [
        1:pin_count = 1:pin_count
    ]
}

// CONN.MEZZANINE - High-density mezzanine (stacked-board) connector Component Definition

component CONN.MEZZANINE(pincnt::INT)
{
    name = "Mezzanine Connector"
    description = "High-density mezzanine connector"

    spec = [
        pin_count = pincnt // [10, 20, 30, 40, 50, 60, 80, 100]
        pitch = _ // [0.3mm, 0.4mm, 0.5mm, 0.65mm, 0.8mm]
        stack_height = _ // [0.5mm, 1.0mm, 1.5mm, 2.0mm, 2.5mm, 3.0mm]
    ]

    pins = [
        1:pin_count = 1:pin_count
    ]
}

// CONN.DIN41612 - DIN 41612 rectangular board-to-board connector Component Definition
// Note: form factor C = 96-pin, B = 64-pin, A = 32-pin.

component CONN.DIN41612(pincnt::INT)
{
    name = "DIN 41612 Connector"
    description = "DIN 41612 board-to-board connector, " + pincnt + " pins"
    
    spec = [
        standard = "DIN 41612"
        size = _ // [1, 2, 3]
        pin_count = pincnt
    ]
    
    pins = [
        1:pin_count = 1:pin_count
    ]
}

// Usage Examples:
// 1. Basic board-to-board connector
// CONN.B2B(16)

// 2. High-density mezzanine connector
// CONN.MEZZANINE(40)

// 3. DIN 41612 connector
// CONN.DIN41612(96)