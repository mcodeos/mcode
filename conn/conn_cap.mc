# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Connector mating-capability face: the mechanical form roster
// (CONN_TYPE), the shell gender roster (CONNECTOR_GENDER), the mating
// exception roster (CONNECTOR_MATING) and the recipe that binds them
// (CONN.CAP). A base whose mating face is not fixed yet leaves the slot
// open; the real part fills it. Fill face spells the member with the
// namespace prefix (CONN_TYPE.USB_TYPE_A).

enum CONN_TYPE {
    // Universal Serial Bus
    USB_TYPE_A,
    USB_TYPE_B,
    USB_TYPE_C,
    USB_MINI_B,
    USB_MICRO_B,

    // Video and display
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

    // DC power
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

    // Audio
    TRS_3_5MM,
    TRS_2_5MM,
    RCA,
    XLR_3,
    XLR_4,
    XLR_5,
    SPEAKON_4,
    SPEAKON_8,
    BANANA_PLUG,

    // RF coaxial
    BNC,
    SMA,
    UFL,          // mates with the IPEX1 (U.FL plug) half
    MHF4,         // mates with the IPEX4 half
    IPEX1,
    IPEX4
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

// CONN.CAP - connector mating-capability recipe. The answer sheet every
// connector class fills: the form of this half, the form of the half it
// mates with, and the shell gender.
recipe CONN.CAP {
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
