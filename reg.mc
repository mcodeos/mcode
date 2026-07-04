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

# Regulator components
component REG(v_out::UV.VOLT, i_out::UV.AMP, v_in::UV.VOLT)
{
    name = "Regulator"
    spec = [
        output_voltage = v_out
        output_current = i_out
        input_voltage = v_in
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component REG.LINEAR(v_out::UV.VOLT, i_out::UV.AMP, v_in::UV.VOLT, v_drop::UV.VOLT)
{
    name = "Linear Regulator"
    spec = [
        output_voltage = v_out
        output_current = i_out
        input_voltage = v_in
        dropout_voltage = v_drop
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component REG.SW(v_out::UV.VOLT, i_out::UV.AMP, v_in::UV.VOLT, eff::UV.PERCENT)
{
    name = "Switching Regulator"
    spec = [
        output_voltage = v_out
        output_current = i_out
        input_voltage = v_in
        efficiency = eff
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
        4 = SW
        5 = FB
    ]
}
component REG.LDO(v_out::UV.VOLT, i_out::UV.AMP, v_in::UV.VOLT, v_drop::UV.VOLT)
{
    name = "Low Dropout Regulator"
    spec = [
        output_voltage = v_out
        output_current = i_out
        input_voltage = v_in
        dropout_voltage = v_drop
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component REG.REF(v_out::UV.VOLT, i_out::UV.AMP, acc::UV.PERCENT)
{
    name = "Voltage Reference"
    spec = [
        output_voltage = v_out
        output_current = i_out
        accuracy = acc
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component REG.BUCK(v_out::UV.VOLT, i_out::UV.AMP, v_in::UV.VOLT, f_sw::UV.HZ)
{
    name = "Buck Regulator"
    spec = [
        output_voltage = v_out
        output_current = i_out
        input_voltage = v_in
        switching_frequency = f_sw
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
        4 = SW
        5 = FB
    ]
}
component REG.BOOST(v_out::UV.VOLT, i_out::UV.AMP, v_in::UV.VOLT, f_sw::UV.HZ)
{
    name = "Boost Regulator"
    spec = [
        output_voltage = v_out
        output_current = i_out
        input_voltage = v_in
        switching_frequency = f_sw
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
        4 = SW
        5 = FB
    ]
}
component REG.BB(v_out::UV.VOLT, i_out::UV.AMP, v_in::UV.VOLT, f_sw::UV.HZ)
{
    name = "Buck-Boost Regulator"
    spec = [
        output_voltage = v_out
        output_current = i_out
        input_voltage = v_in
        switching_frequency = f_sw
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
        4 = SW
        5 = FB
    ]
}