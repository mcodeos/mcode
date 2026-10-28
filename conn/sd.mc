# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// SD.SOCKET - Full-size SD card socket with card-detect switch Component Definition
// Core Rule: Pad numbers and roles follow the standard SD card contact map;
// the six signal pads (CLK, CMD, DAT0-DAT3) adopt the SDIO face position for
// position, so a socket wired to an SDIO Host maps 1:1 through the adoption.
// microSD shares the same pad roles.

general component SD.SOCKET()
{
    name = "SD Card Socket"
    description = "Full-size SD card socket with card-detect switch"

    spec += [
        type = "SD"
        form_factor = _ // [full-size, microSD]
        eject = _ // [push-push, push-pull, hinge]
        card_detect = _ // [yes, no]
        write_protect = _ // [yes, no]
        mount = _ // [surface-mount]
    ]

    pins = [
        io [5,2,7,8,9,1] = SDIO{CLK, CMD, DAT0, DAT1, DAT2, DAT3}::SDIO(), "Signal face: pad 5 CLK / 2 CMD / 7 DAT0 / 8 DAT1 / 9 DAT2 / 1 DAT3 (DAT3 doubles as card select in SPI mode)"
        [4,3] = [VDD,VSS]::DC(), "Card supply / Ground return"   // card pads 4, 3
        6 = VSS, "Ground return"                       // card pad 6
        10 = CD1, "Card detect switch contact"         // switch pair, closed when card inserted
        11 = CD2, "Card detect switch contact"
    ]
}

// Usage Examples:
// SD.SOCKET() sd1
// sd1.CLK -> sdio_host.CLK
// sd1.CD1 -> mc_gpio.card_detect
