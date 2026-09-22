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
// Device Definition: Provider = the side that offers the line (MCU/SoC),
//                    Consumer = the side that uses it (any digital device)
// Applications: LEDs, buttons, relays, digital sensors
//
// A GPIO unit is a single pin: one instance per general-purpose line.
//   GPIO3::GPIO(Provider)      -> one GPIO line
//   GPIO[3, 4]::GPIO(Provider) -> members GPIO3, GPIO4, one pin each
interface GPIO(role)
{
    topology = "point to point"
    mode = ["input", "output", "bidirectional"]
    maxdistance = 0.1m
    maxspeed = [100MHz]
    voltage = [1.8V,3.3V,5V]

    // @drive(pp) — the member row's electrical nature (candidate A of
    // interface-member-config-design.md §2): a general-purpose GPIO pin is
    // push-pull by default. A device that drives a GPIO line open-drain
    // states `@drive(od)` (and `@pull` where it relies on one) on its own
    // adoption row, which overrides this lib-side default per pin.
    pins = [
        1 = _ @drive(pp)
    ]

    role Provider {  // offers the line: MCU/SoC GPIO block
        name = "GPIO Provider"
        peer = Consumer
    }

    role Consumer {  // uses the line: any digital device
        name = "GPIO Consumer"
        peer = Provider
    }
}
