# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

interface DBG.JTAG(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // JTAG (Joint Test Action Group) Standard Definition
    // Core Rule: Standard interface for boundary scan testing and debugging of integrated circuits
    // JTAG Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: TAP = Test Access Port (target device), HOST = JTAG debugger/programmer
    // Applications: Chip testing, firmware programming, embedded system debugging

    // Role-less conductor view: 5 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1). Mediated devices and module ports bind
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

    role HOST {  // JTAG Host - Debugger/programmer (the TAP controller lives in the target, IEEE 1149.1)
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

interface DBG.JTAG.2(role)
{
    topology = "point to point"
    mode = ["half duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // 2-Wire JTAG (JTAG Lite / SWJ) Standard Definition
    // Core Rule: Reduced pin count JTAG using bidirectional SWDIO/SWMS line
    // Principle: TDI and TDO are multiplexed on a single bidirectional pin (TMS)
    // 2-Wire JTAG Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: TAP = Test Access Port (target device), HOST = JTAG debugger/programmer
    // Protocol: Timing transitions on TMS determine whether data is sent or received

    pins = [
        1 = TCK @class(digital), "Test Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Clock signal for synchronization
        2 = TMS @class(digital), "Test Mode Select / Bidirectional Data", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Mode select + multiplexed TDI/TDO
    ]

    role TAP {  // Test Access Port - Target device being tested/debugged
        name = "2-Wire JTAG TAP"
        peer = HOST
    }

    role HOST {  // JTAG Host - Debugger/programmer (the TAP controller lives in the target, IEEE 1149.1)
        name = "2-Wire JTAG Host"
        peer = TAP
    }
}

interface DBG.DAP(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // DAP (Debug Access Port) Standard Definition
    // Core Rule: Debug interface for accessing debug ports of microcontrollers
    // DAP Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: HOST = Debugger, TARGET = Microcontroller
    // Applications: Microcontroller debugging, firmware programming

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

interface DBG.DAP.PU(role)
{
    topology = "point to point"
    mode = ["half duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // DAP.PU (3-pin Unidirectional) Standard Definition
    // Core Rule: 3-pin unidirectional debug access port
    // DAP.PU Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: HOST = Debugger, TARGET = Microcontroller
    // Applications: Simplified microcontroller debugging

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

interface DBG.DAP.WM(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // DAP.WM (3-pin Wide Mode) Standard Definition
    // Core Rule: 3-pin wide mode debug access port
    // DAP.WM Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: HOST = Debugger, TARGET = Microcontroller
    // Applications: Enhanced microcontroller debugging

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

interface DBG.CMSISDAP(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // CMSIS_DAP (ARM CMSIS Debug Access Port) Standard Definition
    // Core Rule: ARM standard debug interface for Cortex-M microcontrollers
    // CMSIS_DAP Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: HOST = Debugger, TARGET = Cortex-M microcontroller
    // Applications: Cortex-M microcontroller debugging, firmware programming

    //ARM CMSIS DAP standard, for Cortext-M
    // Debug family pin-order law: data first, then clock, then control/reset
    // (DBG.JTAG TDI,TDO,TCK,TMS,_TRST; DBG.SWD SWDIO,SWCLK,_RST; DBG.ICD PGED,PGEC).
    // With no data lane here, the clock precedes the mode select to match.
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

interface DBG.SWD(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // SWD (Serial Wire Debug) Standard Definition
    // Core Rule: ARM standard two-wire debug interface
    // SWD Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: HOST = Debugger, TARGET = ARM microcontroller
    // Applications: ARM microcontroller debugging, firmware programming

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

interface DBG.SWIM(role)
{
    topology = "point to point"
    mode = ["half duplex"]
    maxdistance = 0.5m
    maxspeed = [1MHz]
    voltage = [3.3V,5V]

    // SWIM (Single Wire Interface Module) Standard Definition
    // Core Rule: STMicroelectronics single-wire debug interface
    // SWIM Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: HOST = Debugger, TARGET = STM8/STM32 microcontroller
    // Applications: STMicroelectronics microcontroller debugging, firmware programming

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

interface DBG.ICD(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [3.3V,5V]

    // ICD (In-Circuit Debugger) Standard Definition
    // Core Rule: Microchip standard debug interface
    // ICD Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: HOST = Debugger, TARGET = Microchip microcontroller
    // Applications: Microchip microcontroller debugging, firmware programming

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

interface DBG.UARTBOOT(role)
{
    topology = "point to point"
    mode = ["half duplex"]
    maxdistance = 15m
    maxspeed = [115200bps]
    voltage = [1.8V,3.3V,5V]

    // UART Bootloader Standard Definition
    // Core Rule: Serial bootloader interface for firmware programming
    // UART Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: HOST = Programming device, TARGET = Microcontroller
    // Applications: Firmware programming, bootloader updates

    // Role-less conductor view: 3 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1). Mediated devices and module ports bind
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
