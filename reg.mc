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
component REG(vout::UV.VOLT, iout::UV.AMP, vin::UV.VOLT)
{
    name = "Regulator"
    spec = [
        output_voltage = vout
        output_current = iout
        input_voltage = vin
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component REG.LINEAR(vout::UV.VOLT, iout::UV.AMP, vin::UV.VOLT, vdrop::UV.VOLT)
{
    name = "Linear Regulator"
    spec = [
        output_voltage = vout
        output_current = iout
        input_voltage = vin
        dropout_voltage = vdrop
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component REG.SW(vout::UV.VOLT, iout::UV.AMP, vin::UV.VOLT, eff::UV.PERCENT)
{
    name = "Switching Regulator"
    spec = [
        output_voltage = vout
        output_current = iout
        input_voltage = vin
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
component REG.LDO(vout::UV.VOLT, iout::UV.AMP, vin::UV.VOLT, vdrop::UV.VOLT)
{
    name = "Low Dropout Regulator"
    spec = [
        output_voltage = vout
        output_current = iout
        input_voltage = vin
        dropout_voltage = vdrop
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component REG.REF(vout::UV.VOLT, iout::UV.AMP, acc::UV.PERCENT)
{
    name = "Voltage Reference"
    spec = [
        output_voltage = vout
        output_current = iout
        accuracy = acc
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
    ]
}
component REG.BUCK(vout::UV.VOLT, iout::UV.AMP, vin::UV.VOLT, fsw::UV.HZ)
{
    name = "Buck Regulator"
    spec = [
        output_voltage = vout
        output_current = iout
        input_voltage = vin
        switching_frequency = fsw
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
        4 = SW
        5 = FB
    ]
}
component REG.BOOST(vout::UV.VOLT, iout::UV.AMP, vin::UV.VOLT, fsw::UV.HZ)
{
    name = "Boost Regulator"
    spec = [
        output_voltage = vout
        output_current = iout
        input_voltage = vin
        switching_frequency = fsw
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
        4 = SW
        5 = FB
    ]
}
component REG.BUCK_BOOST(vout::UV.VOLT, iout::UV.AMP, vin::UV.VOLT, fsw::UV.HZ)
{
    name = "Buck-Boost Regulator"
    spec = [
        output_voltage = vout
        output_current = iout
        input_voltage = vin
        switching_frequency = fsw
    ]
    pins = [
        1 = INPUT
        2 = OUTPUT
        3 = GND
        4 = SW
        5 = FB
    ]
}