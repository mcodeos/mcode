# Copyright (c) 2026 MCode
#
# Licensed under the Apache License, Version 2.0.

# Basic LED Component
# Generic light-emitting diode with fundamental parameters
component LED(vfwd::UV.VOLT, ifwd::UV.AMP, wavelength::UV.LEN)
{
    name = "LED"
    spec = [
        forward_voltage = vfwd // [1.8V, 2.0V, 2.2V, 3.2V, 3.6V]
        forward_current = ifwd // [10mA, 20mA, 30mA, 50mA, 100mA]
        wavelength = wavelength // [460nm, 520nm, 620nm, 650nm, 850nm, 940nm]
    ]
    
    pins = [
        1 = ANODE            # Positive terminal
        2 = CATHODE          # Negative terminal
    ]
    
    func Indicator([positive, negative]::DC())
    {
        positive - this.ANODE
        this.CATHODE - negative
        return this
    }
}

# RGB LED
# Light-emitting diode with red, green, and blue channels
component LED.RGB(vred::UV.VOLT, vgreen::UV.VOLT, vblue::UV.VOLT, ifwd::UV.AMP)
{
    name = "RGB LED"
    spec = [
        red_forward_voltage = vred
        green_forward_voltage = vgreen
        blue_forward_voltage = vblue
        forward_current = ifwd
    ]
    
    pins = [
        1 = RED_ANODE        # Red channel positive
        2 = GREEN_ANODE      # Green channel positive
        3 = BLUE_ANODE       # Blue channel positive
        4 = COMMON_CATHODE   # Common negative terminal
    ]
    
    func Color(red_control, green_control, blue_control, gnd)
    {
        red_control - this.RED_ANODE
        green_control - this.GREEN_ANODE
        blue_control - this.BLUE_ANODE
        this.COMMON_CATHODE - gnd
        return this
    }
}

# Infrared LED
# Light-emitting diode for infrared radiation
component LED.IR(vfwd::UV.VOLT, ifwd::UV.AMP, wavelength::UV.LEN)
{
    name = "Infrared LED"
    spec = [
        forward_voltage = vfwd
        forward_current = ifwd
        wavelength = wavelength
    ]
    
    pins = [
        1 = ANODE            # Positive terminal
        2 = CATHODE          # Negative terminal
    ]
    
    func Transmit(driver::DC())
    {
        driver.VCC - this.ANODE
        this.CATHODE - driver.GND
        return this
    }
}

# High Power LED
# Light-emitting diode for high brightness applications
component LED.HP(vfwd::UV.VOLT, ifwd::UV.AMP, pmax::UV.WATT)
{
    name = "High Power LED"
    spec = [
        forward_voltage = vfwd // [3.0V, 3.2V, 3.4V, 3.6V]
        forward_current = ifwd // [350mA, 500mA, 700mA, 1.0A, 2.0A]
        power_rated = pmax // [1W, 3W, 5W, 10W, 20W]
    ]
    
    pins = [
        1 = ANODE            # Positive terminal
        2 = CATHODE          # Negative terminal
    ]
    
    func Light(driver::DC())
    {
        driver.VCC - this.ANODE
        this.CATHODE - driver.GND
        return this
    }
}

# Usage Examples:
# 1. Basic LED as indicator
# LED(2.2V, 20mA, 520nm).Indicator([vcc, gnd])

# 2. RGB LED for color indication
# LED.RGB(2.0V, 3.2V, 3.2V, 20mA).Color(red_pwm, green_pwm, blue_pwm, gnd)

# 3. Infrared LED for remote control
# LED.IR(1.2V, 100mA, 940nm).Transmit(ir_driver)

# 4. High power LED for illumination
# LED.HP(3.2V, 1.0A, 3.2W).Light(led_driver)