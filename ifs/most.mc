# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// MOST.OPT - MOST Optical Fiber Ring Interface Standard Definition
// Core Rule: Ring-topology multimedia network over plastic optical fiber:
//            frames circulate past every node in one direction and each
//            node relays in and out - one fiber per lane, the receive and
//            transmit fibers of one transceiver face. Carries all three
//            speed generations (22.5 / 50 / 150 Mbps).
// Device Definition: MASTER = ring timing master / control node,
//                    SLAVE = audio/video node on the ring,
//                    RELAY = the cable conductor view (fiber jumper).

interface MOST.OPT(role)
{
    topology = "ring"
    mode = ["full duplex"]
    // Electrical contract data rides the recipe face: ELEC.MOST.OPT carries
    // the optical link contract (peak wavelength window, transmit power
    // classes, received-power window -- the Broadcom AFBR / ODIN FOT manual
    // population, 8 of 8 stating the optical rows). The speed figures are
    // the generation identity and ride the per-part family face
    // (DEV.TRANS.MOST media.generation/rate). The distance row carried zero link
    // contract witnesses (the only corpus length figure is an Rx jitter
    // test condition); supply windows ride the DC faces.

    pins = [
        1 = TX @class(digital), "Optical transmit"    // fiber out to the downstream node
        2 = RX @class(digital), "Optical receive"     // fiber in from the upstream node
    ]

    role MASTER {
        name = "MOST Master"
        pins = [
            out 1 = TX @class(digital), "Optical transmit"    // relays the circulating frame stream out
            in 2 = RX @class(digital), "Optical receive"      // and in from the upstream node
        ]
        peer = SLAVE
    }

    role SLAVE {
        name = "MOST Slave"
        pins = [
            out 1 = TX @class(digital), "Optical transmit"    // relays the circulating frame stream out
            in 2 = RX @class(digital), "Optical receive"      // and in from the upstream node
        ]
        peer = MASTER
    }

    // Relay face: the cable's conductor view - inherits the table above
    // (two fibers) and selects no endpoint role. A jumper module binds
    // `io a::MOST.OPT(RELAY)` on each end and states its straight join
    // in the body; the TX <-> RX crossing comes from the endpoint roles.
    role RELAY {
        name = "MOST Optical Relay"
    }
}

// MOST.ELE - MOST Electrical Twisted-Pair Ring Interface Standard Definition
// Core Rule: Ring-topology multimedia network over the MOST50 electrical
//            physical layer: differential transmission on balanced twisted
//            pair, one pair per direction - the ring relays in and out.
//            50 Mbps generation.
// Device Definition: MASTER = ring timing master / control node,
//                    SLAVE = audio/video node on the ring,
//                    RELAY = the cable conductor view (twisted-pair segment).

interface MOST.ELE(role)
{
    topology = "ring"
    mode = ["full duplex"]
    // No recipe book: the MOST50 electrical (twisted-pair ePHY) contract is
    // a corpus blank -- zero twisted-pair PHY samples in the tree (the
    // carrying population covers the optical face only). No keys are minted
    // on a zero population; the ledger rides 302 s5.2 (ePHY sub-spec
    // cluster, first encountered = open a case). The speed figure is the
    // generation identity (rides DEV.TRANS.MOST media.generation/rate); supply
    // windows ride the DC faces; no distance witness (same verdict as the
    // optical face).

    pins = [
        1 = TX\+ @pair(tx) @class(digital), "Transmit Positive"    // differential pair, fiber-out equivalent
        2 = TX\- @pair(tx) @class(digital), "Transmit Negative"
        3 = RX\+ @pair(rx) @class(digital), "Receive Positive"     // differential pair, fiber-in equivalent
        4 = RX\- @pair(rx) @class(digital), "Receive Negative"
    ]

    role MASTER {
        name = "MOST Master"
        pins = [
            out 1 = TX\+ @pair(tx) @class(digital), "Transmit Positive"    // relays the circulating frame stream out
            out 2 = TX\- @pair(tx) @class(digital), "Transmit Negative"
            in 3 = RX\+ @pair(rx) @class(digital), "Receive Positive"      // and in from the upstream node
            in 4 = RX\- @pair(rx) @class(digital), "Receive Negative"
        ]
        peer = SLAVE
    }

    role SLAVE {
        name = "MOST Slave"
        pins = [
            out 1 = TX\+ @pair(tx) @class(digital), "Transmit Positive"    // relays the circulating frame stream out
            out 2 = TX\- @pair(tx) @class(digital), "Transmit Negative"
            in 3 = RX\+ @pair(rx) @class(digital), "Receive Positive"      // and in from the upstream node
            in 4 = RX\- @pair(rx) @class(digital), "Receive Negative"
        ]
        peer = MASTER
    }

