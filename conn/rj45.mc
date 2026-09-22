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
// RJ45 — Ethernet physical jacks (8P8C line receptacle, magjack with magnetics)
// ---------------------------------------------------------------------------------------------
// Pin names mirror the ETHERNET interface members (ifs/ethernet.mc) position for
// position, so a jack wired to an ETHERNET Host maps 1:1 without an interface
// binding on the component face (the `::` binding face carries known debt, U183).

// Plain 8P8C RJ45 receptacle (MDI face, 10/100/1000BASE-T)
component RJ45.JACK()
{
    name = "RJ45 Jack"
    description = "8P8C RJ45 receptacle, MDI face"

    spec = [
        type = "RJ45"
        category = _ // [Cat5e, Cat6, Cat6a]
        speed = _ // [10BASE-T, 100BASE-TX, 1000BASE-T]
        mount = _ // [through-hole, surface-mount]
        orientation = _ // [horizontal, vertical]
    ]

    pins = [
        1 = TD\+, "Transmit Data Positive"     // MDI pin 1
        2 = TD\-, "Transmit Data Negative"     // MDI pin 2
        3 = RD\+, "Receive Data Positive"      // MDI pin 3
        4 = BI4, "Bidirectional line 4"        // PoE / termination
        5 = BI5, "Bidirectional line 5"        // PoE / termination
        6 = RD\-, "Receive Data Negative"      // MDI pin 6
        7 = BI7, "Bidirectional line 7"        // PoE / termination
        8 = BI8, "Bidirectional line 8"        // PoE / termination
    ]
}

// Magjack: RJ45 with integrated magnetics (canonical 10/100BASE-T board face).
// Board-side face of a single-port 10/100 magjack: the two PHY-side pairs, both
// center taps, the shared internal 75 Ohm Bob Smith termination point, and the
// chassis/shield electrode. GbE magjacks (4 pairs + 4 taps) wait for a real
// sample part (mcpub binding route) instead of a speculative generic face.
component RJ45.MAGJACK()
{
    name = "RJ45 Magjack"
    description = "RJ45 jack with integrated 10/100BASE-T magnetics"

    spec = [
        type = "RJ45"
        speed = _ // [10BASE-T, 100BASE-TX]
        turns_ratio = _ // [1:1, 1:2]
        isolation = _ // [1500Vrms]
        leds = _ // [none, green/yellow, single]
        mount = _ // [through-hole, surface-mount]
    ]

    pins = [
        1 = TD\+, "Transmit pair positive (PHY side)"
        2 = TD\-, "Transmit pair negative (PHY side)"
        3 = RD\+, "Receive pair positive (PHY side)"
        4 = RD\-, "Receive pair negative (PHY side)"
        5 = TCT, "Transmit center tap"
        6 = RCT, "Receive center tap"
        7 = TERM, "Internal 75 Ohm termination point (Bob Smith network)"
        8 = CHGND @exposed(esd_contact), "Chassis / shield electrode"
    ]
}

# Usage Examples:
# RJ45.JACK() eth_jack1
# eth_jack1.TD\+ -> phy1.TD\+
# RJ45.MAGJACK() mag1
# mag1.TD\+ -> phy1.TX_P
