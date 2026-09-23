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
#
# Logic gate interfaces (U206): one interface = one gate's member topology.
# Member names follow the 74-family data-book gate names (A/B/C/Y); the
# default logical name equals the member name, so plain adoptions need no
# rename braces. Inverting outputs carry the `_` prefix on the member
# (`_AB`, `_A`) while the logical name stays `Y`. Electrical properties
# (drive, hysteresis, voltage window) are device-intrinsic and live on the
# component side, never here. VCC/GND are not gate members (A3); package
# power rows adopt ::DC directly.

interface LOGIC.AND
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out AB = Y @class(digital), "Logic output"
    ]
}

interface LOGIC.OR
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out AB = Y @class(digital), "Logic output"
    ]
}

interface LOGIC.NOT
{
    pins = [
        in A = A @class(digital), "Logic input A"
        out _A = Y @class(digital), "Logic output (inverting)"
    ]
}

interface LOGIC.NAND
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out _AB = Y @class(digital), "Logic output (inverting)"
    ]
}

// Fan-in variants: lane count differs, so each is its own dotted family
// point (S3 R-CV3), not a parameter. Representatives: .3 = 74HC10,
// .4 = 74HC20, .8 = 74HC30.
interface LOGIC.NAND.3
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        in C = C @class(digital), "Logic input C"
        out _AB = Y @class(digital), "Logic output (inverting)"
    ]
}

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

interface LOGIC.NOR
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out _AB = Y @class(digital), "Logic output (inverting)"
    ]
}

interface LOGIC.XOR
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out AB = Y @class(digital), "Logic output"
    ]
}

interface LOGIC.XNOR
{
    pins = [
        in A = A @class(digital), "Logic input A"
        in B = B @class(digital), "Logic input B"
        out _AB = Y @class(digital), "Logic output (inverting)"
    ]
}
