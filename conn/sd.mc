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
// SD — SD card socket (full-size pad map; microSD shares the same pad roles)
// ---------------------------------------------------------------------------------------------
// Pad numbers and roles follow the SD card contact map (SD Association).
// Signal pad names mirror the SDIO interface members (ifs/sdio.mc) so a socket
// wired to an SDIO Host maps 1:1 without an interface binding on the component
// face (the `::` binding face carries known debt, U183).

component SD.SOCKET()
{
    name = "SD Card Socket"
    description = "Full-size SD card socket with card-detect switch"

    spec = [
        type = "SD"
        form_factor = _ // [full-size, microSD]
        eject = _ // [push-push, push-pull, hinge]
        card_detect = _ // [yes, no]
        write_protect = _ // [yes, no]
        mount = _ // [surface-mount]
    ]

    pins = [
        1 = DAT3, "Data 3 / card select in SPI mode"   // card pad 1
        2 = CMD, "Command / response line"             // card pad 2
        [4,3] = [VDD,VSS]::DC(), ["Card supply","Ground return"]   // card pads 4, 3
        6 = VSS, "Ground return"                       // card pad 6
        5 = CLK, "Clock (host generated)"              // card pad 5
        7 = DAT0, "Data 0"                             // card pad 7
        8 = DAT1, "Data 1"                             // card pad 8
        9 = DAT2, "Data 2"                             // card pad 9
        10 = CD1, "Card detect switch contact"         // switch pair, closed when card inserted
        11 = CD2, "Card detect switch contact"
    ]
}

# Usage Examples:
# SD.SOCKET() sd1
# sd1.CLK -> sdio_host.CLK
# sd1.CD1 -> mc_gpio.card_detect
