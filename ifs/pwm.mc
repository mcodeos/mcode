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

// PWM (Pulse Width Modulation) Standard Definition
// Core Rule: Digital signal with adjustable duty cycle
// PWM Level Spec: High = VCC, Low = GND
// Device Definition: Controller = Microcontroller, Peripheral = Device controlled by PWM
// Applications: Motor speed control, LED dimming, servo position control
//
// count::INT — number of PWM channels (default 1)
//   PWM(4, Controller) → 4 channels: 1..4 = 1..4
interface PWM(count::INT = 1, role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [1MHz]
    voltage = [1.8V,3.3V,5V]

    pins = [
        1:count = 1:count
    ]

    role Controller {
        name = "PWM Controller"
        peer = Peripheral
    }

    role Peripheral {
        name = "PWM Peripheral"
        peer = Controller
    }
}
