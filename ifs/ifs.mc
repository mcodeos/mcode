# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// Interface definitions
// All interfaces are defined in separate files and imported here

// General Purpose Interfaces
pub use ./gpio.mc       // GPIO interface
pub use ./pwm.mc        // PWM interface (PWM, PWM.H6)
pub use ./stepdir.mc    // STEPDIR stepper control interface
pub use ./enc.mc        // ENC incremental quadrature encoder interface (2-phase A/B)
pub use ./onewire.mc    // OneWire interface
pub use ./xtal.mc       // XTAL interface for crystal oscillators
pub use ./rst.mc        // RST reset control interface (reset source / reset bodies)
pub use ./isolation.mc  // ISOLATION galvanic-isolation barrier face
pub use ./dc.mc         // DC power supply interface
pub use ./vref.mc       // VREF voltage reference interface
pub use ./ac.mc         // AC mains power interface (single-phase)
pub use ./cmp.mc        // CMP voltage comparator interfaces (compare input, CMP.OUT result)
pub use ./lvd.mc        // LVD low-voltage detection interfaces (monitored rail, LVD.OUT alarm)

// Communication Interfaces
pub use ./uart.mc       // UART interfaces (TTL, RS232, RS422, RS423, RS449, RS485)
pub use ./i2c.mc        // I2C interface
pub use ./i2s.mc        // I2S interface
pub use ./spi.mc        // SPI interface (SPI, SPI.3WIRE, SPI.QUAD, SPI.WO)
pub use ./sdio.mc       // SDIO interface (SDIO, SDIO.1BIT)
pub use ./usb.mc        // USB interface
pub use ./pcm.mc        // PCM interface
pub use ./can.mc        // CAN interface
pub use ./ethernet.mc   // Ethernet interface
pub use ./mii.mc        // MII / RMII interfaces
pub use ./mdio.mc       // MDIO interface (PHY serial management)
pub use ./dp.mc         // DisplayPort interface
pub use ./lvds.mc       // LVDS interface (clock + 4 data pairs)
pub use ./mipi.mc       // MIPI DSI / CSI interfaces (D-PHY)
pub use ./spdif.mc      // S/PDIF interface
pub use ./pmbus.mc      // PMBus interface

// Analog Interfaces
pub use ./adcdiff.mc    // ADC.DIFF interface
pub use ./adcsingle.mc  // ADC.SINGLE interface (single-ended analog input)
pub use ./dac.mc        // DAC interface
pub use ./ampbtl.mc     // AMP.BTL interface

// Clock Interfaces
pub use ./clkdiff.mc    // CLK.DIFF interface (differential clock pair)
pub use ./clk.mc        // CLK interface (single-ended clock)

// Automotive Interfaces
pub use ./flexray.mc    // FlexRay interface
pub use ./most.mc       // MOST interface
pub use ./lin.mc        // LIN interface

// Debug Interfaces
pub use ./dbg.mc        // Debug interfaces (JTAG, SWD, SWIM, ICD, UART Bootloader)

// Logic Gate Interfaces
pub use ./logic.mc     // Logic gates (AND, OR, NOT, NAND, NOR, XOR, XNOR)

