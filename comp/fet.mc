# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// FET - Generic Field-Effect Transistor Component Definition
// Core Rule: voltage-controlled switch/amplifier — the gate is insulated from
// the channel, so drain-source conduction is set by gate drive; conduction
// loss is characterized by Rds(on).

component FET(vds::UV.VOLT, ids::UV.AMP, rds::UV.OHM)
{
    name = "FET"
    description = "General field-effect transistor"
    spec = [
        drain_source_voltage = vds
        drain_current = ids
        drain_source_resistance = rds
    ]

    pins = [
        in 1 = GATE   , "Gate terminal"
        in 2 = DRAIN  , "Drain terminal"
        out 3 = SOURCE, "Source terminal"
    ]
}

// FET.JFET.N - N-Channel Junction FET Component Definition
// Core Rule: gate-channel junction is a diode that stays reverse-biased in
// normal operation; channel conducts with gate at source potential, and
// negative gate-source voltage pinches it off.

component FET.JFET.N(vds::UV.VOLT, ids::UV.AMP, rds::UV.OHM)
{
    name = "N-Channel JFET"
    description = "N-channel junction field-effect transistor"
    spec = [
        drain_source_voltage = vds
        drain_current = ids
        drain_source_resistance = rds
    ]

    pins = [
        in 1 = GATE   , "Gate terminal"
        in 2 = DRAIN  , "Drain terminal"
        out 3 = SOURCE, "Source terminal"
    ]
}

// FET.JFET.P - P-Channel Junction FET Component Definition
// Core Rule: gate-channel junction stays reverse-biased in normal operation;
// channel conducts at zero gate-source bias and positive gate-source voltage
// pinches it off.

component FET.JFET.P(vds::UV.VOLT, ids::UV.AMP, rds::UV.OHM)
{
    name = "P-Channel JFET"
    description = "P-channel junction field-effect transistor"
    spec = [
        drain_source_voltage = vds
        drain_current = ids
        drain_source_resistance = rds
    ]

    pins = [
        in 1 = GATE   , "Gate terminal"
        in 2 = SOURCE , "Source terminal"
        out 3 = DRAIN , "Drain terminal"
    ]
}

// FET.MOSFET.N - N-Channel MOSFET Component Definition
// Core Rule: insulated gate turns the channel on with a positive
// gate-source voltage above threshold; body diode points source to drain.

component FET.MOSFET.N(vds::UV.VOLT, ids::UV.AMP, rds::UV.OHM)
{
    name = "N-Channel MOSFET"
    description = "N-channel metal-oxide-semiconductor field-effect transistor"
    spec = [
        drain_source_voltage = vds
        drain_current = ids
        drain_source_resistance = rds
    ]

    pins = [
        in 1 = GATE   , "Gate terminal"
        in 2 = DRAIN  , "Drain terminal"
        out 3 = SOURCE, "Source terminal"
    ]
}

// FET.MOSFET.P - P-Channel MOSFET Component Definition
// Core Rule: insulated gate turns the channel on with a negative
// gate-source voltage below threshold; body diode points drain to source.

component FET.MOSFET.P(vds::UV.VOLT, ids::UV.AMP, rds::UV.OHM)
{
    name = "P-Channel MOSFET"
    description = "P-channel metal-oxide-semiconductor field-effect transistor"
    spec = [
        drain_source_voltage = vds
        drain_current = ids
        drain_source_resistance = rds
    ]

    pins = [
        in 1 = GATE   , "Gate terminal"
        in 2 = SOURCE , "Source terminal"
        out 3 = DRAIN , "Drain terminal"
    ]
}

// Usage Examples:
// FET.MOSFET.N(30V, 5A, 30mΩ) q2
// FET.JFET.N(25V, 10mA) j1
