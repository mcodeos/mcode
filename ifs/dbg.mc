# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// DBG - debug and programming link family. Electrical contract data rides
// the ELEC.DBG.JTAG / ELEC.DBG.SWD recipe faces (302 3.2); the 2-wire JTAG
// member rides the JTAG face as a variant. All debug pins inherit the GPIO
// EC tables (the corpus law: debug pins appear as alternate-function rows
// in per-part MCU datasheets; the only debug-specific EC face anywhere is
// the internal pull-up presence note, carried as the recipe pu option).
// The distance axis is stated by zero documents corpus-wide for any debug
// link (the retired maxdistance rows were folklore); supply tiers ride the
// DC supply faces. The DAP / DAP.PU / DAP.WM / CMSISDAP classes carry no
// corpus-witnessed interface-level electrical row (CMSIS-DAP is a host
// protocol face, not a two-wire electrical contract); SWIM states a rate
// only in the single protocol spec document (derived from the internal
// oscillator); ICD states the pin face only; UARTBOOT's electrical
// contract is the TTL UART face (ELEC.UART.TTL), bootloader rates being
// auto-baud detection rather than a link limit - these seven classes stay
// recipe-less by the gap ledger.

// DBG.JTAG - JTAG Debug Interface (5-wire) Standard Definition
// Electrical character: the ELEC.DBG.JTAG recipe face (rate option
// vocabulary, internal pull-bias note); the 2-wire DBG.JTAG.2 member rides
// the same contract as a variant.
// Core Rule: Five-wire synchronous debug/test link: TDI and TDO are
//            same-wire / role-flipped (HOST drives TDI, TAP returns on TDO),
//            plus clock, mode select, and an optional test reset; the TAP
//            controller lives in the target.
// Device Definition: HOST = debugger/programmer,
//                    TAP = test access port (target device).

interface DBG.JTAG(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    // Role-less conductor view: 5 anonymous lanes, ordinal = wire identity
    // Mediated devices and module ports bind
    // role-less and take their shape from this table; the role tables below
    // carry the named views: TDI and TDO are same-wire / role-flipped, and
    // the direction words flip per side.
    pins = [
        1 = _ @class(digital) // TDI (HOST out -> TAP in)
        2 = _ @class(digital) // TDO (TAP out -> HOST in)
        3 = _ @class(digital) // TCK
        4 = _ @class(digital) // TMS
        5 = _ @class(digital) // _TRST
    ]

    role TAP {  // Test Access Port - Target device being tested/debugged
        name = "JTAG TAP"
        pins = [
            in 1 = TDI @class(digital), "Test Data Input"  // Data input to the device
            out 2 = TDO @class(digital), "Test Data Output" // Data output from the device
            3 = TCK @class(digital), "Test Clock"           // Clock signal for synchronization
            4 = TMS @class(digital), "Test Mode Select"     // Controls the state machine
            5 = _TRST @class(digital), "Test Reset (datasheet TRST)"          // Optional reset signal
        ]
        peer = HOST
    }

    role HOST {  // JTAG Host - Debugger/programmer (the TAP controller lives in the target)
        name = "JTAG Host"
        pins = [
            out 1 = TDI @class(digital), "Test Data Input"  // Same wire as the TAP's input
            in 2 = TDO @class(digital), "Test Data Output"  // Same wire as the TAP's output
            3 = TCK @class(digital), "Test Clock"           // Clock signal for synchronization
            4 = TMS @class(digital), "Test Mode Select"     // Controls the state machine
            5 = _TRST @class(digital), "Test Reset (datasheet TRST)"          // Optional reset signal
        ]
        peer = TAP
    }
}

// DBG.JTAG.2 - 2-Wire JTAG Interface Standard Definition
// Core Rule: Reduced-pin-count JTAG: TDI and TDO are multiplexed on the
//            single bidirectional TMS line beside TCK; timing transitions
//            on TMS determine whether data is sent or received.
// Device Definition: HOST = debugger/programmer,
//                    TAP = test access port (target device).

