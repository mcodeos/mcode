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

interface ADC.DIFF(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [1Mbps@0.5m, 10Mbps@0.1m]
    voltage = [3.3V,5V]
    input_range = ±10V
    resolution = [8bit,10bit,12bit,16bit]

    // ADC.DIFF (Differential ADC) Standard Definition
    // Core Rule: Differential analog-to-digital converter interface for high-precision measurements
    // Differential Input: Measures the voltage difference between P (positive) and N (negative) inputs
    // Advantage: Rejects common-mode noise, improves signal-to-noise ratio
    // Applications: Sensor measurements, audio, industrial control systems

    pins = [ 
        1 = P, "Positive Input"   // Positive differential input
        2 = N, "Negative Input"   // Negative differential input
        3 = GND, "Ground"         // Signal reference ground
    ]
    
    role Transmitter {  // ADC.DIFF Transmitter - Sensor or signal source
        name = "ADC.DIFF Transmitter"
        peer = Receiver
    }
    role Receiver {  // ADC.DIFF Receiver - ADC converter
        name = "ADC.DIFF Receiver"
        peer = Transmitter
    }
}
