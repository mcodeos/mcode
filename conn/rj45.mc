# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// RJ45.JACK - Plain 8P8C Ethernet receptacle (MDI face, 10/100/1000BASE-T) Component Definition
// Core Rule: The eight MDI pads adopt the ETHERNET media face position for
// position (pad 1 = TD+, ... pad 8 = BI8), so a jack wired to an ETHERNET
// Host maps 1:1 through the adoption.

component RJ45.JACK() :: ANCH.CONN.CAP
{
    name = "RJ45 Jack"
    description = "8P8C RJ45 receptacle, MDI face"

    spec += [
        type = "RJ45"
        category = _ // [Cat5e, Cat6, Cat6a]
        speed = _ // [10BASE-T, 100BASE-TX, 1000BASE-T]
        mount = _ // [through-hole, surface-mount]
        orientation = _ // [horizontal, vertical]
        ANCH.CONN.CAP = [
            conn_type = CONN_TYPE.RJ45
            mate_type = CONN_TYPE.RJ45
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        io [1,2,3,4,5,6,7,8] = ETH{TD\+, TD\-, RD\+, BI4, BI5, RD\-, BI7, BI8}::ETHERNET(), "MDI face: 1 TD+ / 2 TD- / 3 RD+ / 4 BI4 / 5 BI5 / 6 RD- / 7 BI7 / 8 BI8"
    ]
}

// RJ45.MAGJACK - RJ45 jack with integrated 10/100BASE-T magnetics Component Definition
// Core Rule: Board-side face of a single-port 10/100 magjack: the two PHY-side
// pairs, both center taps, the shared internal 75 Ohm termination point, and
// the chassis/shield electrode. GbE magjacks (4 pairs + 4 taps) are not
// modeled here.

component RJ45.MAGJACK() :: ANCH.CONN.CAP
{
    name = "RJ45 Magjack"
    description = "RJ45 jack with integrated 10/100BASE-T magnetics"

    spec += [
        type = "RJ45"
        speed = _ // [10BASE-T, 100BASE-TX]
        turns_ratio = _ // [1:1, 1:2]
        isolation = _ // [1500Vrms]
        leds = _ // [none, green/yellow, single]
        mount = _ // [through-hole, surface-mount]
        ANCH.CONN.CAP = [
            conn_type = CONN_TYPE.RJ45
            mate_type = CONN_TYPE.RJ45
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        1 = TD\+ @pair(td), "Transmit pair positive (PHY side)"
        2 = TD\- @pair(td), "Transmit pair negative (PHY side)"
        3 = RD\+ @pair(rd), "Receive pair positive (PHY side)"
        4 = RD\- @pair(rd), "Receive pair negative (PHY side)"
        5 = TCT, "Transmit center tap"
        6 = RCT, "Receive center tap"
        7 = TERM, "Internal 75 Ohm termination point (internal 75 Ohm termination network)"
        8 = CHGND @exposed(esd_contact), "Chassis / shield electrode"
    ]
}

// Usage Examples:
// RJ45.JACK() eth_jack1
// eth_jack1.TD\+ -> phy1.TD\+
// RJ45.MAGJACK() mag1
// mag1.TD\+ -> phy1.TX_P
