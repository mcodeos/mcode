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

// S/PDIF (Sony/Philips Digital Interface) Standard Definition
// Core Rule: single-wire consumer digital audio link, biphase-mark coded
// Physical media: 75 Ohm coax (with ground through the DC/power interface) or
// optical (TOSLINK; the optical module sits on the device face, this interface
// stays electrical)
// Applications: DAC links, TV / amplifier digital audio, S/PDIF passthrough

interface SPDIF(role)
{
    topology = "point to point"
    mode = ["unidirectional"]
    maxdistance = 10m  // coax; optical longer
    maxspeed = [12.3Mbps]  // 192 kHz * 64 bit frame worst case
    voltage = [3.3V, 5V]  // logic-side levels; coax swing ~1Vpp into 75 Ohm

    pins = [
        1 = SIG, "Serial digital audio signal"
    ]

    role Transmitter {
        name = "S/PDIF Transmitter"
        peer = Receiver
    }
    role Receiver {
        name = "S/PDIF Receiver"
        peer = Transmitter
    }
}
