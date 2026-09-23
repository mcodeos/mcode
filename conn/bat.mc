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
// BAT — battery holder (mechanical contact face; the cell itself is a DC.BAT source)
// ---------------------------------------------------------------------------------------------

// Coin-cell holder (RTC backup and similar)
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

# Usage Examples:
# BAT.HOLDER() rtc_bat1
# rtc_bat1.1 -> rtc_vbak        // pin 1 = "+" contact
# rtc_bat1.2 -> gnd             // pin 2 = "-" contact
