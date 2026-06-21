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

// LIN (Local Interconnect Network)
interface LIN(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 40m
    maxspeed = [20kbps]
    voltage = 12V

    // LIN Standard Definition
    // Core Rule: Low-cost, low-speed serial communication for automotive body electronics
    // LIN Level Spec: Single wire with ground reference
    // Device Definition: Master = Controls the bus, Slave = Body electronics module
    // Applications: Power windows, door locks, seat controls, lighting

    pins = [
        1 = LIN, "Data"    // Single wire data line
        2 = GND, "Ground"  // Signal reference ground
    ]
    
    role Master {
        name = "LIN Master"
        peer = Slave
    }
    
    role Slave {
        name = "LIN Slave"
        peer = Master
    }
}
