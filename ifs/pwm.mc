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

// PWM (Pulse Width Modulation) Standard Definition
// Core Rule: Digital signal with adjustable duty cycle
// PWM Level Spec: High = VCC, Low = GND
// Device Definition: TRANSMITTER = PWM source (MCU timer output, driver IC),
//                    RECEIVER = PWM sink (motor driver input, LED, MOSFET gate)
// Applications: Motor speed control, LED dimming, servo position control
//
// A PWM channel is a single pin: one instance per channel.
//   PWM0::PWM(TRANSMITTER)      -> one PWM channel
//   PWM0[1:4]::PWM(TRANSMITTER) -> members PWM0.1 .. PWM0.4, one pin each
interface PWM(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [1MHz]
    voltage = [1.8V,3.3V,5V]

    // @drive(pp): a PWM output stage is push-pull by default, same library
    // default as GPIO. A device that drives the line open-drain states
    // `@drive(od)` on its own adoption row, which overrides this default.
    pins = [
        1 = _ @drive(pp)
    ]

    role TRANSMITTER {  // PWM source: MCU timer output, driver IC
        name = "PWM Transmitter"
        pins = [
            out 1 = _ @drive(pp)  // The source drives the channel
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // PWM sink: motor driver input, LED, MOSFET gate
        name = "PWM Receiver"
        pins = [
            in 1 = _ @drive(pp)   // The sink reads it
        ]
        peer = TRANSMITTER
    }
}

interface PWM.H6(role)
{
    topology = "point to point"
    mode = ["output"]
    maxdistance = 0.1m
    maxspeed = [1MHz]
    voltage = [1.8V,3.3V,5V]

    // Three-phase complementary PWM (interface inventory B6): the six gate
    // control lanes of one three-phase bridge, phase-major with the high side
    // first -- UH, UL, VH, VL, WH, WL. UH/UL drive the same half bridge
    // complementary, but they are two independent control signals (the
    // deadtime lives in the driver, not in the lane pair), so the lanes carry
    // no @pair tag -- unlike the CAN_H/CAN_L legs of one differential signal.
    // Shape witness: DRV8304H INHA/INLA/INHB/INLB/INHC/INLC six control
    // inputs (TI ZHCSI91B p.3 package drawing; real part mcpub motor/drv8304).

    // Role-less conductor view: 6 anonymous lanes, ordinal = wire identity
    // (conductor-view-design.md R-CV1)
    pins = [
        1 = _    // UH <-> INHA
        2 = _    // UL <-> INLA
        3 = _    // VH <-> INHB
        4 = _    // VL <-> INLB
        5 = _    // WH <-> INHC
        6 = _    // WL <-> INLC
    ]

    role TRANSMITTER {  // PWM source: MCU advanced timer with complementary outputs
        name = "Three-phase PWM Transmitter"
        pins = [
            out 1 = UH   // Phase U high-side control
            out 2 = UL   // Phase U low-side control
            out 3 = VH   // Phase V high-side control
            out 4 = VL   // Phase V low-side control
            out 5 = WH   // Phase W high-side control
            out 6 = WL   // Phase W low-side control
        ]
        peer = RECEIVER
    }

    role RECEIVER {  // PWM sink: three-phase gate driver
        name = "Three-phase PWM Receiver"
        pins = [
            in 1 = UH   // Phase U high-side control
            in 2 = UL   // Phase U low-side control
            in 3 = VH   // Phase V high-side control
            in 4 = VL   // Phase V low-side control
            in 5 = WH   // Phase W high-side control
            in 6 = WL   // Phase W low-side control
        ]
        peer = TRANSMITTER
    }
}
