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
        in 1 = GATE   , "Gate terminal"
        in 2 = DRAIN  , "Drain terminal"
        out 3 = SOURCE, "Source terminal"
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
        in 1 = GATE   , "Gate terminal"
        in 2 = DRAIN  , "Drain terminal"
        out 3 = SOURCE, "Source terminal"
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
        in 1 = GATE   , "Gate terminal"
        in 2 = SOURCE , "Source terminal"
        out 3 = DRAIN , "Drain terminal"
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
        in 1 = GATE   , "Gate terminal"
        in 2 = DRAIN  , "Drain terminal"
        out 3 = SOURCE, "Source terminal"
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
        in 1 = GATE   , "Gate terminal"
        in 2 = SOURCE , "Source terminal"
        out 3 = DRAIN , "Drain terminal"
    ]
}

# Usage Examples:
# FET.MOSFET.N(30V, 5A, 30mΩ) q2
# FET.JFET.N(25V, 10mA) j1
