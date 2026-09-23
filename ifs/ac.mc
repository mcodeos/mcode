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
// AC Mains Power Interface
// ---------------------------------------------------------------------------------------------
// Single-phase mains face, the alternating-current counterpart of ifs/dc.mc.
// Member set is fixed at L/N: the protective-earth conductor is NOT an
// interface member — PE only carries fault current and its authority lives
// in the protective/earth role machinery (@role(protective)/@role(earth),
// @clamp; exposed-protection-design.md). An earthed face therefore binds the
// same AC.1P interface as a 2-pole one and carries PE as its own pin
// (conn/iec.mc C14).
//
// Role-less by design (U217 probe 4, b3853): a role-bearing interface's
// constructor argument position IS the role position (E4185), so carrying
// the region nominal at the call site (::AC.1P(230V, 50Hz)) requires the
// DC form with no roles. Source/sink direction rides the adopting
// terminal's direction word (psrc/psnk), same law as DC.
//
// Region nominals belong to the consumer, not the inlet component: panel
// inlets are region-neutral (100-240V), so connector faces bind the empty
// form ::AC.1P() (the ::DC() socket precedent) and module power faces
// carry the nominal: psnk mains{L, N}::AC.1P(230V, 50Hz).
//
// Reserved family names (land when a real consumer appears, U176 law):
// AC.SPLIT (L1, L2, N), AC.3P (L1..L3, N).

interface AC.1P(volt::UV.VOLT, freq::UV.HZ) // Single-phase AC mains interface
{
    topology = "point to point"
    mode = ["unidirectional"]
    voltage = volt
    frequency = freq

    // Core Rule: alternating-current mains supply, one live conductor and
    // one neutral return. The neutral is nominally at earth potential but
    // is a current-carrying member; PE is not (see header).
    pins = [
        1 = L, "Line (live conductor)"
        2 = N, "Neutral (return conductor)"
    ]
}
