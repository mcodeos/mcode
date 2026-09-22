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

use ./ifs/xtal
use ./ifs/clk

# ---------------------------------------------------------------------------------------------
# Crystal components
#
# The cload formal carries the crystal load capacitance: it lands in `spec`
# (for BOM/DRC) and drives the `Setup` wiring helper.
#
# `Setup(gnd)` generates one load capacitor per terminal (X1/X2 to gnd),
# each valued cload, and returns the XTAL member pair for element-wise
# connection to the MCU side. See the Usage Examples at the end of this file
# for the func form, the top-level vector-circuit form (exact capacitor
# designators), and the manual per-pin form.
# ---------------------------------------------------------------------------------------------

# Basic 2-Pin Crystal Component
component XTAL2(freq::UV.HZ, cload::UV.CAP)
{
    name = "2-Pin Crystal"
    description = "Basic 2-pin crystal oscillator"

    spec = [
        frequency = freq
        load_capacitance = cload
    ]

    pins = [
        [1,2] = XTAL{X1,X2}::XTAL(Resonator) , ["Crystal oscillator input","Crystal oscillator output"]
    ]

    // Load-capacitor ownership (U200 ruling): the load capacitors are part of
    // the oscillator circuitry, not of the resonator. Setup below is wiring
    // sugar that lands them on the resonator terminals; for sim / ERC
    // judgment they belong to the peer Oscillator side.
    func Setup(gnd)
    {
        [XTAL.X1, gnd] => CAP(cload).Cap(_)
        [XTAL.X2, gnd] => CAP(cload).Cap(_)
        return XTAL{X1,X2}
    }
}

# 4-Pin Crystal Component
component XTAL4(freq::UV.HZ, cload::UV.CAP)
{
    name = "4-Pin Crystal"
    description = "4-pin crystal oscillator (pins 2 and 4 unconnected)"

    spec = [
        frequency = freq
        load_capacitance = cload
    ]

    pins = [
        [1,3] = XTAL{X1,X2}::XTAL(Resonator) , ["Crystal oscillator input","Crystal oscillator output"]
    ]

    func Setup(gnd)
    {
        [XTAL.X1, gnd] => CAP(cload).Cap(_)
        [XTAL.X2, gnd] => CAP(cload).Cap(_)
        return XTAL{X1,X2}
    }
}

# Oscillator Component
component OSC(freq::UV.HZ)
{
    name = "Oscillator"
    description = "Active oscillator module"

    spec = [
        frequency = freq
    ]

    pins = [
        3 = CLKOUT::CLK(Transmitter) , "Oscillator output (single-ended clock)"
        [4,2] = [VDD, GND]::DC(), ["Power supply", "Ground"]
    ]
}

# Ceramic Resonator Component
component XTAL.CERAMIC(freq::UV.HZ)
{
    name = "Ceramic Resonator"
    description = "Ceramic resonator for timing applications"

    spec = [
        frequency = freq
    ]

    pins = [
        [1,2] = XTAL{X1,X2}::XTAL(Resonator) , ["Resonator input","Resonator output"]
    ]
}

# Surface Mount Crystal Component
component XTAL.SMD(freq::UV.HZ, cload::UV.CAP)
{
    name = "SMD Crystal"
    description = "Surface mount crystal oscillator"

    spec = [
        frequency = freq
        load_capacitance = cload
    ]

    pins = [
        [1,2] = XTAL{X1,X2}::XTAL(Resonator) , ["Crystal oscillator input","Crystal oscillator output"]
    ]

    func Setup(gnd)
    {
        [XTAL.X1, gnd] => CAP(cload).Cap(_)
        [XTAL.X2, gnd] => CAP(cload).Cap(_)
        return XTAL{X1,X2}
    }
}

# ---------------------------------------------------------------------------------------------
# Usage Examples
#
# Func form (automatic designators, capacitance taken from cload):
#    XTAL2(32.768kHz, 18pF) Y1.Setup(pwr.GND) -> MCU{XIN, XOUT}    // X1/X2 wired element-wise
#    XTAL4(12MHz, 33pF)     Y2.Setup(pwr.GND) -> MCU{XIN, XOUT}    // two 33pF load caps to ground
#
# Top-level vector circuit (exact capacitor designators, cload spelled out):
#    XTAL2(32.768kHz, 18pF) Y3.XTAL -> [C[8:9]::CAP(18pF)] -> [GND, GND] // one load cap per terminal
#
# Manual per-pin form:
#    XTAL2(32.768kHz, 33pF) Y4
#    CAP(33pF).Cap([Y4.XTAL.X1, pwr.GND])
#    CAP(33pF).Cap([Y4.XTAL.X2, pwr.GND])
#
