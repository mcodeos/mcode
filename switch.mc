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

# Basic Switch Component
component SWITCH
{
    name = "Basic Switch"
    description = "on/off switch with two terminals"
    
    pins = [
        1 = COM, "Common terminal"
        2 = NO , "Normally Open terminal"
    ]
}

# Double Pole Switch Component
component SWITCH.DOUBLE
{
    name = "Double Pole Switch"
    description = "Double pole switch with four terminals"
    
    pins = [
        1 = COM1, "Common terminal 1"
        2 = NO1 , "Normally Open terminal 1"
        3 = COM2, "Common terminal 2"
        4 = NO2 , "Normally Open terminal 2"
    ]
}

# Toggle Switch Component
component SWITCH.TOGGLE
{
    name = "Toggle Switch"
    description = "Toggle switch with on/off positions"
    
    pins = [
        1 = COM, "Common terminal"
        2 = NO , "Normally Open terminal"
        3 = NC , "Normally Closed terminal"
    ]
}

# Momentary Switch Component
component SWITCH.MOM
{
    name = "Momentary Switch"
    description = "Momentary push button switch"

    pins = [
        1 = COM, "Common terminal"
        2 = NO , "Normally Open terminal"
    ]
}

# Momentary Push Button Component
component BUTTON
{
    name = "Momentary Push Button"
    description = "Momentary push button (tact switch) with common and normally-open terminals"

    pins = [
        1 = COM, "Common terminal"
        2 = NO , "Normally Open terminal"
    ]
}

# DIP Switch Component (independent SPST slides; formal = total pin count)
component SWITCH.DIP(pin_count::INT)
{
    name = "DIP Switch"
    description = "DIP switch with " + pins + " pins, independent SPST slides"

    spec = [
        pin_count = pin_count
        pitch = _ // [2.54mm]
        style = _ // [slide, rotary]
        mount = _ // [through-hole, surface-mount]
    ]

    pins = [
        1:pin_count = 1:pin_count
    ]
    // Physical DIP contact map: switch k joins pin k with pin (pin_count+1-k),
    // i.e. an 8-pin part shorts 1-8, 2-7, 3-6, 4-5 when closed.
}

# Usage Examples:
# SWITCH sw1
# vcc -> sw1.COM
# sw1.NO -> switched_signal
# BUTTON btn1
# SWITCH.TOGGLE tog1
# SWITCH.MOM mom1
# SWITCH.DIP(8) addr_sel1          // 8 pins = 4 positions
# addr_sel1.1 -> gnd
# addr_sel1.8 -> i2c_addr0
