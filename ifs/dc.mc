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
// DC Power Supply Interface
// ---------------------------------------------------------------------------------------------

interface DC(volt::UV.VOLT) // DC Power Supply Interface
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 3m
    voltage = volt

    // DC Power Supply Standard Definition
    // Core Rule: Unidirectional direct current power supply
    // Voltage Levels: Standard rails (1.2/1.8/3.3/5/12/24/48 V) get canonical
    //   net names (VCC1V2, VCC5V0N, ...). Any other voltage falls back to a
    //   sign-aware generic name: VCC for positive rails, VEE for negative.
    // Energy direction is not a DC parameter (role slot removed 2026-09-07):
    // source/sink rides on the adopting terminal's direction word
    // (psrc = source / psnk = sink / psbi = bidir) at the pin/port level.
    // Applications: Powering electronic circuits and devices

    // Positive Voltage Supplies
    if (volt == 1.2V)
        pins = [
            1 = VCC1V2, "DC power positive", voltage:1.2V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 1.8V)
        pins = [
            1 = VCC1V8, "DC power positive", voltage:1.8V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 3.3V)
        pins = [
            1 = VCC3V3, "DC power positive", voltage:3.3V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 5.0V)
        pins = [
            1 = VCC5V0, "DC power positive", voltage:5.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 12.0V)
        pins = [
            1 = VCC12V0, "DC power positive", voltage:12.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 24.0V)
        pins = [
            1 = VCC24V0, "DC power positive", voltage:24.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 48.0V)
        pins = [
            1 = VCC48V0, "DC power positive", voltage:48.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    // Negative Voltage Supplies
    else if (volt == -1.2V)
        pins = [
            1 = VCC1V2N, "DC power negative", voltage:-1.2V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == -1.8V)
        pins = [
            1 = VCC1V8N, "DC power negative", voltage:-1.8V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == -3.3V)
        pins = [
            1 = VCC3V3N, "DC power negative", voltage:-3.3V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == -5.0V)
        pins = [
            1 = VCC5V0N, "DC power negative", voltage:-5.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == -12.0V)
        pins = [
            1 = VCC12V0N, "DC power negative", voltage:-12.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == -24.0V)
        pins = [
            1 = VCC24V0N, "DC power negative", voltage:-24.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == -48.0V)
        pins = [
            1 = VCC48V0N, "DC power negative", voltage:-48.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    // Non-standard voltages: sign-aware generic naming
    else if (volt < 0)
        pins = [
            1 = VEE, "DC power negative", voltage:volt
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else
        pins = [
            1 = VCC, "DC power positive", voltage:volt
            2 = GND, "DC power ground", voltage:0.0V
        ]

}
