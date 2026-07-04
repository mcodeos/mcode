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

interface DC(volt::UV.VOLT = 5V, role) // DC Power Supply Interface
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 3m
    voltage = volt

    // DC Power Supply Standard Definition
    // Core Rule: Unidirectional direct current power supply
    // Voltage Levels: Supports various standard DC voltages
    // Device Definition: Source = Power supply, Sink = Powered device
    // Applications: Powering electronic circuits and devices

    // Positive Voltage Supplies
    if (volt == 1.2V)
        pins = [
            1 = VCC1V2, "DC power positive", voltage:1.2V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 1.5V)
        pins = [
            1 = VCC1V5, "DC power positive", voltage:1.5V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 1.8V)
        pins = [
            1 = VCC1V8, "DC power positive", voltage:1.8V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 2.5V)
        pins = [
            1 = VCC2V5, "DC power positive", voltage:2.5V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 3.0V)
        pins = [
            1 = VCC3V0, "DC power positive", voltage:3.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 3.3V)
        pins = [
            1 = VCC3V3, "DC power positive", voltage:3.3V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 4.5V)
        pins = [
            1 = VCC4V5, "DC power positive", voltage:4.5V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 5.0V)
        pins = [
            1 = VCC5V0, "DC power positive", voltage:5.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 6.0V)
        pins = [
            1 = VCC6V0, "DC power positive", voltage:6.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 7.5V)
        pins = [
            1 = VCC7V5, "DC power positive", voltage:7.5V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 9.0V)
        pins = [
            1 = VCC9V0, "DC power positive", voltage:9.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 12.0V)
        pins = [
            1 = VCC12V0, "DC power positive", voltage:12.0V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == 15.0V)
        pins = [
            1 = VCC15V0, "DC power positive", voltage:15.0V
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
    else if (volt == -1.5V)
        pins = [
            1 = VCC1V5N, "DC power negative", voltage:-1.5V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == -1.8V)
        pins = [
            1 = VCC1V8N, "DC power negative", voltage:-1.8V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == -2.5V)
        pins = [
            1 = VCC2V5N, "DC power negative", voltage:-2.5V
            2 = GND, "DC power ground", voltage:0.0V
        ]
    else if (volt == -3.0V)
        pins = [
            1 = VCC3V0N, "DC power negative", voltage:-3.0V
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
    else
        pins = [
            1 = VCC, "DC power positive", voltage:volt
            2 = GND, "DC power ground", voltage:0.0V
        ]

    // Role definitions
    role Source {
        name = "DC Power Source"
        peer = Sink
    }
    
    role Sink {
        name = "DC Power Sink"
        peer = Source
    }
}
