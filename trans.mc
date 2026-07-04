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

# Bipolar Junction Transistor (BJT) Component
component TRANS
{
    name = "Bipolar Junction Transistor"
    description = "General bipolar junction transistor"
    
    pins = [
        in B = Base     , "Base terminal"
        in C = Collector , "Collector terminal"
        out E = Emitter  , "Emitter terminal"
    ]
}

# NPN Transistor Component
component TRANS.NPN
{
    name = "NPN Transistor"
    description = "NPN bipolar junction transistor"
    
    pins = [
        in B = Base     , "Base terminal"
        in C = Collector , "Collector terminal"
        out E = Emitter  , "Emitter terminal"
    ]
}

# PNP Transistor Component
component TRANS.PNP
{
    name = "PNP Transistor"
    description = "PNP bipolar junction transistor"
    
    pins = [
        in B = Base     , "Base terminal"
        in E = Emitter  , "Emitter terminal"
        out C = Collector , "Collector terminal"
    ]
}

# Darlington Transistor Component
component TRANS.Darlington
{
    name = "Darlington Transistor"
    description = "Darlington pair transistor"
    
    pins = [
        in B = Base     , "Base terminal"
        in C = Collector , "Collector terminal"
        out E = Emitter  , "Emitter terminal"
    ]
}

# MOSFET Component
component MOSFET
{
    name = "MOSFET"
    description = "Metal-Oxide-Semiconductor Field-Effect Transistor"
    
    pins = [
        in G = Gate    , "Gate terminal"
        in D = Drain   , "Drain terminal"
        out S = Source , "Source terminal"
    ]
}

# NMOS Transistor Component
component MOSFET.NMOS
{
    name = "NMOS Transistor"
    description = "N-channel MOSFET"
    
    pins = [
        in G = Gate    , "Gate terminal"
        in D = Drain   , "Drain terminal"
        out S = Source , "Source terminal"
    ]
}

# PMOS Transistor Component
component MOSFET.PMOS
{
    name = "PMOS Transistor"
    description = "P-channel MOSFET"
    
    pins = [
        in G = Gate    , "Gate terminal"
        in S = Source , "Source terminal"
        out D = Drain   , "Drain terminal"
    ]
}

# JFET Transistor Component
component TRANS.JFET
{
    name = "JFET"
    description = "Junction Field-Effect Transistor"
    
    pins = [
        in G = Gate    , "Gate terminal"
        in D = Drain   , "Drain terminal"
        out S = Source , "Source terminal"
    ]
}

# IGBT Component
component TRANS.IGBT
{
    name = "IGBT"
    description = "Insulated Gate Bipolar Transistor"
    
    pins = [
        in G = Gate    , "Gate terminal"
        in C = Collector , "Collector terminal"
        out E = Emitter  , "Emitter terminal"
    ]
}

# SCR Component
component TRANS.SCR
{
    name = "SCR"
    description = "Silicon Controlled Rectifier"
    
    pins = [
        in G = Gate    , "Gate terminal"
        in A = Anode    , "Anode terminal"
        out K = Cathode , "Cathode terminal"
    ]
}

# TRIAC Component
component TRANS.TRIAC
{
    name = "TRIAC"
    description = "Triode for Alternating Current"
    
    pins = [
        in G = Gate    , "Gate terminal"
        1 = T1         , "Terminal 1"
        2 = T2         , "Terminal 2"
    ]
}

