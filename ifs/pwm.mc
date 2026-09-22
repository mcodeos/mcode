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
// Device Definition: Transmitter = PWM source (MCU timer output, driver IC),
//                    Receiver = PWM sink (motor driver input, LED, MOSFET gate)
// Applications: Motor speed control, LED dimming, servo position control
//
// A PWM channel is a single pin: one instance per channel.
//   PWM0::PWM(Transmitter)      -> one PWM channel
//   PWM0[1:4]::PWM(Transmitter) -> members PWM0.1 .. PWM0.4, one pin each
interface PWM(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [1MHz]
    voltage = [1.8V,3.3V,5V]

    // @drive(pp): a PWM output stage is push-pull by default, same library
    // default as GPIO. A device that drives the line open-drain states
    // `@drive(od)` on its own adoption row, which overrides this default.
    pins = [
        1 = _ @drive(pp)
    ]

    role Transmitter {  // PWM source: MCU timer output, driver IC
        name = "PWM Transmitter"
        peer = Receiver
    }

    role Receiver {  // PWM sink: motor driver input, LED, MOSFET gate
        name = "PWM Receiver"
        peer = Transmitter
    }
}
