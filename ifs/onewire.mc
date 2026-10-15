# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// ONEWIRE - 1-Wire Bus Interface Standard Definition
// Core Rule: Single-wire half-duplex multi-point bus, open-drain with an
//            external pullup — every node releases the line by driving
//            high (a push-pull driver states @drive(pp) on its own
//            adoption row). The ground reference is shared through the
//            power supply, so the face has no ground member; parasitic
//            power over the data line is the family's signature mode.
// Device Definition: MASTER = initiates and times every exchange,
//                    SLAVE = responds when addressed.
// Note: a bus tap is a single pin, one instance per bus
//       (OW0::ONEWIRE(MASTER); OW0[1:2] binds one pin per member).

interface ONEWIRE(role)
{
    topology = "multi-point"
    mode = ["half duplex"]
    // No interface electrical book: the device corpus (DS18B20 family,
    // DS2502; four distinct parts, one temperature family plus an EPROM --
    // below the five-sample bar) decomposes every candidate key. Supply:
    // per-part windows (DS18B20 VDD/VPU 3.0~5.5 V; DS2502 VPUP min 2.8 V
    // with a part-internal 2.5/2.8 V split) -- per-part DC face when the
    // parts are authored. Pull-up: the 4.7 kOhm figure is prose/app-note
    // practice with no MIN/MAX spec row anywhere -- the effective value
    // is an RC rise-time trade against cable capacitance (1~4.7 kOhm by
    // bus). Speed: the slot timing (standard ~14-16 kbps, overdrive
    // ~125 kbps class) is the protocol timing identity, not a link-rate
    // contract. Distance: no maximum bus length is a guaranteed spec
    // number anywhere -- cable-capacitance guidance throughout; the
    // retired 100 m row was application folklore.

    pins = [
        1 = _ @drive(od) @class(digital)
    ]

    role MASTER {
        name = "1-Wire Master"
        peer = SLAVE
    }

    role SLAVE {
        name = "1-Wire Slave"
        peer = MASTER
    }
}
