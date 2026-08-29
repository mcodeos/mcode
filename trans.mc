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
        in B = Base     , "Base terminal"
        in C = Collector , "Collector terminal"
        out E = Emitter  , "Emitter terminal"
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
        in B = Base     , "Base terminal"
        in C = Collector , "Collector terminal"
        out E = Emitter  , "Emitter terminal"
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
        in B = Base     , "Base terminal"
        in E = Emitter  , "Emitter terminal"
        out C = Collector , "Collector terminal"
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
        in B = Base     , "Base terminal"
        in C = Collector , "Collector terminal"
        out E = Emitter  , "Emitter terminal"
    ]
}

// ---------------------------------------------------------------------------------------------
// FET — Field-Effect Transistors (JFET, MOSFET)
// ---------------------------------------------------------------------------------------------

# Field-Effect Transistor (FET) Component
component FET(vds::UV.VOLT, ids::UV.AMP, rds::UV.OHM)
{
    name = "FET"
    description = "General field-effect transistor"
    spec = [
        drain_source_voltage = vds
        drain_current = ids
        drain_source_resistance = rds
    ]

    pins = [
        in G = Gate    , "Gate terminal"
        in D = Drain   , "Drain terminal"
        out S = Source , "Source terminal"
    ]
}

// ---------------------------------------------------------------------------------------------
// FET.JFET — Junction Field-Effect Transistors
// ---------------------------------------------------------------------------------------------

# N-Channel JFET Component
component FET.JFET.N(vds::UV.VOLT, ids::UV.AMP, rds::UV.OHM)
{
    name = "N-Channel JFET"
    description = "N-channel junction field-effect transistor"
    spec = [
        drain_source_voltage = vds
        drain_current = ids
        drain_source_resistance = rds
    ]

    pins = [
        in G = Gate    , "Gate terminal"
        in D = Drain   , "Drain terminal"
        out S = Source , "Source terminal"
    ]
}

# P-Channel JFET Component
component FET.JFET.P(vds::UV.VOLT, ids::UV.AMP, rds::UV.OHM)
{
    name = "P-Channel JFET"
    description = "P-channel junction field-effect transistor"
    spec = [
        drain_source_voltage = vds
        drain_current = ids
        drain_source_resistance = rds
    ]

    pins = [
        in G = Gate    , "Gate terminal"
        in S = Source  , "Source terminal"
        out D = Drain  , "Drain terminal"
    ]
}

// ---------------------------------------------------------------------------------------------
// FET.MOSFET — Metal-Oxide-Semiconductor Field-Effect Transistors
// ---------------------------------------------------------------------------------------------

# N-Channel MOSFET Component
component FET.MOSFET.N(vds::UV.VOLT, ids::UV.AMP, rds::UV.OHM)
{
    name = "N-Channel MOSFET"
    description = "N-channel metal-oxide-semiconductor field-effect transistor"
    spec = [
        drain_source_voltage = vds
        drain_current = ids
        drain_source_resistance = rds
    ]

    pins = [
        in G = Gate    , "Gate terminal"
        in D = Drain   , "Drain terminal"
        out S = Source , "Source terminal"
    ]
}

# P-Channel MOSFET Component
component FET.MOSFET.P(vds::UV.VOLT, ids::UV.AMP, rds::UV.OHM)
{
    name = "P-Channel MOSFET"
    description = "P-channel metal-oxide-semiconductor field-effect transistor"
    spec = [
        drain_source_voltage = vds
        drain_current = ids
        drain_source_resistance = rds
    ]

    pins = [
        in G = Gate    , "Gate terminal"
        in S = Source  , "Source terminal"
        out D = Drain  , "Drain terminal"
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
        in G = Gate    , "Gate terminal"
        in C = Collector , "Collector terminal"
        out E = Emitter  , "Emitter terminal"
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
        in G = Gate    , "Gate terminal"
        in A = Anode    , "Anode terminal"
        out K = Cathode , "Cathode terminal"
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
        in G = Gate    , "Gate terminal"
        1 = T1         , "Terminal 1"
        2 = T2         , "Terminal 2"
    ]
}
