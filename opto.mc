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

# Optocoupler components
component OPTO(i_in::UV.AMP, i_out::UV.AMP, v_iso::UV.VOLT)
{
    name = "Optocoupler"
    spec = [
        input_current = i_in
        output_current = i_out
        isolation_voltage = v_iso
    ]
    pins = [
        1 = INPUT\+
        2 = INPUT\-
        3 = OUTPUT\+
        4 = OUTPUT\-
    ]
}
component OPTO.TRANS(i_in::UV.AMP, i_out::UV.AMP, v_iso::UV.VOLT, ctr::UV.PERCENT)
{
    name = "Transistor Output Optocoupler"
    spec = [
        input_current = i_in
        output_current = i_out
        isolation_voltage = v_iso
        current_transfer_ratio = ctr
    ]
    pins = [
        1 = INPUT\+
        2 = INPUT\-
        3 = COLLECTOR
        4 = EMITTER
    ]
}
component OPTO.TRIAC(i_in::UV.AMP, v_out::UV.VOLT, v_iso::UV.VOLT, i_hold::UV.AMP)
{
    name = "Triac Output Optocoupler"
    spec = [
        input_current = i_in
        output_voltage = v_out
        isolation_voltage = v_iso
        holding_current = i_hold
    ]
    pins = [
        1 = INPUT\+
        2 = INPUT\-
        3 = MT1
        4 = MT2
    ]
}
component OPTO.PV(i_in::UV.AMP, v_out::UV.VOLT, v_iso::UV.VOLT)
{
    name = "Photovoltaic Optocoupler"
    spec = [
        input_current = i_in
        output_voltage = v_out
        isolation_voltage = v_iso
    ]
    pins = [
        1 = INPUT\+
        2 = INPUT\-
        3 = OUTPUT\+
        4 = OUTPUT\-
    ]
}
component OPTO.LOGIC(i_in::UV.AMP, v_out::UV.VOLT, v_iso::UV.VOLT, t_delay::UV.TIME)
{
    name = "Logic Output Optocoupler"
    spec = [
        input_current = i_in
        output_voltage = v_out
        isolation_voltage = v_iso
        propagation_delay = t_delay
    ]
    pins = [
        1 = INPUT\+
        2 = INPUT\-
        3 = OUTPUT
        4 = GND
    ]
}