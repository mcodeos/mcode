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
// Board-to-Board Connector Definitions
// ---------------------------------------------------------------------------------------------

// Basic Board-to-Board Connector
component CONN.B2B(pin_count::INT)
{
    name = "Board-to-Board Connector"
    description = "Board-to-board connector"

    spec = [
        pin_count = pin_count // [2, 4, 6, 8, 10, 12, 16, 20, 24, 28, 32, 40]
        pitch = _ // [0.5mm, 0.65mm, 0.8mm, 1.0mm, 1.27mm, 2.0mm]
        stack_height = _ // [0.5mm, 1.0mm, 1.5mm, 2.0mm, 2.5mm, 3.0mm, 4.0mm, 5.0mm]
    ]

    pins = [
        1:pin_count = 1:pin_count
    ]
}

// Mezzanine Connector (High Density)
component CONN.MEZZANINE(pin_count::INT)
{
    name = "Mezzanine Connector"
    description = "High-density mezzanine connector"

    spec = [
        pin_count = pin_count // [10, 20, 30, 40, 50, 60, 80, 100]
        pitch = _ // [0.3mm, 0.4mm, 0.5mm, 0.65mm, 0.8mm]
        stack_height = _ // [0.5mm, 1.0mm, 1.5mm, 2.0mm, 2.5mm, 3.0mm]
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