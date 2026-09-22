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

// DAC.SINGLE (Single-Ended Analog Output) Standard Definition
// Core Rule: One-wire single-ended analog voltage output
// 1 wire: the reference is the analog ground domain, shared through the
// power supply (DC interface), same as ADC.DIFF / UART.TTL / I2C / SPI
// (Decision Record 2, spec/19 §9 -- no ground member here).
// The @class(analog) row attribute is the library-default signal class:
// adopting components inherit it and may override by ordinal.
// Applications: sensor adoption (analog-output sensors), audio line-out,
// control/reference outputs

interface DAC.SINGLE(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.5m
    maxspeed = [1MSPS]
    voltage = [3.3V, 5V]
    output_range = 0V ~ voltage
    resolution = [8bit,10bit,12bit,16bit]

    pins = [
        1 = OUT @class(analog)   // Single-ended analog output, referenced to analog ground
    ]

    role Transmitter {  // DAC.SINGLE Transmitter - DAC converter or signal source
        name = "DAC.SINGLE Transmitter"
        peer = Receiver
    }
    role Receiver {  // DAC.SINGLE Receiver - Analog consumer
        name = "DAC.SINGLE Receiver"
        peer = Transmitter
    }
}
