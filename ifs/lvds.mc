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

// LVDS (Low-Voltage Differential Signaling) Standard Definition
// Core Rule: generic low-voltage differential link: one clock pair plus data pairs
// Canonical face: 1 clock pair + 4 data pairs (use a subset and leave the rest unconnected)
// Differential Pair: every pair 1st = positive (P/N convention, same as CLK.DIFF)
// 10-wire: ground reference is shared through the power supply (DC interface),
// same as ADC.DIFF / UART.TTL / CLK.DIFF (no ground member here)
// Applications: panel links, FPGA-to-FPGA high-speed data, serializer/deserializer links

interface LVDS(role)
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 0.5m
    maxspeed = [400Mbps@0.5m, 1.6Gbps@0.1m]  // per pair, distance-limited
    voltage = [1.8V, 2.5V, 3.3V]  // LVDS swing is ~350mV around this common-mode

    pins = [
        1 = CLK_P, "Differential clock positive"
        2 = CLK_N, "Differential clock negative"
        3 = D0_P, "Data pair 0 positive"
        4 = D0_N, "Data pair 0 negative"
        5 = D1_P, "Data pair 1 positive"
        6 = D1_N, "Data pair 1 negative"
        7 = D2_P, "Data pair 2 positive"
        8 = D2_N, "Data pair 2 negative"
        9 = D3_P, "Data pair 3 positive"
        10 = D3_N, "Data pair 3 negative"
    ]

    role Driver {
        name = "LVDS Driver"
        pins = [
            out 1 = CLK_P, "Differential clock positive"  // The serializer drives every pair
            out 2 = CLK_N, "Differential clock negative"
            out 3 = D0_P, "Data pair 0 positive"
            out 4 = D0_N, "Data pair 0 negative"
            out 5 = D1_P, "Data pair 1 positive"
            out 6 = D1_N, "Data pair 1 negative"
            out 7 = D2_P, "Data pair 2 positive"
            out 8 = D2_N, "Data pair 2 negative"
            out 9 = D3_P, "Data pair 3 positive"
            out 10 = D3_N, "Data pair 3 negative"
        ]
        peer = Receiver
    }
    role Receiver {
        name = "LVDS Receiver"
        pins = [
            in 1 = CLK_P, "Differential clock positive"   // The deserializer samples them
            in 2 = CLK_N, "Differential clock negative"
            in 3 = D0_P, "Data pair 0 positive"
            in 4 = D0_N, "Data pair 0 negative"
            in 5 = D1_P, "Data pair 1 positive"
            in 6 = D1_N, "Data pair 1 negative"
            in 7 = D2_P, "Data pair 2 positive"
            in 8 = D2_N, "Data pair 2 negative"
            in 9 = D3_P, "Data pair 3 positive"
            in 10 = D3_N, "Data pair 3 negative"
        ]
        peer = Driver
    }
}
