# Copyright 2026 MCode
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
    // Device Definition: TAP = Test Access Port (target device), Controller = JTAG debugger/programmer
    // Applications: Chip testing, firmware programming, embedded system debugging

    pins = [
        in 1 = TDI, "Test Data Input", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Data input to the device
        out 2 = TDO, "Test Data Output", voltage:[low:0V ~ 0.8V, high:2V ~ 5V] // Data output from the device
        3 = TCK, "Test Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]           // Clock signal for synchronization
        4 = TMS, "Test Mode Select", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]     // Controls the state machine
        5 = TRST, "Test Reset", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]          // Optional reset signal
    ]
    
    role TAP {  // Test Access Port - Target device being tested/debugged
        name = "JTAG TAP"
        peer = Controller
    }
    
    role Controller {  // JTAG Controller - Debugger/programmer
        name = "JTAG Controller"
        peer = TAP
    }
}

interface DBG.JTAG.2WIRE(role)
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
    // Device Definition: TAP = Test Access Port (target device), Controller = JTAG debugger/programmer
    // Protocol: Timing transitions on TMS determine whether data is sent or received

    pins = [
        1 = TCK, "Test Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Clock signal for synchronization
        2 = TMS, "Test Mode Select / Bidirectional Data", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]  // Mode select + multiplexed TDI/TDO
    ]

    role TAP {  // Test Access Port - Target device being tested/debugged
        name = "2-Wire JTAG TAP"
        peer = Controller
    }

    role Controller {  // JTAG Controller - Debugger/programmer
        name = "2-Wire JTAG Controller"
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
    // Device Definition: Host = Debugger, Target = Microcontroller
    // Applications: Microcontroller debugging, firmware programming

    pins =[
        1 = DAP0, "Debug Access Port 0", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = DAP1, "Debug Access Port 1", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
    ]
    
    role Host {
        name = "DAP Host"
        peer = Target
    }
    
    role Target {
        name = "DAP Target"
        peer = Host
    }
}

interface DBG.DAP3PU(role)
{
    topology = "point to point"
    mode = ["half duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // DAP3PU (3 Pin Unidirectional) Standard Definition
    // Core Rule: 3-pin unidirectional debug access port
    // DAP3PU Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: Host = Debugger, Target = Microcontroller
    // Applications: Simplified microcontroller debugging

    // 3 pin unidir 
    pins = [
        1 = DAP0, "Debug Access Port 0", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = DAP1, "Debug Access Port 1", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = DAP2, "Debug Access Port 2", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
    ]
    
    role Host {
        name = "DAP3PU Host"
        peer = Target
    }
    
    role Target {
        name = "DAP3PU Target"
        peer = Host
    }
}

interface DBG.DAPWM(role)
{
    topology = "point to point"
    mode = ["full duplex"]
    maxdistance = 0.5m
    maxspeed = [10MHz]
    voltage = [1.8V,3.3V,5V]

    // DAPWM (3 Pin Wide Mode) Standard Definition
    // Core Rule: 3-pin wide mode debug access port
    // DAPWM Level Spec: High = VCC (Logic 1), Low = GND (Logic 0)
    // Device Definition: Host = Debugger, Target = Microcontroller
    // Applications: Enhanced microcontroller debugging

    // 3 Pin wide mode
    pins = [
        1 = DAP0, "Debug Access Port 0", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = DAP1, "Debug Access Port 1", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = DAP2, "Debug Access Port 2", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
    ]
    
    role Host {
        name = "DAPWM Host"
        peer = Target
    }
    
    role Target {
        name = "DAPWM Target"
        peer = Host
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
    // Device Definition: Host = Debugger, Target = Cortex-M microcontroller
    // Applications: Cortex-M microcontroller debugging, firmware programming

    //ARM CMSIS DAP standard, for Cortext-M
    pins = [
        1 = TMS, "Test Mode Select", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = TCK, "Test Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = RST, "Reset", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
    ]
    
    role Host {
        name = "CMSIS_DAP Host"
        peer = Target
    }
    
    role Target {
        name = "CMSIS_DAP Target"
        peer = Host
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
    // Device Definition: Host = Debugger, Target = ARM microcontroller
    // Applications: ARM microcontroller debugging, firmware programming

    pins = [
        1 = SWDIO, "Serial Wire Debug Input/Output", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = SWCLK, "Serial Wire Debug Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = nRST, "Reset", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        4 = VREF, "Reference Voltage", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
    ]
    
    role Host {
        name = "SWD Host"
        peer = Target
    }
    
    role Target {
        name = "SWD Target"
        peer = Host
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
    // Device Definition: Host = Debugger, Target = STM8/STM32 microcontroller
    // Applications: STMicroelectronics microcontroller debugging, firmware programming

    pins = [
        1 = SWIM, "Single Wire Interface Module", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = RST, "Reset", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = GND, "Ground"
    ]
    
    role Host {
        name = "SWIM Host"
        peer = Target
    }
    
    role Target {
        name = "SWIM Target"
        peer = Host
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
    // Device Definition: Host = Debugger, Target = Microchip microcontroller
    // Applications: Microchip microcontroller debugging, firmware programming

    pins = [
        1 = PGED, "Program/Debug Enable", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = PGEC, "Program/Debug Clock", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = MCLR, "Master Clear/Reset", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
    ]
    
    role Host {
        name = "ICD Host"
        peer = Target
    }
    
    role Target {
        name = "ICD Target"
        peer = Host
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
    // Device Definition: Host = Programming device, Target = Microcontroller
    // Applications: Firmware programming, bootloader updates

    pins = [
        1 = TXD, "Transmit Data", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        2 = RXD, "Receive Data", voltage:[low:0V ~ 0.8V, high:2V ~ 5V]
        3 = GND, "Ground"
    ]
    
    role Host {
        name = "UART Bootloader Host"
        peer = Target
    }
    
    role Target {
        name = "UART Bootloader Target"
        peer = Host
    }
}
