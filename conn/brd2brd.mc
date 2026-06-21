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
// Board-to-Board Connector Definitions
// ---------------------------------------------------------------------------------------------

// Basic Board-to-Board Connector
component CONN.B2B()
{
    name = "Board-to-Board Connector"
    description = "Board-to-board connector"
    
    spec = [
        pin_count = _ // [2, 4, 6, 8, 10, 12, 16, 20, 24, 28, 32, 40]
        pitch = _ // [0.5mm, 0.65mm, 0.8mm, 1.0mm, 1.27mm, 2.0mm]
        stack_height = _ // [0.5mm, 1.0mm, 1.5mm, 2.0mm, 2.5mm, 3.0mm, 4.0mm, 5.0mm]
    ]
    
    pins = [
        // Generate pins dynamically based on pin_count
        // For simplicity, we'll define up to 40 pins here
        1 = 1, "Pin 1"
        2 = 2, "Pin 2"
        3 = 3, "Pin 3"
        4 = 4, "Pin 4"
        5 = 5, "Pin 5"
        6 = 6, "Pin 6"
        7 = 7, "Pin 7"
        8 = 8, "Pin 8"
        9 = 9, "Pin 9"
        10 = 10, "Pin 10"
        11 = 11, "Pin 11"
        12 = 12, "Pin 12"
        13 = 13, "Pin 13"
        14 = 14, "Pin 14"
        15 = 15, "Pin 15"
        16 = 16, "Pin 16"
        17 = 17, "Pin 17"
        18 = 18, "Pin 18"
        19 = 19, "Pin 19"
        20 = 20, "Pin 20"
        21 = 21, "Pin 21"
        22 = 22, "Pin 22"
        23 = 23, "Pin 23"
        24 = 24, "Pin 24"
        25 = 25, "Pin 25"
        26 = 26, "Pin 26"
        27 = 27, "Pin 27"
        28 = 28, "Pin 28"
        29 = 29, "Pin 29"
        30 = 30, "Pin 30"
        31 = 31, "Pin 31"
        32 = 32, "Pin 32"
        33 = 33, "Pin 33"
        34 = 34, "Pin 34"
        35 = 35, "Pin 35"
        36 = 36, "Pin 36"
        37 = 37, "Pin 37"
        38 = 38, "Pin 38"
        39 = 39, "Pin 39"
        40 = 40, "Pin 40"
    ]
}

// Mezzanine Connector (High Density)
component CONN.MEZZANINE()
{
    name = "Mezzanine Connector"
    description = "High-density mezzanine connector"
    
    spec = [
        pin_count = _ // [10, 20, 30, 40, 50, 60, 80, 100]
        pitch = _ // [0.3mm, 0.4mm, 0.5mm, 0.65mm, 0.8mm]
        stack_height = _ // [0.5mm, 1.0mm, 1.5mm, 2.0mm, 2.5mm, 3.0mm]
    ]
    
    pins = [
        // Generate pins dynamically based on pin_count
        1 = 1, "Pin 1"
        2 = 2, "Pin 2"
        3 = 3, "Pin 3"
        4 = 4, "Pin 4"
        5 = 5, "Pin 5"
        6 = 6, "Pin 6"
        7 = 7, "Pin 7"
        8 = 8, "Pin 8"
        9 = 9, "Pin 9"
        10 = 10, "Pin 10"
        11 = 11, "Pin 11"
        12 = 12, "Pin 12"
        13 = 13, "Pin 13"
        14 = 14, "Pin 14"
        15 = 15, "Pin 15"
        16 = 16, "Pin 16"
        17 = 17, "Pin 17"
        18 = 18, "Pin 18"
        19 = 19, "Pin 19"
        20 = 20, "Pin 20"
    ]
}

// Usage Examples:
// 1. Basic board-to-board connector
// CONN.B2B(16, 0.8mm, 2.5mm)

// 2. High-density mezzanine connector
// CONN.MEZZANINE(40, 0.5mm, 1.5mm)