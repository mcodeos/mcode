# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// VIDEO.HDMI - HDMI connector Component Definition
// Core Rule: The HDMI link rides the HDMI interface: three TMDS data pairs
// and a TMDS clock pair, CEC, the DDC pair and the hot-plug detect. The
// three shield contacts and the utility contact are in-shell members with
// no far-end counterpart, so they stay bare rows; the +5V feed and its
// return ride the DC face.

component VIDEO.HDMI() :: ANCH.CONN.MATE
{
    name = "HDMI Connector"
    description = "HDMI connector"

    spec += [
        version = _ // [1.4, 2.0, 2.1]
        ANCH.CONN.MATE = [
            conn_type = _ // [HDMI_TYPE_A, HDMI_TYPE_C, HDMI_TYPE_D, HDMI_TYPE_E]
            mate_type = _ // the form this half mates with
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        [1,3,4,6,7,9,10,12,13,15,16,19] = HDMI::HDMI(), "HDMI link: TMDS data 2/1/0 and clock pairs, CEC, DDC and hot-plug detect"
        2 = TMDS_D2_SH, "TMDS data 2 shield"      // in-shell member - no far-end counterpart
        5 = TMDS_D1_SH, "TMDS data 1 shield"
        8 = TMDS_D0_SH, "TMDS data 0 shield"
        11 = TMDS_CK_SH, "TMDS clock shield"
        14 = RESERVED, "Reserved (utility contact, unused before HDMI 1.4)"
        [18,17] = [P5V,GND]::DC(), "+5V Power / DDC/CEC Ground"
    ]
}

// VIDEO.DISPLAYPORT - DisplayPort connector Component Definition
// Core Rule: Four main-link differential lanes plus an AUX configuration lane,
// HPD, and a +3.3V feed.

component VIDEO.DISPLAYPORT() :: ANCH.CONN.MATE
{
    name = "DisplayPort Connector"
    description = "DisplayPort connector"
    
    spec += [
        version = _ // [1.2, 1.3, 1.4, 2.0]
        ANCH.CONN.MATE = [
            conn_type = _ // [DISPLAYPORT_STANDARD, DISPLAYPORT_MINI, DISPLAYPORT_USB_C]
            mate_type = _ // the form this half mates with
            gender = _ // the shell gender, filled in by the real part
        ]
    ]
    
    pins = [
        io [1,2,3,4,5,6,7,8,13,14,15] = DP{LANE0_P, LANE0_N, LANE1_P, LANE1_N, LANE2_P, LANE2_N, LANE3_P, LANE3_N, AUX_P, AUX_N, HPD}::DP(), "Main link lanes 0-3 (P/N each) plus the AUX configuration lane and hot-plug detect"
        9 = GND, "Ground"
        10 = GND, "Ground"
        11 = GND, "Ground"
        12 = GND, "Ground"
        [16,17] = [P3V3,GND]::DC(), "+3.3V Power / Ground"
        18 = RESERVED, "Reserved"
    ]
}

// VIDEO.VGA - Analog VGA connector (D-sub 15-pin) Component Definition
// Core Rule: Three single-ended analog video lines (red/green/blue), the
// horizontal and vertical sync lines and a DDC I2C pair ride the VGA face.
// The five ground contacts (one common, one per color, one for sync) are
// the analog returns, not link members, so they stay bare rows. The
// gender slot names the shell gender - male or female; a library base
// fixes the shape but not the shell, so the slot stays open here and the
// real part fills it in.

component VIDEO.VGA() :: ANCH.CONN.MATE
{
    name = "VGA Connector"
    description = "VGA (D-sub 15-pin) connector"

    spec += [
        pin_count = 15
        ANCH.CONN.MATE = [
            conn_type = CONN_TYPE.D_SUB_15
            mate_type = CONN_TYPE.D_SUB_15
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        io [1,2,3,13,14,15,12] = VGA::VGA(), "VGA link: analog red/green/blue, horizontal and vertical sync, and the DDC I2C pair"
        4 = RESERVED, "Reserved"
        5 = GND, "Ground"
        6 = GND_R, "Red Ground"
        7 = GND_G, "Green Ground"
        8 = GND_B, "Blue Ground"
        9 = KEY, "Key (No Pin)"   // the standard puts the type key here; a real plug part carries +5V on this contact and rides the DC face
        10 = GND_S, "Sync Ground"
        11 = RESERVED, "Reserved"
    ]
}

// VIDEO.DVI_D - DVI digital-only connector Component Definition
// Core Rule: The TMDS data and clock pairs, the dual-link data pairs, the
// DDC pair and the hot-plug detect ride the DVI face. The four shield
// contacts are in-shell members with no far-end counterpart, so they stay
// bare rows; the +5V feed and its return ride the DC face. This base
// covers the digital-only variant: the analog variants carry the flat
// blade and have their own faces, so the contact set here is the
// digital-only one. The gender slot names the shell gender - male or
// female; a library base fixes the shape but not the shell, so the slot
// stays open here and the real part fills it in.

component VIDEO.DVI_D() :: ANCH.CONN.MATE
{
    name = "DVI-D Connector"
    description = "DVI-D (digital-only) connector"

    spec += [
        link_type = _ // [single, dual]
        ANCH.CONN.MATE = [
            conn_type = CONN_TYPE.DVI_D  // digital-only 24 contacts; the analog variants add the flat blade
            mate_type = CONN_TYPE.DVI_D
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        io [2,1,10,9,18,17,23,24,13,12,5,4,21,20,6,7,16] = DVI::DVI.D(), "DVI link: TMDS data 2/1/0 and clock pairs, the dual-link data 3/4/5 pairs, the DDC pair and hot-plug detect"
        3 = TMDS_D2_SH, "TMDS data 2/4 shield"   // in-shell member - no far-end counterpart
        nc 8 = NC, "Not connected on this variant (the analog vertical sync contact of the analog variants)"
        11 = TMDS_D1_SH, "TMDS data 1/3 shield"
        19 = TMDS_D0_SH, "TMDS data 0/5 shield"
        22 = TMDS_CK_SH, "TMDS clock shield"
        [14,15] = [P5V,GND]::DC(), "+5V Power / Ground"
    ]
}

// VIDEO.DVI_A - DVI analog-only connector Component Definition
// Core Rule: The analog raster rides the flat blade and the DDC pair, the
// analog vertical sync and the hot-plug detect ride the grid. The TMDS
// contacts do not exist on this variant, so no digital member appears.
// The gender slot names the shell gender - male or female; a library base
// fixes the shape but not the shell, so the slot stays open here and the
// real part fills it in.

component VIDEO.DVI_A() :: ANCH.CONN.MATE
{
    name = "DVI-A Connector"
    description = "DVI-A (analog-only) connector"

    spec += [
        ANCH.CONN.MATE = [
            conn_type = CONN_TYPE.DVI_A  // analog-only: the flat blade plus the grid DDC and sync contacts
            mate_type = CONN_TYPE.DVI_A
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        io [C1,C2,C3,C4,8,6,7,16] = DVI::DVI.A(), "DVI analog link: the blade red/green/blue and horizontal sync, the grid vertical sync, the DDC pair and hot-plug detect"
        nc 14 = NC, "Not connected on this variant (the +5V contact of the digital variants)"
        15 = GND, "Ground"
        C5 = AGND, "Analog ground (the flat blade return)"
    ]
}

// VIDEO.DVI_I - DVI integrated connector Component Definition
// Core Rule: The digital grid and the analog blade in one face - every
// digital member and every analog member. The four shield contacts are
// in-shell members with no far-end counterpart, so they stay bare rows;
// the +5V feed and its return ride the DC face. The gender slot names
// the shell gender - male or female; a library base fixes the shape but
// not the shell, so the slot stays open here and the real part fills it
// in.

component VIDEO.DVI_I() :: ANCH.CONN.MATE
{
    name = "DVI-I Connector"
    description = "DVI-I (integrated) connector"

    spec += [
        link_type = "dual"
        ANCH.CONN.MATE = [
            conn_type = CONN_TYPE.DVI_I  // integrated 24+5 contacts: the full grid plus the full flat blade
            mate_type = CONN_TYPE.DVI_I
            gender = _ // the shell gender, filled in by the real part
        ]
    ]

    pins = [
        io [2,1,10,9,18,17,23,24,13,12,5,4,21,20,6,7,16,C1,C2,C3,C4,8] = DVI::DVI.I(), "DVI integrated link: the TMDS data and clock pairs, the DDC pair, hot-plug detect, the blade red/green/blue and horizontal sync, and the grid vertical sync"
        3 = TMDS_D2_SH, "TMDS data 2/4 shield"   // in-shell member - no far-end counterpart
        11 = TMDS_D1_SH, "TMDS data 1/3 shield"
        19 = TMDS_D0_SH, "TMDS data 0/5 shield"
        22 = TMDS_CK_SH, "TMDS clock shield"
        [14,15] = [P5V,GND]::DC(), "+5V Power / Ground"
        C5 = AGND, "Analog ground (the flat blade return)"
    ]
}

// Usage Examples:
// 1. HDMI connector
// VIDEO.HDMI()

// 2. DisplayPort connector
// VIDEO.DISPLAYPORT()

// 3. VGA connector
// VIDEO.VGA()

// 4. DVI digital-only connector
// VIDEO.DVI_D()

// 5. DVI analog-only connector
// VIDEO.DVI_A()

// 6. DVI integrated connector
// VIDEO.DVI_I()
