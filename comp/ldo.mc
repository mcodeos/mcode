# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// LDO - Low-Dropout Linear Regulator Component Definition
// Core Rule: the demand window (output tolerance over load and temperature)
// sits inside the supply window; the dropout limit is a ceiling, never a
// design target.
// Device Definition: TRANSMITTER = regulated output rail,
//                    RECEIVER = load circuits on the rail

// Specimen class: 250mA-rated low-IQ CMOS LDO — output tolerance ±0.4%,
// 178mV typical dropout at full load, 1.6uA typical quiescent current,
// 44dB typical ripple rejection, 2.3V..6V input operating range,
// -40C..+125C junction range.

component LDO(volt::UV.VOLT, curr::UV.AMP, vdrop::UV.VOLT, iq::UV.AMP)
{
    name = "Low-Dropout Linear Regulator"
    description = "Low-dropout linear regulator, fixed positive output"

    spec = [
        voltage = volt // [1.8V, 2.5V, 2.8V, 3V, 3.3V, 3.6V, 5V]
        current = curr // [100mA, 150mA, 250mA, 300mA, 500mA]
        dropout = vdrop // [100mV, 120mV, 178mV, 210mV, 300mV] typ at full load
        quiescent = iq // [1.6uA, 3.2uA, 4.2uA, 11uA, 100uA] typ
        psrr = _ // ripple rejection, dB face lands with the meta batch
        temp_min = _
        temp_max = _
    ]

    pins = [
        1 = VIN            # Power input
        2 = GND            # Ground
        3 = VOUT           # Regulated output
    ]

    // build-time constraint face (parses today)
    require volt <= 6V
    require curr <= 500mA

    // Verification-face specimen — comment-gated until the meta / claim /
    // bench / assert productions land (same gating discipline as meta/).
    // Judgment vocabulary: covers / leq / in_env / voc.
    //
    // judgment-time asserts (one row per line in the verdict ledger):
    // assert covers(demand: [3.287V..3.313V], supply: [3.287V..3.313V])
    // assert in_env(temp: -40C..125C, vin: 2.3V..6V)
    //
    // L1 in-code regression claims (static windows):
    // claim at voltage { 3.3V, tolerance: ±0.4% }
    // claim under dropout { max: 178mV, at: 250mA }
    // claim under quiescent { max: 1.6uA }
    //
    // L3 bench (excitation needed; startup numbers illustrative):
    // bench ldo_startup {
    //     drive vin.ramp(to: 3.3V, over: 10us)
    //     probe vout
    //     scenario startup {
    //         analysis: tran 200us
    //         assert vout.settle_time(±2%) <= 1ms
    //     }
    // }
    //
    // custom judge (pure: same input, same verdict, no IO):
    // meta {
    //     fn domain_cut(demand, supply) -> verdict {
    //         in_env(temp: -40C..125C) ? leq(demand, 2%) : leq(demand, 3%)
    //     }
    // }
}

// Usage Examples:
// This file defines the LDO component (the DC power interface is declared
// elsewhere, in mcode/ifs).
// 1. 3.3V / 250mA-class rail for a radio subdomain
// LDO(3.3V, 250mA, 178mV, 1.6uA) radio_rail
// radio_rail.VOUT -> vdd_radio
// 2. Battery-fed regulator, dropout checked against the cell sag window
// LDO(3V, 150mA, 120mV, 3.2uA) coin_rail
// 3. Build-time constraint fires when the rail exceeds the input ceiling
// LDO(9V, 250mA, 178mV, 1.6uA) over_rail   // require volt <= 6V reports
