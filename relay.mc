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

# Relay components
component RELAY(i_cont::UV.AMP, v_coil::UV.VOLT)
{
    name = "Relay"
    spec = [
        contact_rating = i_cont
        coil_voltage = v_coil
    ]
    pins = [
        [1,2] = COIL{VCC,GND}::DC()
        3 = NO
        4 = COM
        5 = NC
    ]
}
component RELAY.EM(v_coil::UV.VOLT, i_cont::UV.AMP)
{
    name = "Electromagnetic Relay"
    spec = [
        coil_voltage = v_coil
        contact_rating = i_cont
    ]
    pins = [
        [1,2] = COIL{VCC,GND}::DC()
        3 = NO
        4 = COM
        5 = NC
    ]
}
component RELAY.SSR(v_ctrl::UV.VOLT, v_load::UV.VOLT, i_load::UV.AMP)
{
    name = "Solid State Relay"
    spec = [
        control_voltage = v_ctrl
        load_voltage = v_load
        load_current = i_load
    ]
    pins = [
        1 = CTRL.VCC
        2 = CTRL.GND
        3 = LOAD.VCC
        4 = LOAD.GND
    ]
}
component RELAY.REED(v_coil::UV.VOLT, i_cont::UV.AMP)
{
    name = "Reed Relay"
    spec = [
        coil_voltage = v_coil
        contact_rating = i_cont
    ]
    pins = [
        [1,2] = COIL{VCC,GND}::DC()
        3 = NO
        4 = COM
    ]
}
component RELAY.LATCH(v_coil::UV.VOLT, i_cont::UV.AMP)
{
    name = "Latching Relay"
    spec = [
        coil_voltage = v_coil
        contact_rating = i_cont
    ]
    pins = [
        1 = SET.VCC
        2 = SET.GND
        3 = RESET.VCC
        4 = RESET.GND
        5 = NO
        6 = COM
        7 = NC
    ]
}