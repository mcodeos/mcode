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

// CLK (Single-Ended Clock) Standard Definition
// Core Rule: One-wire unidirectional clock line
// 1 wire: the ground reference is shared through the power supply (DC
// interface), same as CLK.DIFF / ADC.SINGLE / UART.TTL (no ground member
// here).
// Family: CLK.DIFF (ifs/clkdiff.mc) covers the differential clock pair; CLK
// covers the single-ended line. Roles follow CLK.DIFF's Transmitter/Receiver
// naming -- this face is genuinely unidirectional, so the direction pair is
// the right pair here, unlike XTAL's circuit-identity pair (U200 §3).
// Applications: active oscillator module outputs (OSC), clock distribution,
// external clock input pins of SoCs / MCUs.

interface CLK(role)
{
    topology = "point to point"
    mode = ["unidirectional"]

    pins = [
        1 = CLK   // Single-ended clock
    ]

    role Transmitter {  // Clock generator: active oscillator module or clock driver
        name = "CLK Transmitter"
        peer = Receiver
    }
    role Receiver {  // Clock consumer: SoC, FPGA, or MCU clock input
        name = "CLK Receiver"
        peer = Transmitter
    }
}
