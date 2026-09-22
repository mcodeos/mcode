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
// TRANS — Bipolar Junction Transistors (BJT)
// ---------------------------------------------------------------------------------------------

# Bipolar Junction Transistor (BJT) Component
component TRANS(vce::UV.VOLT, ic::UV.AMP, hfe::INT)
{
    name = "Bipolar Junction Transistor"
    description = "General bipolar junction transistor"
    spec = [
        collector_emitter_voltage = vce
        collector_current = ic
        current_gain = hfe
    ]

    pins = [
        in 1 = BASE     , "Base terminal"
        in 2 = COLLECTOR, "Collector terminal"
        out 3 = EMITTER , "Emitter terminal"
    ]
}

# NPN Transistor Component
component TRANS.NPN(vce::UV.VOLT, ic::UV.AMP, hfe::INT)
{
    name = "NPN Transistor"
    description = "NPN bipolar junction transistor"
    spec = [
        collector_emitter_voltage = vce
        collector_current = ic
        current_gain = hfe
    ]

    pins = [
        in 1 = BASE     , "Base terminal"
        in 2 = COLLECTOR, "Collector terminal"
        out 3 = EMITTER , "Emitter terminal"
    ]
}

# PNP Transistor Component
component TRANS.PNP(vce::UV.VOLT, ic::UV.AMP, hfe::INT)
{
    name = "PNP Transistor"
    description = "PNP bipolar junction transistor"
    spec = [
        collector_emitter_voltage = vce
        collector_current = ic
        current_gain = hfe
    ]

    pins = [
        in 1 = BASE     , "Base terminal"
        in 2 = EMITTER  , "Emitter terminal"
        out 3 = COLLECTOR, "Collector terminal"
    ]
}

# Darlington Transistor Component
component TRANS.DARLINGTON(vce::UV.VOLT, ic::UV.AMP, hfe::INT)
{
    name = "Darlington Transistor"
    description = "Darlington pair transistor"
    spec = [
        collector_emitter_voltage = vce
        collector_current = ic
        current_gain = hfe
    ]

    pins = [
        in 1 = BASE     , "Base terminal"
        in 2 = COLLECTOR, "Collector terminal"
        out 3 = EMITTER , "Emitter terminal"
    ]
}

// ---------------------------------------------------------------------------------------------
// TRANS — Other Transistor-like Devices (IGBT, SCR, TRIAC)
// ---------------------------------------------------------------------------------------------

# IGBT Component
component TRANS.IGBT(vce::UV.VOLT, ic::UV.AMP)
{
    name = "IGBT"
    description = "Insulated Gate Bipolar Transistor"
    spec = [
        collector_emitter_voltage = vce
        collector_current = ic
    ]

    pins = [
        in 1 = GATE     , "Gate terminal"
        in 2 = COLLECTOR, "Collector terminal"
        out 3 = EMITTER , "Emitter terminal"
    ]
}

# SCR Component
component TRANS.SCR(vrrm::UV.VOLT, it::UV.AMP)
{
    name = "SCR"
    description = "Silicon Controlled Rectifier"
    spec = [
        reverse_repetitive_voltage = vrrm
        forward_current = it
    ]

    pins = [
        in 1 = GATE     , "Gate terminal"
        in 2 = ANODE    , "Anode terminal"
        out 3 = CATHODE , "Cathode terminal"
    ]
}

# TRIAC Component
component TRANS.TRIAC(vdrm::UV.VOLT, it::UV.AMP)
{
    name = "TRIAC"
    description = "Triode for Alternating Current"
    spec = [
        repetitive_peak_off_voltage = vdrm
        forward_current = it
    ]

    pins = [
        in 1 = GATE     , "Gate terminal"
        2 = T1          , "Main terminal 1"
        3 = T2          , "Main terminal 2"
    ]
}

# Usage Examples:
# TRANS.NPN(40V, 200mA, 100) q1
# TRANS.DARLINGTON(100V, 8A, 1000) q3
# TRANS.IGBT(600V, 20A) q4
# TRANS.SCR(800V, 12A) scr1
