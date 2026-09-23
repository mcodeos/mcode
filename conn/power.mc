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

// ---------------------------------------------------------------------------------------------
// Power Connector Definitions
// ---------------------------------------------------------------------------------------------

// DC Power Jack (Barrel Connector)
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

// XT60 Connector (Commonly used in RC models)
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

// XT30 Connector (Smaller version of XT60)
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

// Deans T Connector (Commonly used in RC models)
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

// Anderson Powerpole Connector
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

// ATX Power Connector (Computer Power Supply)
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