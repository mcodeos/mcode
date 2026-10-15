# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// LED container: the emitting-junction family contract. The entry pair
// adopts the DIO terminal face (A = anode, K = cathode); the answer columns
// carry the drive and optical faces. Datasheet evidence (5-sheet sample:
// WS2812B / SK6812 / LTST-C19FD1WT / HSML-C191 / SML12R89): VF is witnessed
// as a symbol; the current and power heads are full phrases (DC Forward
// Current / Power Dissipation) with no symbol face; the wavelength symbols
// are the non-ASCII lambda-p / lambda-d subscripts (desc notes).

recipe LED {
    // Entry pair anchor, bare member names; adopters bind [A, K]::DIO()
    // (the SCR container shape - bare rows match the group-exposed pads).
    io A
    io K

    require = [
        electrical = [
            forward_voltage = Voltage, alias: [VF], desc: "forward voltage at the rated current (sheet head Forward Voltage, VF)"
            forward_current = Current, desc: "continuous forward current rating (sheet heads: DC Forward Current - full phrase, no symbol face)"
        ]
    ]
    option = [
        optical = [
            wavelength  = Length, desc: "peak / dominant emission wavelength (sheet symbols are the non-ASCII lambda-p / lambda-d subscripts - not lexable, stay desc notes)"
            power_rated = Power, desc: "power dissipation rating (sheet head Power Dissipation - full phrase, no symbol face)"
        ]
    ]
}

// RGB container: three independent emitters on one common cathode; the
// per-channel forward voltages are the design quantities (per-color sheet
// columns carry no separate symbols). Terminal face stays on the classes
// (four discrete pads, no group adoption).
recipe LED.RGB {
    require = [
        electrical = [
            red_forward_voltage   = Voltage, desc: "red channel forward voltage (per-color sheet columns)"
            green_forward_voltage = Voltage, desc: "green channel forward voltage (per-color sheet columns)"
            blue_forward_voltage  = Voltage, desc: "blue channel forward voltage (per-color sheet columns)"
            forward_current       = Current, desc: "per-channel continuous forward current rating"
        ]
    ]
}

// LED - Indicator Light-Emitting Diode Component Definition
// Core Rule: forward-biased junction emits light at the rated wavelength;
// forward voltage sets the dropper/budget, forward current sets the
// brightness and must be limited externally.

abstract component LED(vfwd::UV.VOLT, ifwd::UV.AMP, wavelength::UV.LEN) :: LED {
    name = "LED"
    spec = [
        forward_voltage = vfwd        // [1.8V, 2.0V, 2.2V, 3.2V, 3.6V]
        forward_current = ifwd        // [10mA, 20mA, 30mA, 50mA, 100mA]
        wavelength      = wavelength  // [460nm, 520nm, 620nm, 650nm, 850nm, 940nm]
    ]

    pins = [
        io [1, 2] = [A, K]::DIO()  // A = anode (pad 1), K = cathode — bare member names (schematic face)
    ]

    func Indicator([positive, negative]::DC()) {
        positive - this.A
        this.K - negative
        return this
    }
}

// LED.RGB - Three-Channel RGB LED Component Definition
// Core Rule: three independent emitters (red, green, blue anodes) sharing one
// common cathode; each channel has its own forward voltage and needs its own
// current limit.

abstract component LED.RGB(vred::UV.VOLT, vgreen::UV.VOLT, vblue::UV.VOLT, ifwd::UV.AMP) :: LED.RGB {
    name = "RGB LED"
    spec = [
        red_forward_voltage   = vred
        green_forward_voltage = vgreen
        blue_forward_voltage  = vblue
        forward_current       = ifwd
    ]

    pins = [
        1 = RED_ANODE       // Red channel positive
        2 = GREEN_ANODE     // Green channel positive
        3 = BLUE_ANODE      // Blue channel positive
        4 = COMMON_CATHODE  // Common negative terminal
    ]

    func Color(red_control, green_control, blue_control, gnd) {
        red_control - this.RED_ANODE
        green_control - this.GREEN_ANODE
        blue_control - this.BLUE_ANODE
        this.COMMON_CATHODE - gnd
        return this
    }
}

// LED.IR - Infrared LED Component Definition
// Core Rule: forward-biased junction emits in the infrared band; driven in
// pulsed or continuous mode by an external current limit.

abstract component LED.IR(vfwd::UV.VOLT, ifwd::UV.AMP, wavelength::UV.LEN) :: LED {
    name = "Infrared LED"
    spec = [
        forward_voltage = vfwd
        forward_current = ifwd
        wavelength      = wavelength
    ]

    pins = [
        io [1, 2] = [A, K]::DIO()  // A = anode (pad 1), K = cathode — bare member names (schematic face)
    ]

    func Transmit(driver::DC()) {
        driver.VCC - this.A
        this.K - driver.GND
        return this
    }
}

// LED.HP - High Power LED Component Definition
// Core Rule: high-current emitter rated by dissipated power — thermal
// management (heatsinking, derating) governs the drive level.

abstract component LED.HP(vfwd::UV.VOLT, ifwd::UV.AMP, pmax::UV.WATT) :: LED {
    name = "High Power LED"
    spec = [
        forward_voltage = vfwd  // [3.0V, 3.2V, 3.4V, 3.6V]
        forward_current = ifwd  // [350mA, 500mA, 700mA, 1.0A, 2.0A]
        power_rated     = pmax  // [1W, 3W, 5W, 10W, 20W]
    ]

    pins = [
        io [1, 2] = [A, K]::DIO()  // A = anode (pad 1), K = cathode — bare member names (schematic face)
    ]

    func Light(driver::DC()) {
        driver.VCC - this.A
        this.K - driver.GND
        return this
    }
}

// Usage Examples:
// 1. Basic LED as indicator
// LED(2.2V, 20mA, 520nm).Indicator([vcc, gnd])

// 2. RGB LED for color indication
// LED.RGB(2.0V, 3.2V, 3.2V, 20mA).Color(red_pwm, green_pwm, blue_pwm, gnd)

// 3. Infrared LED for remote control
// LED.IR(1.2V, 100mA, 940nm).Transmit(ir_driver)

// 4. High power LED for illumination
// LED.HP(3.2V, 1.0A, 3.2W).Light(led_driver)
