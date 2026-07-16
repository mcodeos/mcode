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

// GPIO (General Purpose Input/Output) Standard Definition
// Core Rule: General purpose digital input/output pins
// GPIO Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
// Device Definition: Controller = Microcontroller, Peripheral = Any digital device
// Applications: LEDs, buttons, relays, digital sensors
//
// count::INT — number of GPIO pins (default 1)
//   GPIO(1, Controller)   → single pin:  1 = 1
//   GPIO(4, Peripheral)   → 4 pins:      1..4 = 1..4
interface GPIO(count::INT = 1, role = Controller)
{
    topology = "point to point"
    mode = ["input", "output", "bidirectional"]
    maxdistance = 0.1m
    maxspeed = [100MHz]
    voltage = [1.8V,3.3V,5V]

    // Dynamic pin generation: 1:count = 1:count (same pattern as HDR_SINGLE)
    // count=1 → pin 1 = 1
    // count=4 → pins 1..4 = 1..4
    pins = [
        1:count = 1:count
    ]

    role Controller {
        name = "GPIO Controller"
        peer = Peripheral
    }

    role Peripheral {
        name = "GPIO Peripheral"
        peer = Controller
    }
}
