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

// PMBus Standard Definition
// Core Rule: power-management bus on an SMBus base (I2C variant family, same
// shape precedent as I2C.SMBUS) with the power-specific additions:
// SMBALERT becomes the power ALERT line, plus the CONTROL line that enables /
// sequences power converters
// Applications: VRM / point-of-load converters, hot-swap controllers, power
// supply telemetry and sequencing

interface PMBUS(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    maxdistance = 1m  // on-board / shelf
    maxspeed = [100kbps@1m, 400kbps@0.5m]  // PMBus 100 kHz base, 400 kHz high speed
    voltage = [3.3V]
    pullup = 1kΩ ~ 10kΩ

    pins = [
        1 = SCL, "Serial Clock"
        2 = SDA, "Serial Data"
        3 = ALERT, "PMBus Alert (SMBALERT)"
        4 = CONTROL, "Enable / sequencing control line"
    ]

    role Host {
        name = "PMBus Host (system manager)"
        peer = Slave
    }
    role Slave {
        name = "PMBus Slave (power device)"
        peer = Host
    }
}
