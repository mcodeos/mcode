# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// POWER.DC_JACK - DC barrel power jack Component Definition
// Core Rule: Two-contact DC face - center pin positive or negative per the
// polarity parameter, outer sleeve the opposite rail.

component POWER.DC_JACK(polarity::STRING)
{
    name = "DC Power Jack"
    description = "DC power barrel jack, " + polarity + " polarity"
    
    spec = [
        type = "DC Jack"
        outer_diameter = _ // [5.5mm, 6.3mm, 7.4mm, 8.4mm]
        center_pin_diameter = _ // [2.1mm, 2.5mm, 3.0mm]
        polarity = polarity
    ]
    
    pins = [
        [1,2] = [VCC,GND]::DC(), ["Center Pin","Outer Sleeve"]
    ]
}

// POWER.XT60 - 60 A two-pole DC power connector (RC models) Component Definition

component POWER.XT60()
{
    name = "XT60 Connector"
    description = "XT60 power connector"
    
    spec = [
        type = "XT60"
        gender = _ // [male, female]
        current_rating = "60A"
        application = "RC Models"
    ]
    
    pins = [
        [1,2] = [VCC,GND]::DC(), ["Positive","Negative"]
    ]
}

// POWER.XT30 - 30 A two-pole DC power connector, smaller sibling of POWER.XT60 (RC models) Component Definition

component POWER.XT30()
{
    name = "XT30 Connector"
    description = "XT30 power connector"
    
    spec = [
        type = "XT30"
        gender = _ // [male, female]
        current_rating = "30A"
        application = "RC Models"
    ]
    
    pins = [
        [1,2] = [VCC,GND]::DC(), ["Positive","Negative"]
    ]
}

// POWER.DEANS_T - 40 A two-pole T-form DC power connector (RC models) Component Definition

component POWER.DEANS_T()
{
    name = "Deans T Connector"
    description = "Deans T power connector"
    
    spec = [
        type = "Deans T"
        gender = _ // [male, female]
        current_rating = "40A"
        application = "RC Models"
    ]
    
    pins = [
        [1,2] = [VCC,GND]::DC(), ["Positive","Negative"]
    ]
}

// POWER.ANDERSON - Modular multi-pole DC power connector, quantity pole pairs Component Definition

component POWER.ANDERSON(quantity::INT = 1)
{
    name = "Anderson Powerpole Connector"
    description = "Anderson Powerpole connector, " + quantity + " pole(s)"

    spec = [
        type = "Anderson Powerpole"
        current_rating = _ // [15A, 30A, 45A]
        pole_count = quantity
    ]
    
    pins = [
        1:quantity*2 = 1:quantity*2
    ]
}

// POWER.ATX - Computer power supply connector, type-parameterized Component Definition
// Note: type selects the pin map - main (24-pin), cpu, pcie, sata, or molex.

component POWER.ATX(type::STRING)
{
    name = "ATX Power Connector"
    description = "ATX " + type + " power connector"
    
    spec = [
        standard = "ATX"
        connector_type = type
    ]
    
    if type == "main"
        pins = [
            1 = P3V3, "+3.3V"
            2 = P3V3, "+3.3V"
            3 = GND, "GND"
            4 = P5V, "+5V"
            5 = GND, "GND"
            6 = P5V, "+5V"
            7 = GND, "GND"
            8 = PG, "PG"
            9 = P5VSB, "+5VSB"
            10 = P12V, "12V"
            11 = P12V, "12V"
            12 = P3V3, "+3.3V"
            13 = N12V, "-12V"
            14 = PSON, "PSON"
            15 = GND, "GND"
            16 = GND, "GND"
            17 = GND, "GND"
            18 = GND, "GND"
        ]
    else if type == "cpu"
        pins = [
            1 = GND, "GND"
            2 = GND, "GND"
            3 = GND, "GND"
            4 = GND, "GND"
            5 = P12V, "12V"
            6 = P12V, "12V"
            7 = P12V, "12V"
            8 = P12V, "12V"
        ]
    else if type == "pcie"
        pins = [
            1 = P12V, "12V"
            2 = P12V, "12V"
            3 = P12V, "12V"
            4 = GND, "GND"
            5 = GND, "GND"
            6 = GND, "GND"
        ]
    else if type == "sata"
        pins = [
            1 = P3V3, "+3.3V"
            2 = P3V3, "+3.3V"
            3 = GND, "GND"
            4 = P5V, "+5V"
            5 = P5V, "+5V"
            6 = GND, "GND"
            7 = P12V, "12V"
            8 = P12V, "12V"
        ]
    else if type == "molex"
        pins = [
            1 = P12V, "12V"
            2 = P12V, "12V"
            3 = GND, "GND"
            4 = P5V, "+5V"
        ]
    else
        error("POWER.ATX: type must be main, cpu, pcie, sata, or molex, got " + type)
}

// Usage Examples:
// 1. DC power jack
// POWER.DC_JACK("center_positive")

// 2. XT60 connector (no parameters)
// POWER.XT60()

// 3. Anderson Powerpole connector
// POWER.ANDERSON(2)

// 4. ATX main connector
// POWER.ATX("main")