interface DBG.JTAG.2(role)
{
    topology = "point to point"
    mode = ["half duplex"]
    pins = [
        1 = TCK @class(digital), "Test Clock"  // Clock signal for synchronization
        2 = TMS @class(digital), "Test Mode Select / Bidirectional Data"  // Mode select + multiplexed TDI/TDO
    ]

    role TAP {  // Test Access Port - Target device being tested/debugged
        name = "2-Wire JTAG TAP"
        peer = HOST
    }

    role HOST {  // JTAG Host - Debugger/programmer (the TAP controller lives in the target)
        name = "2-Wire JTAG Host"
        peer = TAP
    }
}

// DBG.DAP - Debug Access Port Interface (2-pin) Standard Definition
// Core Rule: Two-pin debug access port for microcontroller debugging and
//            firmware programming.
// Device Definition: HOST = debugger,
//                    TARGET = microcontroller under debug.

interface DBG.DAP(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    pins =[
        1 = DAP0 @class(digital), "Debug Access Port 0"
        2 = DAP1 @class(digital), "Debug Access Port 1"
    ]
    
    role HOST {
        name = "DAP Host"
        peer = TARGET(1)
    }
    
    role TARGET {
        name = "DAP Target"
        peer = HOST(1)
    }
}

// DBG.DAP.PU - Debug Access Port Interface (3-pin unidirectional) Standard Definition
// Core Rule: Three-pin unidirectional debug access port for simplified
//            microcontroller debugging.
// Device Definition: HOST = debugger,
//                    TARGET = microcontroller under debug.

interface DBG.DAP.PU(role)
{
    topology = "point to point"
    mode = ["half duplex"]
    // 3 pin unidir
    pins = [
        1 = DAP0 @class(digital), "Debug Access Port 0"
        2 = DAP1 @class(digital), "Debug Access Port 1"
        3 = DAP2 @class(digital), "Debug Access Port 2"
    ]

    role HOST {
        name = "DAP.PU Host"
        peer = TARGET(1)
    }

    role TARGET {
        name = "DAP.PU Target"
        peer = HOST(1)
    }
}

// DBG.DAP.WM - Debug Access Port Interface (3-pin wide mode) Standard Definition
// Core Rule: Three-pin wide-mode debug access port for enhanced
//            microcontroller debugging.
// Device Definition: HOST = debugger,
//                    TARGET = microcontroller under debug.

interface DBG.DAP.WM(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    // 3 Pin wide mode
    pins = [
        1 = DAP0 @class(digital), "Debug Access Port 0"
        2 = DAP1 @class(digital), "Debug Access Port 1"
        3 = DAP2 @class(digital), "Debug Access Port 2"
    ]

    role HOST {
        name = "DAP.WM Host"
        peer = TARGET(1)
    }

    role TARGET {
        name = "DAP.WM Target"
        peer = HOST(1)
    }
}

// DBG.CMSISDAP - CMSIS-DAP Debug Interface Standard Definition
// Core Rule: Two-wire debug face (clock, mode select) plus reset; with no
//            data lane here, the clock precedes the mode select to match
//            the debug family pin-order law (data first, then clock, then
//            control/reset).
// Device Definition: HOST = debugger,
//                    TARGET = microcontroller under debug.

interface DBG.CMSISDAP(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    // Debug family pin-order law: data first, then clock, then
    // control/reset (DBG.JTAG TDI,TDO,TCK,TMS,_TRST; DBG.SWD
    // SWDIO,SWCLK,_RST; DBG.ICD PGED,PGEC). With no data lane here, the
    // clock precedes the mode select to match.
    pins = [
        1 = TCK @class(digital), "Test Clock"
        2 = TMS @class(digital), "Test Mode Select"
        3 = _RST @class(digital), "Reset (datasheet nRST)"
    ]
    
    role HOST {
        name = "CMSIS_DAP Host"
        peer = TARGET(1)
    }
    
    role TARGET {
        name = "CMSIS_DAP Target"
        peer = HOST(1)
    }
}

