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

// Ethernet
interface ETHERNET(role)
{
    topology = "star"
    mode = ["full duplex"]
    maxdistance = 100m
    maxspeed = [10Mbps, 100Mbps, 1Gbps, 10Gbps]
    voltage = 3.3V

    // Ethernet Standard Definition
    // Core Rule: Twisted pair or fiber optic network interface
    // Ethernet Level Spec: Differential signaling over twisted pair, optical signaling over fiber
    // Device Definition: Host = Network device, Switch = Network switch
    // Versions: 10BASE-T, 100BASE-TX, 1000BASE-T, 10GBASE-T

    pins = [
        1 = TD\+, "Transmit Data Positive"    // Positive transmit data
        2 = TD\-, "Transmit Data Negative"    // Negative transmit data
        3 = RD\+, "Receive Data Positive"     // Positive receive data
        4 = BI4, "Bidirectional"              // Bidirectional line
        5 = BI5, "Bidirectional"              // Bidirectional line
        6 = RD\-, "Receive Data Negative"     // Negative receive data
        7 = BI7, "Bidirectional"              // Bidirectional line
        8 = BI8, "Bidirectional"              // Bidirectional line
    ]
    
    role Host {
        name = "Ethernet Host"
        pins = [
            out 1 = TD\+, "Transmit Data Positive"  // The host transmits on TD
            out 2 = TD\-, "Transmit Data Negative"
            in 3 = RD\+, "Receive Data Positive"    // and receives on RD
            io 4 = BI4, "Bidirectional"             // Gigabit quad: all four pairs
            io 5 = BI5, "Bidirectional"             // are bidirectional
            in 6 = RD\-, "Receive Data Negative"
            io 7 = BI7, "Bidirectional"
            io 8 = BI8, "Bidirectional"
        ]
        peer = Switch
    }

    role Switch {
        name = "Ethernet Switch"
        pins = [
            in 1 = TD\+, "Transmit Data Positive"   // The switch port receives the host's TD
            in 2 = TD\-, "Transmit Data Negative"
            out 3 = RD\+, "Receive Data Positive"   // and transmits the host's RD
            io 4 = BI4, "Bidirectional"             // Gigabit quad: all four pairs
            io 5 = BI5, "Bidirectional"             // are bidirectional
            out 6 = RD\-, "Receive Data Negative"
            io 7 = BI7, "Bidirectional"
            io 8 = BI8, "Bidirectional"
        ]
        peer = Host
    }
}
