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

// ---------------------------------------------------------------------------------------------
// Video Connector Definitions
// ---------------------------------------------------------------------------------------------

// HDMI Connector
component VIDEO.HDMI()
{
    name = "HDMI Connector"
    description = "HDMI connector"
    
    spec = [
        standard = "HDMI"
        version = _ // [1.4, 2.0, 2.1]
        connector_type = _ // [A, C, D, E]
    ]
    
    pins = [
        1 = 1, "TMDS Data2+"
        2 = 2, "TMDS Data2 Shield"
        3 = 3, "TMDS Data2-"
        4 = 4, "TMDS Data1+"
        5 = 5, "TMDS Data1 Shield"
        6 = 6, "TMDS Data1-"
        7 = 7, "TMDS Data0+"
        8 = 8, "TMDS Data0 Shield"
        9 = 9, "TMDS Data0-"
        10 = 10, "TMDS Clock+"
        11 = 11, "TMDS Clock Shield"
        12 = 12, "TMDS Clock-"
        13 = 13, "CEC"
        14 = 14, "Reserved"
        15 = 15, "SCL"
        16 = 16, "SDA"
        17 = 17, "DDC/CEC Ground"
        18 = 18, "+5V Power"
        19 = 19, "Hot Plug Detect"
    ]
}

// DisplayPort Connector
component VIDEO.DISPLAYPORT()
{
    name = "DisplayPort Connector"
    description = "DisplayPort connector"
    
    spec = [
        standard = "DisplayPort"
        version = _ // [1.2, 1.3, 1.4, 2.0]
        connector_type = _ // [standard, mini, usb-c]
    ]
    
    pins = [
        1 = 1, "Main Link Lane 0 (P)"
        2 = 2, "Main Link Lane 0 (N)"
        3 = 3, "Main Link Lane 1 (P)"
        4 = 4, "Main Link Lane 1 (N)"
        5 = 5, "Main Link Lane 2 (P)"
        6 = 6, "Main Link Lane 2 (N)"
        7 = 7, "Main Link Lane 3 (P)"
        8 = 8, "Main Link Lane 3 (N)"
        9 = 9, "Ground"
        10 = 10, "Ground"
        11 = 11, "Ground"
        12 = 12, "Ground"
        13 = 13, "Configuration Data Lane (P)"
        14 = 14, "Configuration Data Lane (N)"
        15 = 15, "Hot Plug Detect"
        16 = 16, "+3.3V Power"
        17 = 17, "Ground"
        18 = 18, "Reserved"
    ]
}

// VGA Connector (D-sub 15-pin)
component VIDEO.VGA()
{
    name = "VGA Connector"
    description = "VGA (D-sub 15-pin) connector"
    
    spec = [
        standard = "VGA"
        type = "D-sub"
        pin_count = 15
        gender = _ // [male, female]
    ]
    
    pins = [
        1 = 1, "Red Video"
        2 = 2, "Green Video"
        3 = 3, "Blue Video"
        4 = 4, "Reserved"
        5 = 5, "Ground"
        6 = 6, "Red Ground"
        7 = 7, "Green Ground"
        8 = 8, "Blue Ground"
        9 = 9, "Key (No Pin)"
        10 = 10, "Sync Ground"
        11 = 11, "Reserved"
        12 = 12, "SDA (I2C)"
        13 = 13, "Horizontal Sync"
        14 = 14, "Vertical Sync"
        15 = 15, "SCL (I2C)"
    ]
}

// DVI Connector
component VIDEO.DVI()
{
    name = "DVI Connector"
    description = "DVI connector"
    
    spec = [
        standard = "DVI"
        connector_type = _ // [DVI-D, DVI-I, DVI-A]
        link_type = _ // [single, dual]
    ]
    
    pins = [
        1 = 1, "TMDS Data2+"
        2 = 2, "TMDS Data2-"
        3 = 3, "TMDS Data1+"
        4 = 4, "TMDS Data1-"
        5 = 5, "TMDS Data0+"
        6 = 6, "TMDS Data0-"
        7 = 7, "TMDS Clock+"
        8 = 8, "TMDS Clock-"
        9 = 9, "Ground"
        10 = 10, "TMDS Data4+"
        11 = 11, "TMDS Data4-"
        12 = 12, "TMDS Data3+"
        13 = 13, "TMDS Data3-"
        14 = 14, "TMDS Clock+"
        15 = 15, "TMDS Clock-"
        16 = 16, "Ground"
        17 = 17, "Hot Plug Detect"
        18 = 18, "DDC Clock"
        19 = 19, "DDC Data"
        20 = 20, "+5V Power"
        21 = 21, "Ground"
    ]
}

// Usage Examples:
// 1. HDMI connector
// VIDEO.HDMI()

// 2. DisplayPort connector
// VIDEO.DISPLAYPORT()

// 3. VGA connector
// VIDEO.VGA()

// 4. DVI connector
// VIDEO.DVI()
