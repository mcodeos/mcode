# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// AUDIO.TRS_35MM - 3.5mm TRS audio jack (headphone jack), configuration-parameterized Component Definition
// Note: pin layout varies by configuration - stereo, mono, or headset.

component AUDIO.TRS_35MM(config::STRING)
{
    name = "3.5mm TRS Connector"
    description = "3.5mm TRS audio connector, " + config + " configuration"
    
    spec = [
        type = "TRS"
        size = "3.5mm"
        configuration = config
    ]
    
    if config == "stereo" 
        pins = [
            1 = Tip, "Tip (Left)"
            2 = Ring, "Ring (Right)"
            3 = Sleeve @exposed(esd_contact), "Sleeve (Ground)"
        ] 
    else if config == "mono" 
        pins = [
            1 = Tip, "Tip (Signal)"
            2 = Sleeve @exposed(esd_contact), "Sleeve (Ground)"
        ] 
    else if config == "headset" 
        pins = [
            1 = Tip, "Tip (Left)"
            2 = Ring1, "Ring 1 (Right)"
            3 = Ring2, "Ring 2 (Microphone)"
            4 = Sleeve @exposed(esd_contact), "Sleeve (Ground)"
        ]
    else 
        pins = [
            1 = Tip, "Tip"
            2 = Ring, "Ring"
            3 = Sleeve @exposed(esd_contact), "Sleeve"
        ]
}

// AUDIO.TRS_25MM - 2.5mm TRS audio jack, 3-conductor (tip/ring/sleeve) Component Definition

component AUDIO.TRS_25MM()
{
    name = "2.5mm TRS Connector"
    description = "2.5mm TRS audio connector"
    
    spec = [
        type = "TRS"
        size = "2.5mm"
        configuration = _ // [stereo, mono, headset]
    ]
    
    pins = [
        1 = Tip, "Tip"
        2 = Ring, "Ring"
        3 = Sleeve @exposed(esd_contact), "Sleeve"
    ]
}

// AUDIO.RCA - Single-channel phono audio connector (center pin + shield) Component Definition

component AUDIO.RCA()
{
    name = "RCA Connector"
    description = "RCA audio connector"
    
    spec = [
        type = "RCA"
    ]
    
    pins = [
        1 = Center, "Center Pin"
        2 = Shield @exposed(esd_contact), "Outer Shield"
    ]
}

// AUDIO.XLR - Balanced audio connector, 3/4/5-pin variants Component Definition
// Note: pin_count selects the layout: 3 = audio only, 4 = audio + DC power,
// 5 = audio + bipolar DC power.

component AUDIO.XLR(pincnt::INT)
{
    name = "XLR Connector"
    description = "XLR audio connector, " + string(pincnt) + " pins"
    
    spec = [
        type = "XLR"
        pin_count = pincnt
        gender = _ // [male, female]
    ]
    
    if pincnt == 3
        pins = [
            1 = GND @exposed(esd_contact), "Ground"
            2 = Hot, "Hot"
            3 = Cold, "Cold"
        ]
    else if pincnt == 4
        pins = [
            [4,1] = [Power,GND]::DC(), ["Power","Ground"]
            2 = Hot, "Hot"
            3 = Cold, "Cold"
        ]
    else if pincnt == 5
        pins = [
            [4,5] = [Power\+,Power\-]::DC(), ["Power+","Power-"]
            1 = GND @exposed(esd_contact), "Ground"
            2 = Hot, "Hot"
            3 = Cold, "Cold"
        ]
    else
        error("AUDIO.XLR: pincnt must be 3, 4, or 5, got " + pincnt)
}

// AUDIO.SPEAKON - Professional loudspeaker connector, 4- or 8-pole Component Definition

component AUDIO.SPEAKON(pincnt::INT)
{
    name = "Speakon Connector"
    description = "Speakon professional audio connector"

    spec = [
        type = "Speakon"
        pin_count = pincnt // [4, 8]
        application = "Professional Audio"
    ]

    pins = [
        1:pin_count = 1:pin_count
    ]

    if pincnt != 4 && pincnt != 8
        error("AUDIO.SPEAKON: pincnt must be 4 or 8, got " + pincnt)
}

// AUDIO.BANANA_PLUG - Single-conductor banana plug for speaker terminals Component Definition

component AUDIO.BANANA_PLUG()
{
    name = "Banana Plug Connector"
    description = "Banana plug speaker connector"
    
    spec = [
        type = "Banana Plug"
        application = "Speaker Terminals"
    ]
    
    pins = [
        1 = Conductor @exposed(esd_contact), "Conductor"
    ]
}

// Usage Examples:
// 1. 3.5mm stereo connector
// AUDIO.TRS_35MM("stereo")

// 2. RCA connector (no parameters)
// AUDIO.RCA()

// 3. XLR 3-pin connector
// AUDIO.XLR(3)

// 4. Speakon 4-pin connector
// AUDIO.SPEAKON(4)