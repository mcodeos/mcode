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

// ---------------------------------------------------------------------------------------------
// XTAL Interface Definition
// ---------------------------------------------------------------------------------------------

// XTAL interface: the passive resonator face (two-terminal crystal / ceramic
// resonator). The role pair is a circuit-identity pair, not a signal direction
// pair: Oscillator hosts the sustaining amplifier (MCU XIN/XOUT, RTC OSC
// pins), Resonator is the passive piezoelectric body. No Transmitter/Receiver
// wording (in a Pierce loop the drive comes from the MCU internal inverter;
// the crystal transmits nothing) and no direction words (passive leaf law).
// ERC / sim / DRC judgments anchor on the roles: both ends of a resonator must
// land on one Oscillator instance, and a Resonator has exactly one Oscillator
// (U200; mcd/doc/ee/xtal-oscillator-design.md).
// The @class(analog) row attribute is the library-default signal class:
// adopting components inherit it and may override by ordinal.
// Active oscillator modules do NOT adopt this face; their clock output adopts
// the single-ended CLK interface (ifs/clk.mc).

interface XTAL(role)
{
    topology = "point to point"

    pins = [
        1 = X1 @class(analog)   // Crystal terminal 1
        2 = X2 @class(analog)   // Crystal terminal 2
    ]

    role Oscillator {  // hosts the sustaining amplifier: MCU XIN/XOUT
        name = "XTAL Oscillator"
        peer = Resonator
    }
    role Resonator {   // the passive piezoelectric body
        name = "XTAL Resonator"
        peer = Oscillator
    }
}

// Example usage:
// component MyComponent
// {
//     pins = [
//         [1,2] = XTAL{X1,X2}::XTAL(Resonator) , ["Crystal input","Crystal output"]
//     ]
// }
// MCU side (the pins hosting the sustaining amplifier):
//     in [3,4] = XTAL::XTAL(Oscillator) , ["Crystal in","Crystal out"]
