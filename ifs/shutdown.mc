# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// SHUTDOWN - Shutdown Control Interface Standard Definition
// Core Rule: A shutdown line is a request from a controller to a target
//            whose power state the line governs. One controller drives N
//            targets: the CONTROLLER peer declaration is count-less
//            (`peer = TARGET`, unrestricted); the TARGET side carries the
//            exact-one bound (`peer = CONTROLLER(1)`).
//            The polarity of the request is a per-part fact carried by
//            the adopting pin, not by this face: a line asserted high
//            and a line asserted low ride the same face.
//            Identity comes from adoption only (no name inference): a
//            spelling alone binds nothing, and a line whose meaning is
//            output-enable or regulator-enable does not ride this face.
// Device Definition: CONTROLLER = shutdown request source (logic output,
//                    supervisor, RC delay, pushbutton driver),
//                    TARGET = the device whose power state the line
//                    governs (amplifier shutdown input, regulator enable
//                    input, driver sleep input).

interface SHUTDOWN(role)
{
    topology = "point to point"
    mode = ["input", "output"]

    // Electrical contract data rides the ELEC.SHUTDOWN recipe face; this
    // definition carries structure only.

    // ERC anchors on these roles: the exclusive-peer / role-peer /
    // connection-time trio reads the exact-one bound on the TARGET side.

    pins = [
        1 = SHUTDOWN | SHDN | SD | SLEEP | STANDBY @class(digital)   // Shutdown request line
    ]

    role CONTROLLER {  // drives the request line: logic output, supervisor, RC delay, button
        name = "SHUTDOWN Controller"
        pins = [
            out 1 = SHUTDOWN @class(digital)   // The controller asserts the shutdown request
        ]
        peer = TARGET
    }

    role TARGET {  // the governed device: amplifier shutdown input, regulator enable input
        name = "SHUTDOWN Target"
        pins = [
            io 1 = SHUTDOWN @class(digital)   // The target may also drive the line (a supervisor output, a latch)
        ]
        peer = CONTROLLER(1)
    }
}

// Example usage:
// Controller side (a logic output driving the request):
//     out 9 = SHUTDOWN{SHDN}::SHUTDOWN(CONTROLLER)
// Target side (the governed device input):
//     in 1 = SHUTDOWN{SHDN}::SHUTDOWN(TARGET)
