# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// DC container: the source-family contract - a fixed voltage between the
// VCC/GND pair, with the current rating (source population) and the charge
// capacity (battery population) as the population faces. Datasheet evidence
// (3-sheet sample: FDK CR2032 / VARTA EZPack / Kamcap supercap): the heads
// are full phrases (Nominal Voltage / Nominal Capacity / Standard Discharge
// Current) with no symbol faces - columns stand on the model face.

recipe DC {
    // Terminal face stays on the classes: the source population binds
    // [VCC, GND]::DC(), the battery population binds BAT{VCC, GND}::DC()
    // (psbi bus form) - the recipe carries the answer columns only.
    require = [
        electrical = [
            voltage = Voltage, desc: "output / cell voltage (sheet head Nominal Voltage / Rated Voltage - full phrase, no symbol face)"
        ]
    ]
    option = [
        supply = [
            current = Current, desc: "rated output current (source population; battery sheets state per-class discharge currents instead)"
        ]
        battery = [
            capacity = Charge, desc: "nominal charge capacity (battery population; sheet head Nominal Capacity (mAh); supercap sheets spell Rated capacitance in F instead)"
        ]
    ]
}

// DC.SRC - Fixed DC Power Source Component Definition
// Core Rule: ideal source that holds its rated voltage on the VCC/GND pair
// and supplies up to its rated current.

component DC.SRC(volt::UV.VOLT, curr::UV.AMP) :: DC {
    name        = "DC Power Source"
    description = "DC power supply source"
    spec        = [
        voltage = volt  // [3.3V, 5V, 9V, 12V, 24V]
        current = curr
    ]

    pins = [
        [1, 2] = [VCC, GND]::DC(volt)  // source terminal pair
    ]
}

// DC.BAT - DC Battery Component Definition
// Core Rule: bidirectional source on the BAT pair — charge flows in as a
// sink, discharge flows out as a source; the whole lead pair is addressable.

component DC.BAT(volt::UV.VOLT, charge::UV.CHARGE) :: DC {
    name        = "DC Battery"
    description = "DC battery"
    spec        = [
        voltage  = volt    // [1.5V, 3V, 3.7V, 9V, 12V]
        capacity = charge  // [100mAh, 500mAh, 1000mAh, 2000mAh, 5000mAh]
    ]

    pins = [
        psbi [1, 2] = BAT{VCC, GND}::DC(volt)  // battery: bidirectional source (charge = sink, discharge = source); BAT bus, whole-lead addressable
    ]
}

// Usage Examples:
// This file defines the source primitives DC.SRC and DC.BAT (the DC
// *interface* and power domains are declared elsewhere, in mcode/ifs).
// 1. Fixed supply source feeding a rail
// DC.SRC(12V, 2A) vmain
// vmain.VCC -> vcc_12v
// 2. Logic rail source
// DC.SRC(3.3V, 1A) v3v3
// 3. Battery cells
// DC.BAT(3.7V, 2000mAh) li_ion
// DC.BAT(9V, 500mAh) pp3
// DC.BAT(1.5V, 2500mAh) aa_cell
