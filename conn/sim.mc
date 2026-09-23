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

// ---------------------------------------------------------------------------------------------
// SIM — SIM card socket (ISO 7816 contact map, sequential pad numbering)
// ---------------------------------------------------------------------------------------------
// Contact names carry the ISO 7816-2 C-codes; the C4/C8 contacts of the 8-pad
// map are absent on 6-pad sockets, so pads are numbered sequentially 1..6.

component SIM.SOCKET()
{
    name = "SIM Card Socket"
    description = "SIM card socket, 6-contact ISO 7816 pad map"

    spec = [
        type = "SIM"
        form_factor = _ // [ID-000 full SIM, mini-UICC / micro, nano 4FF]
        contacts = _ // [6, 8]
        eject = _ // [push-push, push, hinge]
        mount = _ // [surface-mount]
    ]

    pins = [
        [1,4] = [VCC,GND]::DC(), ["C1 supply","C5 ground"]
        2 = RST, "C2 reset"
        3 = CLK, "C3 clock"
        5 = VPP, "C6 programming voltage (rarely driven on modern SIMs)"
        6 = IO, "C7 data I/O"
    ]
}

# Usage Examples:
# SIM.SOCKET() sim1
# sim1.IO -> modem.SIM_IO
