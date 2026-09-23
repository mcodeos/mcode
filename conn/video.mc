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
        1 = TMDS_D2\+ @pair(d2), "TMDS Data2+"
        2 = TMDS_D2_SH, "TMDS Data2 Shield"
        3 = TMDS_D2\- @pair(d2), "TMDS Data2-"
        4 = TMDS_D1\+ @pair(d1), "TMDS Data1+"
        5 = TMDS_D1_SH, "TMDS Data1 Shield"
        6 = TMDS_D1\- @pair(d1), "TMDS Data1-"
        7 = TMDS_D0\+ @pair(d0), "TMDS Data0+"
        8 = TMDS_D0_SH, "TMDS Data0 Shield"
        9 = TMDS_D0\- @pair(d0), "TMDS Data0-"
        10 = TMDS_CK\+ @pair(clk), "TMDS Clock+"
        11 = TMDS_CK_SH, "TMDS Clock Shield"
        12 = TMDS_CK\- @pair(clk), "TMDS Clock-"
        13 = CEC, "CEC"
        14 = RESERVED, "Reserved"
        15 = SCL, "SCL"
        16 = SDA, "SDA"
        [18,17] = [P5V,GND]::DC(5V), ["+5V Power","DDC/CEC Ground"]
        19 = HPD, "Hot Plug Detect"
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
        1 = LANE0_P @pair(lane0), "Main Link Lane 0 (P)"
        2 = LANE0_N @pair(lane0), "Main Link Lane 0 (N)"
        3 = LANE1_P @pair(lane1), "Main Link Lane 1 (P)"
        4 = LANE1_N @pair(lane1), "Main Link Lane 1 (N)"
        5 = LANE2_P @pair(lane2), "Main Link Lane 2 (P)"
        6 = LANE2_N @pair(lane2), "Main Link Lane 2 (N)"
        7 = LANE3_P @pair(lane3), "Main Link Lane 3 (P)"
        8 = LANE3_N @pair(lane3), "Main Link Lane 3 (N)"
        9 = GND, "Ground"
        10 = GND, "Ground"
        11 = GND, "Ground"
        12 = GND, "Ground"
        13 = AUX_P @pair(aux), "Configuration Data Lane (P)"
        14 = AUX_N @pair(aux), "Configuration Data Lane (N)"
        15 = HPD, "Hot Plug Detect"
        [16,17] = [P3V3,GND]::DC(3.3V), ["+3.3V Power","Ground"]
        18 = RESERVED, "Reserved"
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
        1 = RED, "Red Video"
        2 = GREEN, "Green Video"
        3 = BLUE, "Blue Video"
        4 = RESERVED, "Reserved"
        5 = GND, "Ground"
        6 = GND_R, "Red Ground"
        7 = GND_G, "Green Ground"
        8 = GND_B, "Blue Ground"
        9 = KEY, "Key (No Pin)"
        10 = GND_S, "Sync Ground"
        11 = RESERVED, "Reserved"
        12 = SDA, "SDA (I2C)"
        13 = HSYNC, "Horizontal Sync"
        14 = VSYNC, "Vertical Sync"
        15 = SCL, "SCL (I2C)"
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
        1 = TMDS_D2\+ @pair(d2), "TMDS Data2+"
        2 = TMDS_D2\- @pair(d2), "TMDS Data2-"
        3 = TMDS_D1\+ @pair(d1), "TMDS Data1+"
        4 = TMDS_D1\- @pair(d1), "TMDS Data1-"
        5 = TMDS_D0\+ @pair(d0), "TMDS Data0+"
        6 = TMDS_D0\- @pair(d0), "TMDS Data0-"
        7 = TMDS_CK\+ @pair(clk), "TMDS Clock+"
        8 = TMDS_CK\- @pair(clk), "TMDS Clock-"
        9 = GND, "Ground"
        10 = TMDS_D4\+ @pair(d4), "TMDS Data4+"
        11 = TMDS_D4\- @pair(d4), "TMDS Data4-"
        12 = TMDS_D3\+ @pair(d3), "TMDS Data3+"
        13 = TMDS_D3\- @pair(d3), "TMDS Data3-"
        14 = TMDS_CK\+, "TMDS Clock+"
        15 = TMDS_CK\-, "TMDS Clock-"
        16 = GND, "Ground"
        17 = HPD, "Hot Plug Detect"
        18 = DDC_SCL, "DDC Clock"
        19 = DDC_SDA, "DDC Data"
        [20,21] = [P5V,GND]::DC(5V), ["+5V Power","Ground"]
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
