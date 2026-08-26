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

# Relay components
component RELAY(icont::UV.AMP, vcoil::UV.VOLT)
{
    name = "Relay"
    spec = [
        contact_rating = icont
        coil_voltage = vcoil
    ]
    pins = [
        [1,2] = COIL{VCC,GND}::DC()
        3 = NO
        4 = COM
        5 = NC
    ]
}
component RELAY.EM(vcoil::UV.VOLT, icont::UV.AMP)
{
    name = "Electromagnetic Relay"
    spec = [
        coil_voltage = vcoil
        contact_rating = icont
    ]
    pins = [
        [1,2] = COIL{VCC,GND}::DC()
        3 = NO
        4 = COM
        5 = NC
    ]
}
component RELAY.SSR(vctrl::UV.VOLT, vload::UV.VOLT, iload::UV.AMP)
{
    name = "Solid State Relay"
    spec = [
        control_voltage = vctrl
        load_voltage = vload
        load_current = iload
    ]
    pins = [
        1 = CTRL.VCC
        2 = CTRL.GND
        3 = LOAD.VCC
        4 = LOAD.GND
    ]
}
component RELAY.REED(vcoil::UV.VOLT, icont::UV.AMP)
{
    name = "Reed Relay"
    spec = [
        coil_voltage = vcoil
        contact_rating = icont
    ]
    pins = [
        [1,2] = COIL{VCC,GND}::DC()
        3 = NO
        4 = COM
    ]
}
component RELAY.LATCH(vcoil::UV.VOLT, icont::UV.AMP)
{
    name = "Latching Relay"
    spec = [
        coil_voltage = vcoil
        contact_rating = icont
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