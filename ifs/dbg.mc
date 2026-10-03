# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// DBG.JTAG - JTAG Debug Interface (5-wire) Standard Definition
// Core Rule: Five-wire synchronous debug/test link: the data pair crosses
//            by position (TDI <-> TDO), plus clock, mode select, and an
//            optional test reset; the TAP controller lives in the target.
// Device Definition: HOST = debugger/programmer,
//                    TAP = test access port (target device).

interface DBG.JTAG(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // Role-less conductor view: 5 anonymous lanes, ordinal = wire identity
    // Mediated devices and module ports bind
    // role-less and take their shape from this table; the role tables below
    // carry the named views: the data pair crosses by position (TDI <-> TDO),
    // and the direction words flip per side.
    pins = [
        1 = _ @class(digital) // TDI <-> TDO
        2 = _ @class(digital) // TDO <-> TDI
        3 = _ @class(digital) // TCK
        4 = _ @class(digital) // TMS
        5 = _ @class(digital) // _TRST
    ]

    role TAP {  // Test Access Port - Target device being tested/debugged
        name = "JTAG TAP"
        pins = [
            in 1 = TDI @class(digital), "Test Data Input", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Data input to the device
            out 2 = TDO @class(digital), "Test Data Output", voltage:[low:0V ~ 0.8V, high:2V ~ 5V] // Data output from the device
            3 = TCK @class(digital), "Test Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]           // Clock signal for synchronization
            4 = TMS @class(digital), "Test Mode Select", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]     // Controls the state machine
            5 = _TRST @class(digital), "Test Reset (datasheet TRST)", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]          // Optional reset signal
        ]
        peer = HOST
    }

    role HOST {  // JTAG Host - Debugger/programmer (the TAP controller lives in the target)
        name = "JTAG Host"
        pins = [
            out 1 = TDI @class(digital), "Test Data Input", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Same wire as the TAP's input
            in 2 = TDO @class(digital), "Test Data Output", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Same wire as the TAP's output
            3 = TCK @class(digital), "Test Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]           // Clock signal for synchronization
            4 = TMS @class(digital), "Test Mode Select", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]     // Controls the state machine
            5 = _TRST @class(digital), "Test Reset (datasheet TRST)", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]          // Optional reset signal
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
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    pins = [
        1 = TCK @class(digital), "Test Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Clock signal for synchronization
        2 = TMS @class(digital), "Test Mode Select / Bidirectional Data", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Mode select + multiplexed TDI/TDO
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
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    pins =[
        1 = DAP0 @class(digital), "Debug Access Port 0", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = DAP1 @class(digital), "Debug Access Port 1", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
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
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // 3 pin unidir
    pins = [
        1 = DAP0 @class(digital), "Debug Access Port 0", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = DAP1 @class(digital), "Debug Access Port 1", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = DAP2 @class(digital), "Debug Access Port 2", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
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
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // 3 Pin wide mode
    pins = [
        1 = DAP0 @class(digital), "Debug Access Port 0", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = DAP1 @class(digital), "Debug Access Port 1", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = DAP2 @class(digital), "Debug Access Port 2", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
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
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // Debug family pin-order law: data first, then clock, then
    // control/reset (DBG.JTAG TDI,TDO,TCK,TMS,_TRST; DBG.SWD
    // SWDIO,SWCLK,_RST; DBG.ICD PGED,PGEC). With no data lane here, the
    // clock precedes the mode select to match.
    pins = [
        1 = TCK @class(digital), "Test Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = TMS @class(digital), "Test Mode Select", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = _RST @class(digital), "Reset (datasheet nRST)", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
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
// Core Rule: Two-wire debug link (bidirectional SWDIO, clock SWCLK) plus
//            an optional reset and the target reference voltage.
// Device Definition: HOST = debugger,
//                    TARGET = SWD-class microcontroller.

interface DBG.SWD(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    pins = [
        1 = SWDIO @class(digital), "Serial Wire Debug Input/Output", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = SWCLK @class(digital), "Serial Wire Debug Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = _RST @class(digital), "Reset (datasheet nRST)", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        4 = VREF @class(digital), "Reference Voltage", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
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
    maxdistance = 0.5m
    maxspeed = [1MHz]
    voltage = [3.3V,5V]

    pins = [
        1 = SWIM @class(digital), "Single Wire Interface Module", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = _RST @class(digital), "Reset (datasheet NRST)", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
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
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [3.3V,5V]

    pins = [
        1 = PGED @class(digital), "Program/Debug Enable", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = PGEC @class(digital), "Program/Debug Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = _MCLR @class(digital), "Master Clear (datasheet MCLR overbar)", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
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
    maxdistance = 15m
    maxspeed = [115200bps]
    voltage = [1.8V,3.3V,5V]

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
            out 1 = TXD @class(digital), "Transmit Data", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
            in 2 = RXD @class(digital), "Receive Data", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
            3 = GND, "Ground"
        ]
        peer = TARGET(1)
    }

    role TARGET {
        name = "UART Bootloader Target"
        pins = [
            in 1 = RXD @class(digital), "Receive Data, from the host TXD", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Same wire as ordinal 1
            out 2 = TXD @class(digital), "Transmit Data, to the host RXD", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]   // Same wire as ordinal 2
            3 = GND, "Ground"
        ]
        peer = HOST(1)
    }
}
