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

# Optocoupler components
component OPTO(iin::UV.AMP, iout::UV.AMP, viso::UV.VOLT)
{
    name = "Optocoupler"
    spec = [
        input_current = iin
        output_current = iout
        isolation_voltage = viso
    ]
    pins = [
        1 = INPUT\+
        2 = INPUT\-
        3 = OUTPUT\+
        4 = OUTPUT\-
    ]
}
component OPTO.TRANS(iin::UV.AMP, iout::UV.AMP, viso::UV.VOLT, ctr::UV.PERCENT)
{
    name = "Transistor Output Optocoupler"
    spec = [
        input_current = iin
        output_current = iout
        isolation_voltage = viso
        current_transfer_ratio = ctr
    ]
    pins = [
        1 = INPUT\+
        2 = INPUT\-
        3 = COLLECTOR
        4 = EMITTER
    ]
}
component OPTO.TRIAC(iin::UV.AMP, vout::UV.VOLT, viso::UV.VOLT, ihold::UV.AMP)
{
    name = "Triac Output Optocoupler"
    spec = [
        input_current = iin
        output_voltage = vout
        isolation_voltage = viso
        holding_current = ihold
    ]
    pins = [
        1 = INPUT\+
        2 = INPUT\-
        3 = MT1
        4 = MT2
    ]
}
component OPTO.PV(iin::UV.AMP, vout::UV.VOLT, viso::UV.VOLT)
{
    name = "Photovoltaic Optocoupler"
    spec = [
        input_current = iin
        output_voltage = vout
        isolation_voltage = viso
    ]
    pins = [
        1 = INPUT\+
        2 = INPUT\-
        3 = OUTPUT\+
        4 = OUTPUT\-
    ]
}
component OPTO.LOGIC(iin::UV.AMP, vout::UV.VOLT, viso::UV.VOLT, tdelay::UV.TIME)
{
    name = "Logic Output Optocoupler"
    spec = [
        input_current = iin
        output_voltage = vout
        isolation_voltage = viso
        propagation_delay = tdelay
    ]
    pins = [
        1 = INPUT\+
        2 = INPUT\-
        3 = OUTPUT
        4 = GND
    ]
}