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

// FlexRay
interface FLEXRAY(role)
{
    topology = "star"
    mode = ["full duplex"]
    maxdistance = 10m
    maxspeed = [10Mbps]
    voltage = 5V

    // FlexRay Standard Definition
    // Core Rule: Deterministic, fault-tolerant communication for automotive applications
    // FlexRay Level Spec: Differential signaling, dual-channel redundancy
    // Device Definition: Node = Any device on the FlexRay bus
    // Applications: Automotive drive-by-wire systems, brake-by-wire, steering systems

    pins = [
        1 = CH_A\+, "Channel A Positive"    // Positive differential signal for channel A
        2 = CH_A\-, "Channel A Negative"    // Negative differential signal for channel A
        3 = CH_B\+, "Channel B Positive"    // Positive differential signal for channel B
        4 = CH_B\-, "Channel B Negative"    // Negative differential signal for channel B
        5 = GND, "Ground"                  // Signal reference ground
    ]
    
    role Node {
        name = "FlexRay Node"
        pins = [
            io 1 = CH_A\+, "Channel A Positive"  // TDMA time-share: a node drives its own slot
            io 2 = CH_A\-, "Channel A Negative"  // and listens on every other slot
            io 3 = CH_B\+, "Channel B Positive"
            io 4 = CH_B\-, "Channel B Negative"
            5 = GND, "Ground"                    // Signal reference ground
        ]
        peer = Node
    }
}
