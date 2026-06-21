# Copyright 2026 MCode Alliance
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
component POWER.DC_JACK(polarity::STRING = "center_positive")
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
component POWER.ANDERSON(size::INT = 15, quantity::INT = 1)
{
    name = "Anderson Powerpole Connector"
    description = "Anderson Powerpole connector, " + size + "A rating, " + quantity + " pole(s)"
    
    spec = [
        type = "Anderson Powerpole"
        current_rating = size + "A"
        pole_count = quantity
    ]
    
    pins = [
        1:quantity*2 = 1:quantity*2
    ]
}

// ATX Power Connector (Computer Power Supply)
component POWER.ATX(type::STRING = "main")
{
    name = "ATX Power Connector"
    description = "ATX " + type + " power connector"
    
    spec = [
        standard = "ATX"
        connector_type = type
    ]
    
    if type == "main"
        pins = [
            1 = 1, "+3.3V"
            2 = 2, "+3.3V"
            3 = 3, "GND"
            4 = 4, "+5V"
            5 = 5, "GND"
            6 = 6, "+5V"
            7 = 7, "GND"
            8 = 8, "PG"
            9 = 9, "+5VSB"
            10 = 10, "12V"
            11 = 11, "12V"
            12 = 12, "+3.3V"
            13 = 13, "-12V"
            14 = 14, "PSON"
            15 = 15, "GND"
            16 = 16, "GND"
            17 = 17, "GND"
            18 = 18, "GND"
        ]
    else if type == "cpu"
        pins = [
            1 = 1, "GND"
            2 = 2, "GND"
            3 = 3, "GND"
            4 = 4, "GND"
            5 = 5, "12V"
            6 = 6, "12V"
            7 = 7, "12V"
            8 = 8, "12V"
        ]
    else if type == "pcie"
        pins = [
            1 = 1, "12V"
            2 = 2, "12V"
            3 = 3, "12V"
            4 = 4, "GND"
            5 = 5, "GND"
            6 = 6, "GND"
        ]
    else if type == "sata"
        pins = [
            1 = 1, "+3.3V"
            2 = 2, "+3.3V"
            3 = 3, "GND"
            4 = 4, "+5V"
            5 = 5, "+5V"
            6 = 6, "GND"
            7 = 7, "12V"
            8 = 8, "12V"
        ]
    else if type == "molex"
        pins = [
            1 = 1, "12V"
            2 = 2, "12V"
            3 = 3, "GND"
            4 = 4, "+5V"
        ]
    else
        pins = [
            1 = 1, "Pin 1"
            2 = 2, "Pin 2"
        ]
}

// Usage Examples:
// 1. DC power jack
// POWER.DC_JACK(5.5mm, 2.1mm, "center_positive")

// 2. XT60 connector
// POWER.XT60("male")

// 3. Anderson Powerpole connector
// POWER.ANDERSON(30, 2)

// 4. ATX main connector
// POWER.ATX("main")