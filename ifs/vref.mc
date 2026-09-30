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

interface VREF(volt::UV.VOLT) // Voltage Reference Interface
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 0.3m
    voltage = volt

    // Voltage Reference Standard Definition
    // Core Rule: A quiet analog reference pair -- a stable voltage the
    //   converter's samples are measured against, not a power rail.
    // Face semantics (b4332): this face exists because the converters
    //   borrowed the DC power face for VREF/AGND rows (U216's VCC naming
    //   law and the hot/ret machinery then misdescribed a quiet reference
    //   as supply). Here the pair is what b4331 ruled it to be: the whole
    //   reference row carries the quiet expectation, the supply pair
    //   stays unmarked.
    // Direction is not a parameter (dc.mc same law, 2026-09-07): the
    //   source/sink rides on the adopting terminal's direction word
    //   (psrc = the reference drives / psnk = the converter samples).
    // Members keep neutral local names (REF/RET, not VCC/GND): the
    //   adopting rows rename by position and never rely on these.
    // Applications: ADC/DAC reference inputs, bandgap and shunt reference
    //   sources, external precision references (REFxx, LM4040).

    pins = [
        1 = REF @role(quiet), "Voltage reference", voltage:volt
        2 = RET @role(quiet), "Reference return", voltage:0.0V
    ]

}
