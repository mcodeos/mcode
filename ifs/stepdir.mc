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

// STEPDIR (STEP/DIR stepper control) Standard Definition
// Core Rule: two-wire motion control -- STEP carries the step pulse train
// (one rising edge advances the indexer one step), DIR carries the static
// direction level. The two lanes are independent control signals (the DIR
// level is only sampled around STEP edges), so no @pair tag -- same ruling
// as PWM.H6.
// Device Definition: TRANSMITTER = pulse source (MCU timer/GPIO),
//                    RECEIVER = stepper driver indexer input.
// Shape witness: DRV8889 STEP/DIR (TI ZHCSJO5 p.3 package drawing; real
// part mcpub motor/drv8889).
interface STEPDIR(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [500kHz]
    voltage = [1.8V,3.3V,5V]

    // Role-less conductor view: 2 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _ @class(digital) // STEP
        2 = _ @class(digital) // DIR
    ]

    role TRANSMITTER {  // pulse source: MCU timer/GPIO
        name = "STEPDIR Transmitter"
        pins = [
            out 1 = STEP @class(digital), "Step pulse train (rising edge advances one step)"
            out 2 = DIR @class(digital), "Direction level"
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // stepper driver indexer input
        name = "STEPDIR Receiver"
        pins = [
            in 1 = STEP @class(digital), "Step pulse train (rising edge advances one step)"
            in 2 = DIR @class(digital), "Direction level"
        ]
        peer = TRANSMITTER
    }
}
