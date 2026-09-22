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
// IDC Ribbon Cable Socket Definitions
// ---------------------------------------------------------------------------------------------
// Insulation-displacement socket for flat ribbon cable, two rows, even contact
// count. Contact numbering follows the ribbon: odd row 1..n, even row n+1..2n
// as printed on standard ribbon shrouds. Physical face = counted plain pins,
// no interface binding (U193 physical-socket ruling).

// IDC Ribbon Cable Socket
component IDC(pin_count::INT)
{
    name = "IDC Ribbon Cable Socket"
    description = "Two-row insulation-displacement ribbon cable socket"

    spec = [
        pin_count = pin_count // [10, 14, 16, 20, 26, 34, 40, 50, 64]
        pitch = 2.54mm
        keying = _ // [shrouded box, notch, key slot]
        rohs = _
    ]

    pins = [
        1:pin_count = 1:pin_count
    ]
}

// Usage Examples:
// 1. 2x5 ribbon socket (10 way)
// IDC(10)
//
// 2. 2x10 ribbon socket (20 way)
// IDC(20)
