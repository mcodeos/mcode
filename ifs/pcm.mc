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

interface PCM(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 2m
    maxspeed = [32Mbps@2m, 64Mbps@1m]
    voltage = [1.8V,3.3V,5V]

    // PCM (Pulse Code Modulation) Standard Definition
    // Core Rule: Digital audio interface for connecting audio CODECs to processors
    // PCM Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: Transmitter = Sends audio data, Receiver = Receives audio data
    // Audio Format: Supports various sample rates and bit depths

    pins = [ 
        1 = CLK, "Bit Clock"        // Bit clock signal
        2 = SYNC, "Frame Sync"      // Frame synchronization signal
        in 3 = IN, "Audio Input"    // Audio data input
        out 4 = OUT, "Audio Output"  // Audio data output
        5 = GND, "Ground"           // Ground
     ]
    
    role Transmitter {  // PCM Transmitter - Sends audio data
        name = "PCM Transmitter"
        peer = Receiver
    }
    role Receiver {  // PCM Receiver - Receives audio data
        name = "PCM Receiver"
        peer = Transmitter
    }
}