// DBG.SWD - Serial Wire Debug Interface Standard Definition
// Electrical character: the ELEC.DBG.SWD recipe face (rate option
// vocabulary, SWDIO internal pull-up); the VREF member row is the
// debug-adapter connector convention, not a per-part supply tier.
// Core Rule: Two-wire debug link (bidirectional SWDIO, clock SWCLK) plus
//            an optional reset and the target reference voltage.
// Device Definition: HOST = debugger,
//                    TARGET = SWD-class microcontroller.

interface DBG.SWD(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    pins = [
        1 = SWDIO @class(digital), "Serial Wire Debug Input/Output"
        2 = SWCLK @class(digital), "Serial Wire Debug Clock"
        3 = _RST @class(digital), "Reset (datasheet nRST)"
        4 = VREF @class(digital), "Reference Voltage"
    ]
    
    role HOST {
        name = "SWD Host"
        peer = TARGET(1)
    }
    
    role TARGET {
        name = "SWD Target"
        peer = HOST(1)
    }
}

// DBG.SWIM - Single Wire Interface Module Debug Interface Standard Definition
// Core Rule: Single-wire half-duplex debug link plus reset and ground
//            members.
// Device Definition: HOST = debugger,
//                    TARGET = SWIM-class microcontroller.

interface DBG.SWIM(role)
{
    topology = "point to point"
    mode = ["half duplex"]
    pins = [
        1 = SWIM @class(digital), "Single Wire Interface Module"
        2 = _RST @class(digital), "Reset (datasheet NRST)"
        3 = GND, "Ground"
    ]

    role HOST {
        name = "SWIM Host"
        peer = TARGET(1)
    }
    
    role TARGET {
        name = "SWIM Target"
        peer = HOST(1)
    }
}

// DBG.ICD - In-Circuit Debugger Interface (2-wire) Standard Definition
// Core Rule: Two-wire in-circuit debug link (program/debug data PGED and
//            clock PGEC) plus the master-clear reset.
// Device Definition: HOST = debugger,
//                    TARGET = ICD-class microcontroller.

interface DBG.ICD(role)
{
    topology = "point to point"
    mode = ["full duplex"]

    pins = [
        1 = PGED @class(digital), "Program/Debug Enable"
        2 = PGEC @class(digital), "Program/Debug Clock"
        3 = _MCLR @class(digital), "Master Clear (datasheet MCLR overbar)"
    ]
    
    role HOST {
        name = "ICD Host"
        peer = TARGET(1)
    }
    
    role TARGET {
        name = "ICD Target"
        peer = HOST(1)
    }
}

// DBG.UARTBOOT - UART Bootloader Interface Standard Definition
// Core Rule: Serial bootloader link over a crossed UART data pair (the
//            host transmits on ordinal 1, the target answers on ordinal
//            2) plus ground.
// Device Definition: HOST = programming device,
//                    TARGET = microcontroller bootloader.

interface DBG.UARTBOOT(role)
{
    topology = "point to point"
    mode = ["half duplex"]
    // Role-less conductor view: 3 anonymous lanes, ordinal = wire identity
    //. Mediated devices and module ports bind
    // role-less and take their shape from this table; the role tables below
    // carry the named views: the data pair crosses by position (TXD <-> RXD).
    pins = [
        1 = _ @class(digital) // TXD <-> RXD
        2 = _ @class(digital) // RXD <-> TXD
        3 = _ // GND
    ]

    role HOST {
        name = "UART Bootloader Host"
        pins = [
            out 1 = TXD @class(digital), "Transmit Data"
            in 2 = RXD @class(digital), "Receive Data"
            3 = GND, "Ground"
        ]
        peer = TARGET(1)
    }

    role TARGET {
        name = "UART Bootloader Target"
        pins = [
            in 1 = RXD @class(digital), "Receive Data, from the host TXD"  // Same wire as ordinal 1
            out 2 = TXD @class(digital), "Transmit Data, to the host RXD"   // Same wire as ordinal 2
            3 = GND, "Ground"
        ]
        peer = HOST(1)
    }
}
