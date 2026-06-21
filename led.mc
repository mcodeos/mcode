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

# Basic LED Component
# Generic light-emitting diode with fundamental parameters
component LED(fv::UV.VOLT, fi::UV.AMP)
{
    name = "LED"
    spec = [
        forward_voltage = fv // [1.8V, 2.0V, 2.2V, 3.2V, 3.6V]
        forward_current = fi // [10mA, 20mA, 30mA, 50mA, 100mA]
        wavelength = _ // [460nm, 520nm, 620nm, 650nm, 850nm, 940nm]
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
component LED.RGB(vr::UV.VOLT, vg::UV.VOLT, vb::UV.VOLT, fi::UV.AMP)
{
    name = "RGB LED"
    spec = [
        red_forward_voltage = vr
        green_forward_voltage = vg
        blue_forward_voltage = vb
        forward_current = fi
    ]
    
    pins = [
        1 = RED_ANODE        # Red channel positive
        2 = GREEN_ANODE      # Green channel positive
        3 = BLUE_ANODE       # Blue channel positive
        4 = COMMON_CATHODE   # Common negative terminal
    ]
    
    func ColorIndicator(red_control, green_control, blue_control, ground)
    {
        red_control - this.RED_ANODE
        green_control - this.GREEN_ANODE
        blue_control - this.BLUE_ANODE
        this.COMMON_CATHODE - ground
        return this
    }
}

# Infrared LED
# Light-emitting diode for infrared radiation
component LED.IR(fv::UV.VOLT, fi::UV.AMP)
{
    name = "Infrared LED"
    spec = [
        forward_voltage = fv
        forward_current = fi
        wavelength = _
    ]
    
    pins = [
        1 = ANODE            # Positive terminal
        2 = CATHODE          # Negative terminal
    ]
    
    func IRTransmitter(driver::DC())
    {
        driver.VCC - this.ANODE
        this.CATHODE - driver.GND
        return this
    }
}

# High Power LED
# Light-emitting diode for high brightness applications
component LED.HP(fv::UV.VOLT, fi::UV.AMP, pow::UV.WAT)
{
    name = "High Power LED"
    spec = [
        forward_voltage = fv // [3.0V, 3.2V, 3.4V, 3.6V]
        forward_current = fi // [350mA, 500mA, 700mA, 1.0A, 2.0A]
        power = pow // [1W, 3W, 5W, 10W, 20W]
    ]
    
    pins = [
        1 = ANODE            # Positive terminal
        2 = CATHODE          # Negative terminal
    ]
    
    func Illumination(driver::DC())
    {
        driver.VCC - this.ANODE
        this.CATHODE - driver.GND
        return this
    }
}

# Usage Examples:
# 1. Basic LED as indicator
# LED(2.2V, 20mA).Indicator(vcc, gnd)

# 2. RGB LED for color indication
# LED.RGB(2.0V, 3.2V, 3.2V, 20mA).ColorIndicator(red_pwm, green_pwm, blue_pwm, gnd)

# 3. Infrared LED for remote control
# LED.IR(1.2V, 100mA).IRTransmitter(ir_driver)

# 4. High power LED for illumination
# LED.HP(3.2V, 1.0A, 3.2W).Illumination(led_driver)