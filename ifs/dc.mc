# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// DC - DC Power Supply Interface Standard Definition
// Core Rule: Unidirectional direct-current power over a positive rail (VCC)
//            and ground (GND). Source/sink direction rides the adopting
//            terminal's direction word (psrc / psnk / psbi), not a
//            parameter of this face. Electrical contract data rides the
//            .ELEC recipe face; the iface itself is structure only.

interface DC // DC Power Supply Interface
{
    topology = "point to point"
    mode = ["unidirectional"]

    pins = [
        1 = VCC, "DC power"
        2 = GND, "DC power ground"
    ]

}
