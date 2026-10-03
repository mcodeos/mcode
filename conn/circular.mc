# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// CIRC.BASIC - Generic circular connector Component Definition

component CIRC.BASIC(pin_count::INT)
{
    name = "Circular Connector"
    description = "Basic circular connector with " + pin_count + " pins"

    spec = [
        pin_count = pin_count
        diameter = _ // [8mm, 10mm, 12mm, 16mm, 20mm]
        thread = _ // [M8, M10, M12, M16, 1/4-20, 3/8-16]
    ]

    pins = [
        1:pin_count = 1:pin_count
    ]
}

// CIRC.MIL_SPEC - Military-specification circular connector Component Definition

component CIRC.MIL_SPEC(pin_count::INT)
{
    name = "MIL-SPEC Circular Connector"
    description = "MIL-SPEC circular connector, " + pin_count + " pins"
    
    spec = [
        series = _ // [MS3102, MS3106, MS3108, MS3110]
        shell_size = _ // [8, 10, 12, 14, 16]
        pin_count = pin_count
        standard = "MIL-SPEC"
    ]
    
    pins = [
        1:pin_count = 1:pin_count
    ]
}

// CIRC.BNC - RF coaxial connector (bayonet coupling) Component Definition
// Core Rule: Two-contact coaxial face - center conductor carries the RF signal,
// outer ground shield is the return and exposed electrode.

component CIRC.BNC(impedance::STRING)
{
    name = "BNC Connector"
    description = "BNC RF coaxial connector, " + impedance + " impedance"
    
    spec = [
        type = "BNC"
        impedance = impedance
        application = "RF, Video"
    ]
    
    pins = [
        1 = Center, "Center Conductor"
        2 = GND @exposed(esd_contact), "Ground Shield"
    ]
}

// CIRC.SMA - RF coaxial connector (threaded coupling) Component Definition
// Core Rule: Two-contact coaxial face - center conductor carries the RF signal,
// outer ground shield is the return and exposed electrode.

component CIRC.SMA(impedance::STRING)
{
    name = "SMA Connector"
    description = "SMA RF coaxial connector, " + impedance + " impedance"
    
    spec = [
        type = "SMA"
        impedance = impedance
        application = "RF, Microwave"
    ]
    
    pins = [
        1 = Center, "Center Conductor"
        2 = GND @exposed(esd_contact), "Ground Shield"
    ]
}

// CIRC.UFL - Micro RF coaxial receptacle for board-level antenna exit Component Definition
// Core Rule: 50-ohm two-contact coaxial face - center conductor (RF) plus
// ground shell; mates with the matching micro RF plug.

component CIRC.UFL()
{
    name = "U.FL RF Coaxial Connector"
    description = "U.FL micro RF coaxial receptacle"

    spec = [
        type = "U.FL"
        impedance = "50Ω"
        application = "Board-level RF exit: WiFi / BT / cellular module antenna port"
        mate = _ // [U.FL plug, matching micro RF plug]
    ]

    pins = [
        1 = RF, "Center conductor (RF signal)"
        2 = GND @exposed(esd_contact), "Ground shell"
    ]
}

// CIRC.MHF4 - Smaller-profile micro RF coaxial receptacle for board-level antenna exit Component Definition
// Core Rule: 50-ohm two-contact coaxial face - center conductor (RF) plus
// ground shell; mates with the matching micro RF plug.

component CIRC.MHF4()
{
    name = "MHF4 RF Coaxial Connector"
    description = "MHF4 micro RF coaxial receptacle"

    spec = [
        type = "MHF4"
        impedance = "50Ω"
        application = "Board-level RF exit: WiFi / BT / GNSS module antenna port"
        mate = _ // [MHF4 plug]
    ]

    pins = [
        1 = RF, "Center conductor (RF signal)"
        2 = GND @exposed(esd_contact), "Ground shell"
    ]
}

// Usage Examples:
// 1. Basic circular connector
// CIRC.BASIC(5)

// 2. MIL-SPEC connector
// CIRC.MIL_SPEC(10)

// 3. DIN 41612 connector

// 4. BNC connector
// CIRC.BNC("50Ω")

// 5. SMA connector
// CIRC.SMA("50Ω")

// 6. U.FL receptacle
// CIRC.UFL()

// 7. MHF4 receptacle
// CIRC.MHF4()
