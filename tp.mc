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

# Test Point — industry standard "TP" (TP1, TP2 ... on schematics/PCB)
#
# A test point is a single pin: one instance per net tap.
#   TP1::TP()   -> one test point
component TP()
{
    name = "Test Point"
    description = "Electrical test point for circuit debugging"

    pins = [
        1 = TP
    ]
}

# Usage Examples:
# TP() probe_3v3
# vcc_3v3 -> probe_3v3.TP
# TP() probe_gnd
