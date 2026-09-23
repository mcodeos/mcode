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

// ---------------------------------------------------------------------------------------------
// MIPI — DSI (display) and CSI (camera) D-PHY packet links
// ---------------------------------------------------------------------------------------------
// Both faces share the D-PHY shape: one differential clock pair plus data
// pairs; 1 / 2 / 4 data lanes are used and the rest stay unconnected.
// Differential Pair: every pair 1st = positive (P/N convention, same as CLK.DIFF).
// Ground reference rides the power supply (DC interface), no ground member.

// MIPI.DSI — Display Serial Interface (host to display)
interface MIPI.DSI(role)
{
    topology = "point to point"
    mode = ["unidirectional"]  // video mode; command mode replies ride DSI read packets
    maxdistance = 0.3m  // PCB traces / short flex
    maxspeed = [500Mbps@0.3m, 1.5Gbps@0.1m]  // per lane
    voltage = [1.8V, 1.2V]  // D-PHY supply domain

    pins = [
        1 = CLK_P, "D-PHY clock pair positive"
        2 = CLK_N, "D-PHY clock pair negative"
        3 = D0_P, "Data lane 0 positive"
        4 = D0_N, "Data lane 0 negative"
        5 = D1_P, "Data lane 1 positive"
        6 = D1_N, "Data lane 1 negative"
        7 = D2_P, "Data lane 2 positive"
        8 = D2_N, "Data lane 2 negative"
        9 = D3_P, "Data lane 3 positive"
        10 = D3_N, "Data lane 3 negative"
    ]

    role Host {
        name = "DSI Host (SoC display controller)"
        pins = [
            out 1 = CLK_P, "D-PHY clock pair positive"  // The host drives every lane
            out 2 = CLK_N, "D-PHY clock pair negative"  // (video mode; command-mode replies
            out 3 = D0_P, "Data lane 0 positive"        // ride the same lanes inbound)
            out 4 = D0_N, "Data lane 0 negative"
            out 5 = D1_P, "Data lane 1 positive"
            out 6 = D1_N, "Data lane 1 negative"
            out 7 = D2_P, "Data lane 2 positive"
            out 8 = D2_N, "Data lane 2 negative"
            out 9 = D3_P, "Data lane 3 positive"
            out 10 = D3_N, "Data lane 3 negative"
        ]
        peer = Display
    }
    role Display {
        name = "DSI Peripheral (display panel)"
        pins = [
            in 1 = CLK_P, "D-PHY clock pair positive"   // The panel receives
            in 2 = CLK_N, "D-PHY clock pair negative"
            in 3 = D0_P, "Data lane 0 positive"
            in 4 = D0_N, "Data lane 0 negative"
            in 5 = D1_P, "Data lane 1 positive"
            in 6 = D1_N, "Data lane 1 negative"
            in 7 = D2_P, "Data lane 2 positive"
            in 8 = D2_N, "Data lane 2 negative"
            in 9 = D3_P, "Data lane 3 positive"
            in 10 = D3_N, "Data lane 3 negative"
        ]
        peer = Host
    }
}

// MIPI.CSI — Camera Serial Interface (camera to host)
interface MIPI.CSI(role)
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 0.3m
    maxspeed = [500Mbps@0.3m, 2.5Gbps@0.1m]  // per lane
    voltage = [1.8V, 1.2V]

    pins = [
        1 = CLK_P, "D-PHY clock pair positive"
        2 = CLK_N, "D-PHY clock pair negative"
        3 = D0_P, "Data lane 0 positive"
        4 = D0_N, "Data lane 0 negative"
        5 = D1_P, "Data lane 1 positive"
        6 = D1_N, "Data lane 1 negative"
        7 = D2_P, "Data lane 2 positive"
        8 = D2_N, "Data lane 2 negative"
        9 = D3_P, "Data lane 3 positive"
        10 = D3_N, "Data lane 3 negative"
    ]

    role Sensor {
        name = "CSI Transmitter (camera sensor)"
        pins = [
            out 1 = CLK_P, "D-PHY clock pair positive"  // The sensor drives every lane
            out 2 = CLK_N, "D-PHY clock pair negative"
            out 3 = D0_P, "Data lane 0 positive"
            out 4 = D0_N, "Data lane 0 negative"
            out 5 = D1_P, "Data lane 1 positive"
            out 6 = D1_N, "Data lane 1 negative"
            out 7 = D2_P, "Data lane 2 positive"
            out 8 = D2_N, "Data lane 2 negative"
            out 9 = D3_P, "Data lane 3 positive"
            out 10 = D3_N, "Data lane 3 negative"
        ]
        peer = Host
    }
    role Host {
        name = "CSI Receiver (SoC ISP)"
        pins = [
            in 1 = CLK_P, "D-PHY clock pair positive"   // The ISP samples them
            in 2 = CLK_N, "D-PHY clock pair negative"
            in 3 = D0_P, "Data lane 0 positive"
            in 4 = D0_N, "Data lane 0 negative"
            in 5 = D1_P, "Data lane 1 positive"
            in 6 = D1_N, "Data lane 1 negative"
            in 7 = D2_P, "Data lane 2 positive"
            in 8 = D2_N, "Data lane 2 negative"
            in 9 = D3_P, "Data lane 3 positive"
            in 10 = D3_N, "Data lane 3 negative"
        ]
        peer = Sensor
    }
}
