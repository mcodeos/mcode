# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// OPTO container: the current-output population contract (general and
// transistor output stages). Datasheet evidence (5-sheet sample: PC817X /
// PC123 / 6N137 / HCPL-2630 / EL3H7): IF, IC / IO, Viso and CTR all
// witnessed as table symbols. Terminal faces stay on the classes (the
// output stage names the pads: COLLECTOR/EMITTER, MT1/MT2, OUTPUT/GND).

recipe OPTO {
    require = [
        input = [
            input_current = Current, alias: [IF], desc: "input LED forward current rating (sheet head Forward current IF; the pulse face spells IFM)"
        ]
        output = [
            output_current    = Current, alias: [IC, IO], desc: "output-side current rating (collector current IC on transistor-output sheets; IO on dual-channel sheets)"
            isolation_voltage = Voltage, alias: [Viso], desc: "isolation barrier rating (sheet head Isolation voltage Viso(rms), AC 1-minute test)"
        ]
    ]
    option = [
        transfer = [
            current_transfer_ratio = Ratio, alias: [CTR], desc: "current transfer ratio IC/IF at the stated IF and VCE (sheet head CTR; rank tables spell the same symbol)"
        ]
    ]
}

// OPTO.TRIAC container: the photosensitive-triac output population - the
// off-state output voltage and the holding current are the population
// faces (no triac-output sheet in the sampled corpus; columns stand on
// the model face).
recipe OPTO.TRIAC {
    require = [
        input = [
            input_current = Current, alias: [IF], desc: "input LED forward current rating (sheet head Forward current IF)"
        ]
        output = [
            output_voltage    = Voltage, desc: "off-state output voltage rating (triac-output population; no corpus sample carries a symbol head)"
            isolation_voltage = Voltage, alias: [Viso], desc: "isolation barrier rating (sheet head Isolation voltage Viso(rms))"
        ]
    ]
    option = [
        trigger = [
            holding_current = Current, desc: "holding current keeping the output on until the load current crosses zero (no corpus witness - model face)"
        ]
    ]
}

// OPTO.PV container: the photovoltaic-output population - the LED input
// light generates an isolated floating voltage rather than a switched
// current (no PV-output sheet in the sampled corpus; columns stand on
// the model face).
recipe OPTO.PV {
    require = [
        input = [
            input_current = Current, alias: [IF], desc: "input LED forward current rating (sheet head Forward current IF)"
        ]
        output = [
            output_voltage    = Voltage, desc: "floating output voltage the photovoltaic stage generates (no corpus sample - model face)"
            isolation_voltage = Voltage, alias: [Viso], desc: "isolation barrier rating (sheet head Isolation voltage Viso(rms))"
        ]
    ]
}

// OPTO.LOGIC container: the integrated-receiver population - the output
// restores to a logic level and the propagation delay bounds the
// signalling rate (VO and tPLH/tPHL witnessed on the 6N137 / HCPL-2630
// logic-output sheets).
recipe OPTO.LOGIC {
    require = [
        input = [
            input_current = Current, alias: [IF], desc: "input LED forward current rating (sheet head Forward current IF; threshold faces spell ITH)"
        ]
        output = [
            output_voltage    = Voltage, alias: [VO], desc: "output-side voltage rating (sheet head Output Collector Voltage VO on logic-output sheets)"
            isolation_voltage = Voltage, alias: [Viso], desc: "isolation barrier rating (sheet head Isolation voltage Viso(rms))"
        ]
    ]
    option = [
        speed = [
            propagation_delay = Time, alias: [tPLH, tPHL], desc: "propagation delay to the output level crossing (switching-characteristics table, tPLH / tPHL)"
        ]
    ]
}

// OPTO - Generic Optocoupler Component Definition
// Core Rule: signal crosses the isolation barrier optically — input LED and
// output photodetector share no galvanic path up to the isolation voltage.

component OPTO(iin::UV.AMP, iout::UV.AMP, viso::UV.VOLT) :: OPTO {
    name = "Optocoupler"
    spec = [
        input_current     = iin
        output_current    = iout
        isolation_voltage = viso
    ]

    pins = [
        1 = INPUT\+ @barrier(input)
        2 = INPUT\- @barrier(input)
        3 = OUTPUT\+ @barrier(output)
        4 = OUTPUT\- @barrier(output)
    ]
}

// OPTO.TRANS - Transistor-Output Optocoupler Component Definition
// Core Rule: phototransistor output; the current transfer ratio (CTR) sets
// how much output current a given input LED current can sustain.

component OPTO.TRANS(iin::UV.AMP, iout::UV.AMP, viso::UV.VOLT, ctr::UV.PERCENT) :: OPTO {
    name = "Transistor Output Optocoupler"
    spec = [
        input_current          = iin
        output_current         = iout
        isolation_voltage      = viso
        current_transfer_ratio = ctr
    ]

    pins = [
        1 = INPUT\+ @barrier(input)
        2 = INPUT\- @barrier(input)
        3 = COLLECTOR @barrier(output)
        4 = EMITTER @barrier(output)
    ]
}

// OPTO.TRIAC - Triac-Output Optocoupler Component Definition
// Core Rule: photosensitive triac output drives AC loads; holding current
// keeps the output on until the load current crosses zero.

component OPTO.TRIAC(iin::UV.AMP, vout::UV.VOLT, viso::UV.VOLT, ihold::UV.AMP) :: OPTO.TRIAC {
    name = "Triac Output Optocoupler"
    spec = [
        input_current     = iin
        output_voltage    = vout
        isolation_voltage = viso
        holding_current   = ihold
    ]

    pins = [
        1 = INPUT\+ @barrier(input)
        2 = INPUT\- @barrier(input)
        3 = MT1 @barrier(output)
        4 = MT2 @barrier(output)
    ]
}

// OPTO.PV - Photovoltaic-Output Optocoupler Component Definition
// Core Rule: the output side is a photovoltaic generator — LED input light
// produces an isolated floating voltage source rather than a switched current.

component OPTO.PV(iin::UV.AMP, vout::UV.VOLT, viso::UV.VOLT) :: OPTO.PV {
    name = "Photovoltaic Optocoupler"
    spec = [
        input_current     = iin
        output_voltage    = vout
        isolation_voltage = viso
    ]

    pins = [
        1 = INPUT\+ @barrier(input)
        2 = INPUT\- @barrier(input)
        3 = OUTPUT\+ @barrier(output)
        4 = OUTPUT\- @barrier(output)
    ]
}

// OPTO.LOGIC - Logic-Gate Output Optocoupler Component Definition
// Core Rule: integrated receiver restores the signal to a logic level on the
// output side; the propagation delay bounds the achievable signalling rate.

component OPTO.LOGIC(iin::UV.AMP, vout::UV.VOLT, viso::UV.VOLT, tdelay::UV.TIME) :: OPTO.LOGIC {
    name = "Logic Output Optocoupler"
    spec = [
        input_current     = iin
        output_voltage    = vout
        isolation_voltage = viso
        propagation_delay = tdelay
    ]

    pins = [
        1 = INPUT\+ @barrier(input)
        2 = INPUT\- @barrier(input)
        3 = OUTPUT @barrier(output)
        4 = GND @barrier(output)
    ]
}

// Usage Examples:
// OPTO.TRANS(10mA, 50mA, 3750V, 50%) oc1      // transistor output
// OPTO.LOGIC(10mA, 8mA, 2500V, 10us) ol1      // logic-gate output
// OPTO.TRIAC(10mA, 220V, 2500V, 5mA) ot1      // triac driver
// OPTO.PV(10mA, 5V, 2500V) opv                // photovoltaic output
