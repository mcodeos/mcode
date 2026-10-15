# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// PSI5 - Current-Modulated Sensor Supply Interface Standard Definition
// Core Rule: The ECU powers the sensor over a current-regulated supply
//            and talks on the same pair: commands go out as supply-current
//            modulation (TX), sensor answers come back as voltage
//            modulation (RX). The coupling network (sense resistor +
//            filter) lives board-side, outside the face; the two members
//            are the ECU-side pads into that network.
// Device Definition: ECU = drives TX, samples RX (powers the sensor),
//                    SENSOR = powered slave end.

interface PSI5(role)
{
    topology = "point to point"
    mode = ["half duplex"]

    // Corpus verdict (PSI5 v1.3/v2.x; ST L9663 transceiver, L9662
    // satellite interface, inertial/pressure sensors NXLS95120/
    // FXPS71407, Elmos E981): the retired voltage row is falsified by
    // the corpus -- PSI5 is a current-modulated supply pair, and the
    // bus supply windows are per-part classes (4.0~16.5 V NXLS95120,
    // 4.2~16.0 V FXPS71407), not a 5 V interface envelope. Every
    // threshold is rail-relative (sync detection dV = VPSI5 + 1.0/1.5/
    // 2.0 V; L9663 Vt2 min 3.5 V v1.3 vs 2.5 V v2.x -- the two spec
    // generations split the classes). The electrical population is
    // three documents with values, below the five-sample bar for
    // require keys, so the .ELEC book stays a registered candidate
    // (302) rather than a minted one; the row dies here either way.

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    pins = [
        1 = _ @class(digital) // TX (current modulation drive)
        2 = _ @class(digital) // RX (voltage modulation sense)
    ]

    role ECU {
        name = "PSI5 ECU"
        pins = [
            out 1 = TX @class(digital), "Command/supply modulation drive"
            in 2 = RX @class(digital), "Sensor answer sense"
        ]
        peer = SENSOR
    }

    role SENSOR {
        name = "PSI5 Sensor"
        pins = [
            in 1 = TX @class(digital), "Command/supply modulation"
            out 2 = RX @class(digital), "Answer modulation"
        ]
        peer = ECU
    }
}

// PSI5.S - PSI5 Synchronous Serial Variant Standard Definition
// Core Rule: PSI5 with a synchronous serial answer channel: the ECU
//            clocks commands out on STX and samples the sensor answer on
//            SRX; separate from the current-modulated base channel (PSI5)
//            — the variants share a name family, not a conductor view.
// Device Definition: ECU = drives STX, samples SRX,
//                    SENSOR = powered slave end.

interface PSI5.S(role)
{
    topology = "point to point"
    mode = ["full duplex"]

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    pins = [
        1 = _ @class(digital) // STX <-> STX
        2 = _ @class(digital) // SRX <-> SRX
    ]

    role ECU {
        name = "PSI5.S ECU"
        pins = [
            out 1 = STX @class(digital), "Serial transmit (clocked)"
            in 2 = SRX @class(digital), "Serial receive (clocked)"
        ]
        peer = SENSOR
    }

    role SENSOR {
        name = "PSI5.S Sensor"
        pins = [
            in 1 = STX @class(digital), "Serial transmit (clocked)"
            out 2 = SRX @class(digital), "Serial receive (clocked)"
        ]
        peer = ECU
    }
}
