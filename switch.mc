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
