# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Connector mating-capability face: the mechanical form roster
// (CONN_TYPE), the shell gender roster (CONNECTOR_GENDER), the mating
// exception roster (CONNECTOR_MATING) and the recipe that binds them
// (ANCH.CONN.MATE). A base whose mating face is not fixed yet leaves the slot
// open; the real part fills it. Fill face spells the member with the
// namespace prefix (CONN_TYPE.USB_TYPE_A).

enum CONN_TYPE {
    // usb - family truth: conn/conn.groups.json
    USB_TYPE_A,
    USB_TYPE_B,
    USB_TYPE_C,
    USB_MINI_B,
    USB_MICRO_B,

    // video - family truth: conn/conn.groups.json
    HDMI_TYPE_A,
    HDMI_TYPE_C,
    HDMI_TYPE_D,
    HDMI_TYPE_E,
    DISPLAYPORT_STANDARD,
    DISPLAYPORT_MINI,
    DISPLAYPORT_USB_C,
    D_SUB_15,     // D-sub 15-pin (DE-15 high density shell): the VGA face
    DVI_D,
    DVI_A,
    DVI_I,

    // dc_power - family truth: conn/conn.groups.json
    DC_JACK_5_5MM,
    DC_JACK_6_3MM,
    DC_JACK_7_4MM,
    DC_JACK_8_4MM,
    XT60,
    XT30,
    DEANS_T,
    ANDERSON_2P,
    ANDERSON_4P,
    ANDERSON_6P,
    ATX_MAIN,
    ATX_CPU_4P,
    ATX_PCIE,
    ATX_SATA,
    ATX_MOLEX,

    // audio - family truth: conn/conn.groups.json
    TRS_3_5MM,
    TRS_2_5MM,
    RCA,
    XLR_3,
    XLR_4,
    XLR_5,
    SPEAKON_4,
    SPEAKON_8,
    BANANA_PLUG,

    // rf_coax - family truth: conn/conn.groups.json
    BNC,
    SMA,
    UFL,          // mates with the IPEX1 (U.FL plug) half
    MHF4,         // mates with the IPEX4 half
    IPEX1,
    IPEX4,

    // header - family truth: conn/conn.groups.json
    // Named by the pitch they mate on: the pin half and
    // the socket half of one pitch share the member, the shell gender
    // tells them apart
    HEADER_0_6MM,   // 0.6 mm pitch header
    HEADER_1_00MM,  // 1.0 mm pitch header
    HEADER_1_27MM,  // 1.27 mm pitch header
    HEADER_2_00MM,  // 2.0 mm pitch header
    HEADER_2_50MM,  // 2.5 mm pitch header
    HEADER_2_54MM,  // 2.54 mm pitch header

    // ribbon - family truth: conn/conn.groups.json
    // The flat-cable half mates with a header half
    IDC_2_54MM,     // 2.54 mm insulation-displacement ribbon plug

    // appliance_power - family truth: conn/conn.groups.json
    // The inlet and the cord connector are two forms
    IEC_C14,        // IEC 60320 C14 appliance inlet
    IEC_C13,        // IEC 60320 C13 cord connector
    IEC_C8,         // IEC 60320 C8 appliance inlet
    IEC_C7,         // IEC 60320 C7 cord connector

    // modular_plug - family truth: conn/conn.groups.json
    RJ45            // 8P8C modular plug
}

// The shell gender: the male half carries pins, the female half carries
// sockets. It is a fact of the real part, read from the datasheet - a
// library base fixes the shape but not the shell, so the slot stays open
// there.
enum CONNECTOR_GENDER {
    MALE,
    FEMALE
}

// The declared mating exception: a part that mates with any form and
// any gender states it (gender-neutral adapters, panel sockets that
// carry both).
enum CONNECTOR_MATING {
    ANY,     // mates with any form and any gender
    NONE     // mates with nothing: a sealed or blind half
}

// ANCH.CONN.MATE - connector mating-capability recipe. The answer sheet every
// connector class fills: the form of this half, the form of the half it
// mates with, and the shell gender.
recipe ANCH.CONN.MATE {
    name = "connector mating-capability recipe"

    require = [
        conn_type = CONN_TYPE, desc: "mechanical form of this half (closed roster; the fill face spells the member with the namespace prefix)"
        mate_type = CONN_TYPE, desc: "mechanical form of the half this one mates with; the same value for a self-mating form"
        gender = CONNECTOR_GENDER, desc: "shell gender: MALE carries pins, FEMALE carries sockets; a library base leaves it open, the real part fills it"
    ]

    option = [
        mating = CONNECTOR_MATING, desc: "mating exception: ANY declares that this half mates with any form and any gender"
    ]
}