    // Relay face: the cable's conductor view - inherits the table above
    // (two differential pairs) and selects no endpoint role. A segment
    // module binds `io a::MOST.ELE(RELAY)` on each end and states its
    // straight join in the body; the TX <-> RX crossing comes from the
    // endpoint roles.
    role RELAY {
        name = "MOST Electrical Relay"
    }
}

// MOST.COAX - MOST Coaxial Ring Interface Standard Definition
// Core Rule: Ring-topology multimedia network over the MOST150 electrical
//            physical layer on coaxial cable: single-ended lanes, one per
//            direction, the shield return rides the power domain (no GND
//            member on the face). 150 Mbps generation.
// Device Definition: MASTER = ring timing master / control node,
//                    SLAVE = audio/video node on the ring,
//                    RELAY = the cable conductor view (coax segment).

interface MOST.COAX(role)
{
    topology = "ring"
    mode = ["full duplex"]
    // No recipe book: the MOST150 coaxial (coaxPHY) contract is a corpus
    // blank -- zero coax-PHY samples in the tree. No keys are minted on a
    // zero population; the ledger rides 302 s5.2 beside the ePHY cluster.
    // The speed figure is the generation identity (rides DEV.TRANS.MOST
    // media.generation/rate); supply windows ride the DC faces; no distance
    // witness (same verdict as the optical face).

    pins = [
        1 = TX @class(digital), "Coaxial transmit"    // out to the downstream node
        2 = RX @class(digital), "Coaxial receive"     // in from the upstream node
    ]

    role MASTER {
        name = "MOST Master"
        pins = [
            out 1 = TX @class(digital), "Coaxial transmit"    // relays the circulating frame stream out
            in 2 = RX @class(digital), "Coaxial receive"      // and in from the upstream node
        ]
        peer = SLAVE
    }

    role SLAVE {
        name = "MOST Slave"
        pins = [
            out 1 = TX @class(digital), "Coaxial transmit"    // relays the circulating frame stream out
            in 2 = RX @class(digital), "Coaxial receive"      // and in from the upstream node
        ]
        peer = MASTER
    }

    // Relay face: the cable's conductor view - inherits the table above
    // (two coax lanes) and selects no endpoint role. A segment module
    // binds `io a::MOST.COAX(RELAY)` on each end and states its straight
    // join in the body; the TX <-> RX crossing comes from the endpoint
    // roles.
    role RELAY {
        name = "MOST Coaxial Relay"
    }
}

// MOST.FOT - MOST Fiber-Optic Transceiver Copper Interface Standard Definition
// Core Rule: The two-line board-level copper face between a MOST optical
//            network interface controller and its fiber-optic transceiver
//            module: one lane each way, the controller's transmit lane
//            landing on the transceiver's receive-data pin and the
//            transceiver's transmit-data pin feeding the controller's
//            receive lane (crossed naming, DCE/DTE form). Keep the run
//            short with an unbroken ground reference; series termination
//            sits at the driving end of each lane.
// Device Definition: NIC = the MOST network interface controller,
//                    FOT = the fiber-optic transceiver module.

interface MOST.FOT(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    // No interface electrical book: the board-level copper face is already
    // keyed by the category book DEV.TRANS.MOST (network v_out/v_in/c_in, supply
    // v_cc -- this very iface is that book's anchor). The FOT layout note
    // in the corpus (short unbroken ground run, series termination at the
    // driving source) is placement practice, not a link contract. The
    // supply window rides the DC faces.

    pins = [
        1 = _ @class(digital)    // NIC TX <-> FOT RX data
        2 = _ @class(digital)    // FOT TX data <-> NIC RX
    ]

    role NIC {
        name = "MOST NIC Copper Face"
        pins = [
            out 1 = TX @class(digital) @cross(FOT.RX), "Transmit - drives the RX-data pin of the FOT"
            in 2 = RX @class(digital) @cross(FOT.TX), "Receive - reads the TX-data pin of the FOT"
        ]
        peer = FOT(1)
    }

    role FOT {
        name = "MOST Transceiver Copper Face"
        pins = [
            in 1 = RX @class(digital) @cross(NIC.TX), "RX data - the lane the NIC drives"
            out 2 = TX @class(digital) @cross(NIC.RX), "TX data - the lane the NIC reads"
        ]
        peer = NIC(1)
    }
}
