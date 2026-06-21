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

// 1-Wire
interface ONEWIRE(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 100m
    maxspeed = [16kbps]
    voltage = [1.8V,3.3V,5V]

    // 1-Wire Standard Definition
    // Core Rule: Single wire communication with parasitic power
    // 1-Wire Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: Master = Initiates communication, Slave = Responds to master
    // Applications: Temperature sensors (DS18B20), EEPROM, iButton

    pins = [
        1 = DQ, "Data"    // Bidirectional data line
    ]
    
    role Master {
        name = "1-Wire Master"
        peer = Slave
    }
    
    role Slave {
        name = "1-Wire Slave"
        peer = Master
    }
}
