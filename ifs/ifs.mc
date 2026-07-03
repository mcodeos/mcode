# Copyright 2026 MCode Alliance
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

// Interface definitions
// All interfaces are defined in separate files and imported here

// General Purpose Interfaces
pub use ./gpio.mc       // GPIO interface
pub use ./pwm.mc        // PWM interface
pub use ./onewire.mc    // OneWire interface
pub use ./xtal.mc       // XTAL interface for crystal oscillators
pub use ./dc.mc         // DC power supply interface

// Communication Interfaces
pub use ./uart.mc       // UART interfaces (TTL, RS232, RS422, RS423, RS449, RS485)
pub use ./i2c.mc        // I2C interface
pub use ./i2s.mc        // I2S interface
pub use ./spi.mc        // SPI interface
pub use ./usb.mc        // USB interface
pub use ./pcm.mc        // PCM interface
pub use ./can.mc        // CAN interface
pub use ./ethernet.mc   // Ethernet interface

// Analog Interfaces
pub use ./adcdiff.mc    // ADC.DIFF interface
pub use ./dac.mc        // DAC interface

// Automotive Interfaces
pub use ./flexray.mc    // FlexRay interface
pub use ./most.mc       // MOST interface
pub use ./lin.mc        // LIN interface

// Debug Interfaces
pub use ./dbg.mc        // Debug interfaces (JTAG, SWD, SWIM, ICD, UART Bootloader)

// Logic Gate Interfaces
pub use ./logic.mc     // Logic gates (AND, OR, NOT, NAND, NOR, XOR, XNOR)

