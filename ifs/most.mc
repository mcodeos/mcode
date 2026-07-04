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

// MOST (Media Oriented Systems Transport)
interface MOST(role)
{
    topology = "ring"
    mode = ["full duplex"]
    maxdistance = 40m
    maxspeed = [22.5Mbps, 50Mbps, 150Mbps]
    voltage = 3.3V

    // MOST Standard Definition
    // Core Rule: High-speed multimedia network for in-vehicle entertainment systems
    // MOST Level Spec: Optical or electrical signaling
    // Device Definition: Master = Controls the bus, Slave = Audio/Video device
    // Applications: In-car infotainment, navigation, audio/video distribution

    pins = [
        1 = OPT, "Optical"    // Optical fiber connection
        2 = ELE, "Electrical" // Electrical connection (alternative)
    ]
    
    role Master {
        name = "MOST Master"
        peer = Slave
    }
    
    role Slave {
        name = "MOST Slave"
        peer = Master
    }
}
