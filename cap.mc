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
// Capacitor Component Definitions
// ---------------------------------------------------------------------------------------------

// Generic Capacitor
// cap: Capacitance value
// volt: Voltage rating
component CAP(cap::UV.CAP, volt::UV.VOLT)
{
    name = "Capacitor"
    description = "Capacitor with " + cap + " capacitance, " + volt + " voltage rating"
    
    pins = [
        1 = 1
        2 = 2
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = _ // [±5%, ±10%, ±20%]
        type = _ // [Ceramic, Aluminum, Tantalum, Polyester, Polypropylene, Polycarbonate, Polystyrene]
        dielectric = _ // [X5R, Y5V, NPO, X7R, Aluminum Electrolyte, Tantalum Pentoxide, Polyester, Polypropylene]
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }    
}

// Electrolytic Capacitor (Polarized)
// cap: Capacitance value
// volt: Voltage rating
component CAP.ELEC(cap::UV.CAP, volt::UV.VOLT)
{
    name = "Electrolytic Capacitor"
    description = "Polarized electrolytic capacitor with " + cap + " capacitance, " + volt + " voltage rating"
    
    pins = [ 
        1 = \+ , "Positive"
        2 = \- , "Negative"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = _ // [±5%, ±10%, ±20%]
        type = _ // [Aluminum, Tantalum, Niobium]
        dielectric = _ // [Aluminum Electrolyte, Tantalum Pentoxide, Niobium Oxide]
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }    
}

// Ceramic Capacitor
// cap: Capacitance value
// volt: Voltage rating
component CAP.CER(cap::UV.CAP, volt::UV.VOLT)
{
    name = "Ceramic Capacitor"
    description = "Ceramic capacitor with " + cap + " capacitance, " + volt + " voltage rating"
    
    pins = [
        1 = 1
        2 = 2
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = _ // [±5%, ±10%, ±20%]
        type = _ // [Multilayer, Ceramic Disc, Ceramic Chip]
        dielectric = _ // [X5R, Y5V, NPO, X7R]
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }    
}

// Tantalum Capacitor (Polarized)
// cap: Capacitance value
// volt: Voltage rating
component CAP.TANT(cap::UV.CAP, volt::UV.VOLT)
{
    name = "Tantalum Capacitor"
    description = "Polarized tantalum capacitor with " + cap + " capacitance, " + volt + " voltage rating"
    
    pins = [ 
        1 = \+ , "Positive"
        2 = \- , "Negative"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = _ // [±5%, ±10%, ±20%]
        type = _ // [Tantalum, Polymer Tantalum]
        dielectric = _ // [Tantalum Pentoxide, Polymer]
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }    
}

// Film Capacitor
// cap: Capacitance value
// volt: Voltage rating
component CAP.FILM(cap::UV.CAP, volt::UV.VOLT)
{
    name = "Film Capacitor"
    description = "Film capacitor with " + cap + " capacitance, " + volt + " voltage rating"
    
    pins = [ 
        1 = 1, "Terminal 1"
        2 = 2, "Terminal 2"
    ]

    spec = [
        capacitance = cap
        voltage = volt
        tolerance = _ // [±5%, ±10%, ±20%]
        type = _ // [Polyester, Polypropylene, Polycarbonate, Polystyrene]
        dielectric = _ // [Polyester, Polypropylene, Polycarbonate, Polystyrene]
    ]

    func Cap(net1, net2)
    {
        net1 - this - net2
        return net1, net2
    }    
}

# Usage Examples:
# 1. Basic capacitor
# CAP(100nF, 25V).Cap(vcc, gnd)

# 2. Electrolytic capacitor for power supply filtering
# CAP.ELEC(100μF, 16V).Cap(vcc, gnd)

# 3. Tantalum capacitor for precision applications
# CAP.TANT(10μF, 10V).Cap(signal, gnd)

# 4. Film capacitor for audio applications
# CAP.FILM(1μF, 50V).Cap(audio_in, audio_out)

# 5. Ceramic capacitor for decoupling
# CAP.CER(10nF, 50V).Cap(mcu_vcc, mcu_gnd)