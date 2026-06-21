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

interface I2S(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 5m
    maxspeed = [8Mbps@5m, 16Mbps@2m, 32Mbps@1m]
    voltage = [1.8V,3.3V,5V]

    // I2S (Inter-IC Sound) Standard Definition
    // Core Rule: Three-wire digital audio bus for connecting audio devices
    // I2S Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: Transmitter = Sends audio data, Receiver = Receives audio data
    // Audio Format: Supports various sample rates and bit depths

    pins = [ 
        1 = SCK, "Bit Clock"       // Bit clock signal
        2 = SD, "Serial Data"      // Audio data
        3 = WS, "Word Select"      // Channel select (left/right)
    ]
    
    role Transmitter {  // I2S Transmitter - Sends audio data
        name = "I2S Transmitter"
        peer = Receiver
    }
    role Receiver {  // I2S Receiver - Receives audio data
        name = "I2S Receiver"
        peer = Transmitter
    }
}
