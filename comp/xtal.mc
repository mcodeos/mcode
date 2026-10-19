# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

use ../ifs/xtal
use ../ifs/clk

// Crystal family book. One recipe container for the passive resonator
// population; a class adopts the container and exposes its terminal face.
// Recipes carry structure only; values live in ctor/spec defaults and at
// the BOM layer.

// XTAL - the passive resonator container recipe (capability-interface-model
// middle container for the crystal / ceramic-resonator classes). Three
// loadings (340 s0.2): the io entry face XTAL{X1, X2}, the answer sheet
// (frequency required; load capacitance optional - ceramic resonators leave
// it unfilled), and the family-shared wiring func. Adoption: `:: XTAL`.
// The Setup func reaches the adopter's ideal load-capacitance value through
// the instance face (this.load_capacitance): the recipe never carries the
// value (pure-form law) - the value lives in the component body's ctor/spec
// defaults and the func reads it per instance.
// Load-capacitor ownership: the load capacitors are part of the oscillator
// circuitry, not of the resonator - Setup is wiring sugar that
// lands them on the resonator terminals; for sim / ERC judgment they belong
// to the peer Oscillator side.
// Note: active oscillator modules (OSC) do not adopt this face; their clock
// output adopts the single-ended CLK interface (ifs/xtal header law).

recipe XTAL
{
    io XTAL{X1, X2}

    require = [
        timing = [
            frequency = Frequency, desc: "resonant frequency"
        ]
    ]
    option = [
        timing = [
            load_capacitance = Capacitance, desc: "crystal load capacitance (CL); the Setup wiring func lands one load capacitor per resonator terminal"
        ]
    ]

    func Setup(gnd)
    {
        XTAL.X1 - CAP(this.load_capacitance) - gnd
        XTAL.X2 - CAP(this.load_capacitance) - gnd
        return XTAL{X1, X2}
    }
}

// XTAL2 - Two-Pin Crystal Component Definition
// Core Rule: the cload formal carries the crystal load capacitance — it lands
// in `spec` (for BOM/DRC) and drives the container `Setup` wiring helper.

abstract component XTAL2(freq::UV.HZ, cload::UV.CAP) :: XTAL
{
    name = "2-Pin Crystal"
    description = "Basic 2-pin crystal oscillator"

    spec += [
        frequency = freq
        load_capacitance = cload
    ]

    pins = [
        io [1,2] = XTAL{X1,X2}::XTAL(RESONATOR) , "Crystal oscillator input / Crystal oscillator output"
    ]
}

// XTAL4 - Four-Pin Crystal Component Definition
// Core Rule: same resonator law as XTAL2 with two unconnected package pins
// (pins 2 and 4); cload drives the container `Setup` the same way.

abstract component XTAL4(freq::UV.HZ, cload::UV.CAP) :: XTAL
{
    name = "4-Pin Crystal"
    description = "4-pin crystal oscillator (pins 2 and 4 unconnected)"

    spec += [
        frequency = freq
        load_capacitance = cload
    ]

    pins = [
        io [1,3] = XTAL{X1,X2}::XTAL(RESONATOR) , "Crystal oscillator input / Crystal oscillator output"
    ]
}

// OSC - Active Oscillator Module Component Definition
// Core Rule: self-contained oscillator — power in, single-ended clock out;
// no external load capacitors are needed or modeled.

abstract component OSC(freq::UV.HZ)
{
    name = "Oscillator"
    description = "Active oscillator module"

    spec += [
        frequency = freq
    ]

    pins = [
        3 = CLKOUT::CLK(TRANSMITTER) , "Oscillator output (single-ended clock)"
        [4,2] = [VDD, GND]::DC(), "Power supply / Ground"
    ]
}

// XTAL.CERAMIC - Ceramic Resonator Component Definition
// Core Rule: piezoelectric ceramic resonator as a lower-precision,
// lower-cost alternative to a quartz crystal; two resonator terminals, no
// load capacitance formal (the option column stays unfilled).

abstract component XTAL.CERAMIC(freq::UV.HZ) :: XTAL
{
    name = "Ceramic Resonator"
    description = "Ceramic resonator for timing applications"

    spec += [
        frequency = freq
    ]

    pins = [
        io [1,2] = XTAL{X1,X2}::XTAL(RESONATOR) , "Resonator input / Resonator output"
    ]
}

// Usage Examples:
//
// Func form (automatic designators, capacitance taken from cload):
//    XTAL2(32.768kHz, 18pF) Y1.Setup(pwr.GND) -> MCU{XIN, XOUT}    // X1/X2 wired element-wise
//    XTAL4(12MHz, 33pF)     Y2.Setup(pwr.GND) -> MCU{XIN, XOUT}    // two 33pF load caps to ground
//
// Top-level vector circuit (exact capacitor designators, cload spelled out):
//    XTAL2(32.768kHz, 18pF) Y3.XTAL -> [C[8:9]::CAP(18pF)] -> [GND, GND] // one load cap per terminal
//
// Manual per-pin form:
//    XTAL2(32.768kHz, 33pF) Y4
//    Y4.XTAL.X1 - CAP(33pF) - pwr.GND
//    Y4.XTAL.X2 - CAP(33pF) - pwr.GND
//
