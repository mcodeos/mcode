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
// Wire-to-Board Connector Definitions
// ---------------------------------------------------------------------------------------------

// Basic Wire-to-Board Connector
component WTB.BASIC(count::INT)
{
    name = "Wire-to-Board Connector"
    description = "Basic wire-to-board connector"
    
    spec = [
        pin_count = count // [2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16]
        pitch = _ // [1.0mm, 1.25mm, 1.5mm, 2.0mm, 2.54mm, 3.96mm] ？
        orientation = _ // [horizontal, vertical] ？
    ]
    
    pins = [
        1:count = 1:count 
    ]
}

// JST XH Series Connector (Commonly used in electronics)
component WTB.JST_XH(count::INT)
{
    name = "JST XH Connector"
    description = "JST XH series wire-to-board connector"
    
    spec = [
        series = "XH"
        pin_count = count // [2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16]
        pitch = 2.5mm
        manufacturer = "JST"
    ]
    
    pins = [
        1:count = 1:count
    ]
}

// Molex KK Series Connector
component WTB.MOLEX_KK(count::INT)
{
    name = "Molex KK Connector"
    description = "Molex KK series wire-to-board connector"
    
    spec = [
        series = "KK"
        pin_count = count // [2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16]
        pitch = 2.54mm
        manufacturer = "Molex"
    ]
    
    pins = [
        1:count = 1:count
    ]
}

// Dupont Connector (Breadboard Compatible)
component WTB.DUPONT(count::INT)
{
    name = "Dupont Connector"
    description = "Dupont wire-to-board connector"
    
    spec = [
        type = "Dupont"
        pin_count = count // [2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16]
        pitch = 2.54mm
    ]
    
    pins = [
        1:count = 1:count
    ]
}

// Usage Examples:
// 1. Basic wire-to-board connector
// WTB.BASIC()

// 2. JST XH connector
// WTB.JST_XH()

// 3. Molex KK connector
// WTB.MOLEX_KK()

// 4. Dupont connector
// WTB.DUPONT()