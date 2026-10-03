# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

//
// Logic gate interfaces: one interface = one gate's member topology.
// Member names follow the classic data-book gate names (A/B/C/Y); the
// default logical name equals the member name, so plain adoptions need no
// rename braces. Inverting outputs carry the `_` prefix on the member
// (`_AB`, `_A`) while the logical name stays `Y`. Electrical properties
// (drive, hysteresis, voltage window) are device-intrinsic and live on the
// component side, never here. VCC/GND are not gate members; package power
// rows adopt ::DC directly.

// LOGIC.AND - Logic AND Gate Standard Definition
// Core Rule: Two inputs, one output; the output is driven high only when
//            every input is high.

interface LOGIC.AND
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out AB = Y @class(digital), "Logic output"
    ]
}

// LOGIC.OR - Logic OR Gate Standard Definition
// Core Rule: Two inputs, one output; the output is driven high when at
//            least one input is high.

interface LOGIC.OR
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out AB = Y @class(digital), "Logic output"
    ]
}

// LOGIC.NOT - Logic Inverter (NOT Gate) Standard Definition
// Core Rule: One input, one inverting output; the output is the logical
//            inverse of the input.

interface LOGIC.NOT
{
    pins = [
        in A = A @class(digital), "Logic input A"
        out _A = Y @class(digital), "Logic output (inverting)"
    ]
}

// LOGIC.NAND - Logic NAND Gate Standard Definition
// Core Rule: Two inputs, one inverting output; the output is driven low
//            only when every input is high.

interface LOGIC.NAND
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out _AB = Y @class(digital), "Logic output (inverting)"
    ]
}

// LOGIC.NAND.3 - Logic NAND Gate (3-input) Standard Definition
// Core Rule: Three inputs, one inverting output; the output is driven low
//            only when every input is high.
// Note: lane count is the variant identity (a dotted family point), not a
//       parameter.

interface LOGIC.NAND.3
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        in C = C @class(digital), "Logic input C"
        out _AB = Y @class(digital), "Logic output (inverting)"
    ]
}

// LOGIC.NAND.4 - Logic NAND Gate (4-input) Standard Definition
// Core Rule: Four inputs, one inverting output; the output is driven low
//            only when every input is high.

interface LOGIC.NAND.4
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        in C = C @class(digital), "Logic input C"
        in D = D @class(digital), "Logic input D"
        out _AB = Y @class(digital), "Logic output (inverting)"
    ]
}

// LOGIC.NAND.8 - Logic NAND Gate (8-input) Standard Definition
// Core Rule: Eight inputs, one inverting output; the output is driven low
//            only when every input is high.

interface LOGIC.NAND.8
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        in C = C @class(digital), "Logic input C"
        in D = D @class(digital), "Logic input D"
        in E = E @class(digital), "Logic input E"
        in F = F @class(digital), "Logic input F"
        in G = G @class(digital), "Logic input G"
        in H = H @class(digital), "Logic input H"
        out _AB = Y @class(digital), "Logic output (inverting)"
    ]
}

// LOGIC.NOR - Logic NOR Gate Standard Definition
// Core Rule: Two inputs, one inverting output; the output is driven low
//            when at least one input is high.

interface LOGIC.NOR
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out _AB = Y @class(digital), "Logic output (inverting)"
    ]
}

// LOGIC.XOR - Logic Exclusive-OR Gate Standard Definition
// Core Rule: Two inputs, one output; the output is driven high when the
//            inputs differ.

interface LOGIC.XOR
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out AB = Y @class(digital), "Logic output"
    ]
}

// LOGIC.XNOR - Logic Exclusive-NOR Gate Standard Definition
// Core Rule: Two inputs, one inverting output; the output is driven high
//            when the inputs are equal.

interface LOGIC.XNOR
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out _AB = Y @class(digital), "Logic output (inverting)"
    ]
}
