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
// Audio Connector Definitions
// ---------------------------------------------------------------------------------------------

// 3.5mm TRS Connector (Headphone Jack)
// configuration: Connector configuration (stereo, mono, headset)
component AUDIO.TRS_35MM(configuration::STRING = "stereo")
{
    name = "3.5mm TRS Connector"
    description = "3.5mm TRS audio connector, " + configuration + " configuration"
    
    spec = [
        type = "TRS"
        size = "3.5mm"
        configuration = configuration
    ]
    
    if configuration == "stereo" 
        pins = [
            1 = Tip, "Tip (Left)"
            2 = Ring, "Ring (Right)"
            3 = Sleeve, "Sleeve (Ground)"
        ] 
    else if configuration == "mono" 
        pins = [
            1 = Tip, "Tip (Signal)"
            2 = Sleeve, "Sleeve (Ground)"
        ] 
    else if configuration == "headset" 
        pins = [
            1 = Tip, "Tip (Left)"
            2 = Ring1, "Ring 1 (Right)"
            3 = Ring2, "Ring 2 (Microphone)"
            4 = Sleeve, "Sleeve (Ground)"
        ]
    else 
        pins = [
            1 = Tip, "Tip"
            2 = Ring, "Ring"
            3 = Sleeve, "Sleeve"
        ]
}

// 2.5mm TRS Connector
component AUDIO.TRS_25MM()
{
    name = "2.5mm TRS Connector"
    description = "2.5mm TRS audio connector"
    
    spec = [
        type = "TRS"
        size = "2.5mm"
        configuration = _ // [stereo, mono, headset]
    ]
    
    pins = [
        1 = Tip, "Tip"
        2 = Ring, "Ring"
        3 = Sleeve, "Sleeve"
    ]
}

// RCA Connector (Phono Connector)
component AUDIO.RCA()
{
    name = "RCA Connector"
    description = "RCA audio connector"
    
    spec = [
        type = "RCA"
    ]
    
    pins = [
        1 = Center, "Center Pin"
        2 = Shield, "Outer Shield"
    ]
}

// XLR Connector
// pin_count: Number of pins (3, 4, or 5)
component AUDIO.XLR(pin_count::INT = 3)
{
    name = "XLR Connector"
    description = "XLR audio connector, " + string(pin_count) + " pins"
    
    spec = [
        type = "XLR"
        pin_count = pin_count
        gender = _ // [male, female]
    ]
    
    if pin_count == 3
        pins = [
            1 = GND, "Ground"
            2 = Hot, "Hot"
            3 = Cold, "Cold"
        ]
    else if pin_count == 4
        pins = [
            1 = GND, "Ground"
            2 = Hot, "Hot"
            3 = Cold, "Cold"
            4 = Power, "Power"
        ]
    else if pin_count == 5
        pins = [
            1 = GND, "Ground"
            2 = Hot, "Hot"
            3 = Cold, "Cold"
            4 = Power\+, "Power+"
            5 = Power\-, "Power-"
        ]
    else
        pins = [
            1:pin_count = 1:pin_count
        ]
}

// Speakon Connector (Professional Audio)
component AUDIO.SPEAKON()
{
    name = "Speakon Connector"
    description = "Speakon professional audio connector"
    
    spec = [
        type = "Speakon"
        pin_count = _ // [4, 8]
        application = "Professional Audio"
    ]
    
    pins = [
        1 = 1, "Pin 1"
        2 = 2, "Pin 2"
        3 = 3, "Pin 3"
        4 = 4, "Pin 4"
    ]
}

// Banana Plug Connector (Speaker Terminals)
component AUDIO.BANANA_PLUG()
{
    name = "Banana Plug Connector"
    description = "Banana plug speaker connector"
    
    spec = [
        type = "Banana Plug"
        application = "Speaker Terminals"
    ]
    
    pins = [
        1 = Conductor, "Conductor"
    ]
}

// Usage Examples:// 1. 3.5mm stereo connector// AUDIO.TRS_35MM("stereo")

// 2. RCA red connector// AUDIO.RCA("red")

// 3. XLR 3-pin male connector// AUDIO.XLR(3, "male")

// 4. Speakon 4-pin connector// AUDIO.SPEAKON(4)