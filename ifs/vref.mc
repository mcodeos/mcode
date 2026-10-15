# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// VREF - Voltage Reference Interface Standard Definition
// Core Rule: A quiet analog reference pair — a stable voltage that a
//            converter's samples are measured against, not a power rail.
//            The whole reference row carries the quiet expectation
//            (@role(quiet)); the supply pair stays unmarked. Direction is
//            not a parameter: the source/sink rides on the adopting
//            terminal's direction word (psrc = the reference drives,
//            psnk = the converter samples).
// Device Definition: TRANSMITTER = the reference source (bandgap, shunt,
//                    or external precision reference),
//                    RECEIVER = the converter reference input (ADC/DAC).
// Note: members keep neutral local names (REF/RET, not VCC/GND); adopting
//       rows rename by position and never rely on these names.
// Note: the head formal is the instance-binding hook of the data face —
//       each adoption binds its own reference nominal (::VREF(2.5V) class;
//       per-part output windows live on the part spec faces, the retired
//       body rows were folklore: distance stated by zero documents). The
//       body keeps structure only; no interface-level key exists (no
//       all-sample answer face corpus-wide), so no .ELEC book.

interface VREF(volt::UV.VOLT) // Voltage Reference Interface
{
    topology = "point to point"
    mode = ["unidirectional"]

    pins = [
        1 = REF @role(quiet), "Voltage reference"
        2 = RET @role(quiet), "Reference return"
    ]

}
