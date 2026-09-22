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

// AMP.BTL (Bridge-Tied-Load Audio Output) Standard Definition
// Core Rule: Two anti-phase single-ended outputs drive both ends of one load
// Bridge Drive: N is the anti-phase leg of P, so the load sees P - N swing
// Difference from ADC.DIFF: this is a power drive pair, not a measurement
// pair; the receiver is a passive load (speaker, haptic actuator)
// Applications: speaker drivers, class-AB/class-D audio amplifiers
// 2-wire (P/N): no ground reference of its own; the load floats across the
// pair and each leg may carry its own ESD return, same ground domain rules
// as ADC.DIFF.

interface AMP.BTL(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.5m
    voltage = [3.3V,5V]
    output_power = [1W,3W]
    load = [4Ohm,8Ohm]
    diff_pair = [P, N]   // P and N are the two faces of one bridge drive; 1st = positive phase

    // The @class(analog) row attribute is the library-default signal class
    // (same as ADC.SINGLE / ADC.DIFF): a bridge drive is an analog power
    // output face even when the amplifier stage is class D.
    pins = [
        1 = P @class(analog), "Positive BTL Output"   // Positive-phase bridge leg
        2 = N @class(analog), "Negative BTL Output"   // Anti-phase bridge leg
    ]

    role Transmitter {  // AMP.BTL Transmitter - Amplifier BTL output stage
        name = "AMP.BTL Transmitter"
        peer = Receiver
    }
    role Receiver {  // AMP.BTL Receiver - Speaker or other passive load
        name = "AMP.BTL Receiver"
        peer = Transmitter
    }
}
