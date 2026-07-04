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

// DAC
interface DAC(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [1MSPS]
    voltage = [3.3V, 5V]
    output_range = 0V ~ voltage
    resolution = [8bit,10bit,12bit,16bit]

    // DAC (Digital-to-Analog Converter) Standard Definition
    // Core Rule: Converts digital values to analog voltage
    // DAC Level Spec: Output voltage proportional to digital input
    // Device Definition: Controller = Microcontroller, Peripheral = Analog device
    // Applications: Audio output, signal generation, motor control

    pins = [
        1 = OUT, "Analog Output"    // Analog output voltage
        2 = GND, "Ground"           // Signal reference ground
    ]
    
    role Controller {
        name = "DAC Controller"
        peer = Peripheral
    }
    
    role Peripheral {
        name = "DAC Peripheral"
        peer = Controller
    }
}
