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

// CLK.DIFF (Differential Clock Pair) Standard Definition
// Core Rule: Two-wire differential clock for reference/system clocking
// Differential Pair: the two rows tagged @pair(clk) are the two legs of one
// clock pair; the P/N spellings are the naming convention, same as ADC.DIFF.
// 2-wire: the ground reference is shared through the power supply (DC
// interface), same as ADC.DIFF / UART.TTL / I2C / SPI (Decision Record 2,
// spec/19 §9 -- no ground member here).
// Applications: refclk distribution, SYSCLK between clock generators and SoCs

interface CLK.DIFF(role)
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 0.5m
    maxspeed = [200MHz@0.5m, 800MHz@0.1m]
    voltage = [1.8V, 2.5V, 3.3V]

    pins = [
        1 = CLK_P @pair(clk)   // Positive differential clock
        2 = CLK_N @pair(clk)   // Negative differential clock
    ]

    role Transmitter {  // CLK.DIFF Transmitter - Clock generator or oscillator
        name = "CLK.DIFF Transmitter"
        peer = Receiver
    }
    role Receiver {  // CLK.DIFF Receiver - SoC, FPGA, or clock consumer
        name = "CLK.DIFF Receiver"
        peer = Transmitter
    }
}
