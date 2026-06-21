# Copyright 2026 MCode Alliance
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

interface CAN(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 10km
    maxspeed = [10kbps@10km, 125kbps@500m, 1Mbps@40m]
    voltage = 5V
    receiver = ±5V
    output = ±5V

    // CAN (Controller Area Network) Standard Definition
    // Core Rule: Differential signaling for robust communication in noisy environments
    // CAN Level Spec: High = CAN_H - CAN_L > 1.5V (Logic 0), Low = CAN_H - CAN_L < 0.5V (Logic 1)
    // Device Definition: Node = Any device on the CAN bus
    // Versions: CAN 2.0 (Standard/Extended), CAN FD (Flexible Data Rate)

    pins = [
        1 = CAN_H, "CAN High"    // High side of differential signal
        2 = CAN_L, "CAN Low"    // Low side of differential signal
        3 = GND, "Ground"        // Signal reference ground
    ]
    
    role Node {
        name = "CAN Node"
        peer = Node
    }
}
