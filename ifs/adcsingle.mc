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

// ADC.SINGLE (Single-Ended Analog Input) Standard Definition
// Core Rule: One-wire single-ended analog voltage input
// 1 wire: the reference is the analog ground domain, shared through the
// power supply (DC interface), same as ADC.DIFF / UART.TTL / I2C / SPI
// (Decision Record 2, spec/19 §9 -- no ground member here).
// The @class(analog) row attribute is the library-default signal class:
// adopting components inherit it and may override by ordinal.
// Applications: sensor adoption (analog sensors), audio line-in, control loops

interface ADC.SINGLE(role)
{
    topology = "point to point"
    mode = ["input"]
    maxdistance = 0.5m
    maxspeed = [1MSPS]
    voltage = [3.3V, 5V]
    input_range = 0V ~ voltage
    resolution = [8bit,10bit,12bit,16bit]

    pins = [
        1 = IN @class(analog)   // Single-ended analog input, referenced to analog ground
    ]

    role Transmitter {  // ADC.SINGLE Transmitter - Sensor or signal source
        name = "ADC.SINGLE Transmitter"
        peer = Receiver
    }
    role Receiver {  // ADC.SINGLE Receiver - ADC converter or analog front-end
        name = "ADC.SINGLE Receiver"
        peer = Transmitter
    }
}
