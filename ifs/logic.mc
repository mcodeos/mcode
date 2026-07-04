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

interface LOGIC.AND
{
    pins = [
        in A = INA, "Logic input A"
        in B = INB, "Logic input B"
        out AB = OUT, "Logic output"
    ]
}

interface LOGIC.OR
{
    pins = [
        in A = INA, "Logic input A"
        in B = INB, "Logic input B"
        out AB = OUT, "Logic output"
    ]
}

interface LOGIC.NOT
{
    pins = [
        in A = INA, "Logic input A"
        out _A = OUT, "Logic output"
    ]
}

interface LOGIC.NAND{
    pins = [
        in A = INA, "Logic input A"
        in B = INB, "Logic input B"
        out _AB = OUT, "Logic output"
    ]
}

interface LOGIC.NOR {
    pins = [
        in A = INA, "Logic input A"
        in B = INB, "Logic input B"
        out _AB = OUT, "Logic output"
    ]
}

interface LOGIC.XOR {
    pins = [
        in A = INA, "Logic input A"
        in B = INB, "Logic input B"
        out AB = OUT, "Logic output"
    ]
}

interface LOGIC.XNOR {
    pins = [
        in A = INA, "Logic input A"
        in B = INB, "Logic input B"
        out AB = OUT, "Logic output"
    ]
}
