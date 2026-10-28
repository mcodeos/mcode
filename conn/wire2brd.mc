# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// WTB.BASIC - Generic wire-to-board connector Component Definition

general component WTB.BASIC(count::INT) :: ANCH.CONN.MATE
{
    name = "Wire-to-Board Connector"
    description = "Basic wire-to-board connector"
    
    spec += [
        pin_count = count // [2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16]
        pitch = _ // [1.0mm, 1.25mm, 1.5mm, 2.0mm, 2.54mm, 3.96mm]
        orientation = _ // [horizontal, vertical]
        ANCH.CONN.MATE = [
            conn_type = _ // the mating form: the pitch family, filled in by the real part
            mate_type = _ // the form this half mates with
            gender = _ // the shell gender, filled in by the real part
        ]
    ]
    
    pins = [
        1:count = 1:count 
    ]
}

// WTB.JST_XH - 2.5mm-pitch wire-to-board connector, XH family Component Definition

general component WTB.JST_XH(count::INT) :: ANCH.CONN.MATE
{
    name = "JST XH Connector"
    description = "JST XH series wire-to-board connector"
    
    spec += [
        series = "XH"
        pin_count = count // [2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16]
        pitch = 2.5mm
        manufacturer = "JST"
        ANCH.CONN.MATE = [
            conn_type = CONN_TYPE.HEADER_2_50MM
            mate_type = CONN_TYPE.HEADER_2_50MM
            gender = _ // the shell gender, filled in by the real part
        ]
    ]
    
    pins = [
        1:count = 1:count
    ]
}

// WTB.MOLEX_KK - 2.54mm-pitch wire-to-board connector, KK family Component Definition

general component WTB.MOLEX_KK(count::INT) :: ANCH.CONN.MATE
{
    name = "Molex KK Connector"
    description = "Molex KK series wire-to-board connector"
    
    spec += [
        series = "KK"
        pin_count = count // [2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16]
        pitch = 2.54mm
        manufacturer = "Molex"
        ANCH.CONN.MATE = [
            conn_type = CONN_TYPE.HEADER_2_54MM
            mate_type = CONN_TYPE.HEADER_2_54MM
            gender = _ // the shell gender, filled in by the real part
        ]
    ]
    
    pins = [
        1:count = 1:count
    ]
}

// WTB.DUPONT - 2.54mm-pitch single-row wire-to-board connector (breadboard compatible) Component Definition

general component WTB.DUPONT(count::INT) :: ANCH.CONN.MATE
{
    name = "Dupont Connector"
    description = "Dupont wire-to-board connector"
    
    spec += [
        type = "Dupont"
        pin_count = count // [2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16]
        pitch = 2.54mm
        ANCH.CONN.MATE = [
            conn_type = CONN_TYPE.HEADER_2_54MM
            mate_type = CONN_TYPE.HEADER_2_54MM
            gender = _ // the shell gender, filled in by the real part
        ]
    ]
    
    pins = [
        1:count = 1:count
    ]
}

// Usage Examples:
// 1. Basic wire-to-board connector
// WTB.BASIC(4)

// 2. JST XH connector
// WTB.JST_XH(6)

// 3. Molex KK connector
// WTB.MOLEX_KK(3)

// 4. Dupont connector
// WTB.DUPONT(40)