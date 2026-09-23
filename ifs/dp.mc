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

// DP (DisplayPort) Standard Definition
// Core Rule: packetized video/audio main link plus a separate auxiliary channel
// Main Link: 1 / 2 / 4 lanes of AC-coupled differential pairs, 2.7 / 5.4 / 8.1 Gbps per lane
// Auxiliary Channel: bidirectional half-duplex differential pair (AUX +/-)
// HPD: single-ended hot-plug detect, sink-driven
// Differential Pair: all pairs 1st = positive (P/N convention, same as CLK.DIFF)
// Applications: GPU / SoC display output, embedded DP (eDP) panels

interface DP(role)
{
    topology = "point to point"
    mode = ["full duplex"]  // main link unidirectional, AUX bidirectional
    maxdistance = 3m
    maxspeed = [2.7Gbps@2m, 5.4Gbps@2m, 8.1Gbps@1m]  // RBR / HBR / HBR2+ per lane
    voltage = [1.8V, 3.3V]

    pins = [
        1 = ML0_P, "Main link lane 0 positive"
        2 = ML0_N, "Main link lane 0 negative"
        3 = ML1_P, "Main link lane 1 positive"
        4 = ML1_N, "Main link lane 1 negative"
        5 = ML2_P, "Main link lane 2 positive"
        6 = ML2_N, "Main link lane 2 negative"
        7 = ML3_P, "Main link lane 3 positive"
        8 = ML3_N, "Main link lane 3 negative"
        9 = AUX_P, "Auxiliary channel positive"
        10 = AUX_N, "Auxiliary channel negative"
        11 = HPD, "Hot plug detect"
    ]

    role Source {
        name = "DP Source"
        pins = [
            out 1 = ML0_P, "Main link lane 0 positive"  // The source drives the main link
            out 2 = ML0_N, "Main link lane 0 negative"
            out 3 = ML1_P, "Main link lane 1 positive"
            out 4 = ML1_N, "Main link lane 1 negative"
            out 5 = ML2_P, "Main link lane 2 positive"
            out 6 = ML2_N, "Main link lane 2 negative"
            out 7 = ML3_P, "Main link lane 3 positive"
            out 8 = ML3_N, "Main link lane 3 negative"
            io 9 = AUX_P, "Auxiliary channel positive"   // AUX is bidirectional half duplex
            io 10 = AUX_N, "Auxiliary channel negative"
            in 11 = HPD, "Hot plug detect"               // The sink drives HPD
        ]
        peer = Sink
    }
    role Sink {
        name = "DP Sink"
        pins = [
            in 1 = ML0_P, "Main link lane 0 positive"    // The sink receives the main link
            in 2 = ML0_N, "Main link lane 0 negative"
            in 3 = ML1_P, "Main link lane 1 positive"
            in 4 = ML1_N, "Main link lane 1 negative"
            in 5 = ML2_P, "Main link lane 2 positive"
            in 6 = ML2_N, "Main link lane 2 negative"
            in 7 = ML3_P, "Main link lane 3 positive"
            in 8 = ML3_N, "Main link lane 3 negative"
            io 9 = AUX_P, "Auxiliary channel positive"   // AUX is bidirectional half duplex
            io 10 = AUX_N, "Auxiliary channel negative"
            out 11 = HPD, "Hot plug detect"              // The sink asserts hot plug
        ]
        peer = Source
    }
}
