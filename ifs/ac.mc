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
// Reserved family names (U176 law: land when a real consumer appears):
// AC.SPLIT (L1, L2, N) stays reserved. AC.3P landed early by ruling (user
// 2026-09-23: build the reserved family now rather than let the slot go
// stale) — three phases and a neutral, the four-wire Y face. The delta
// three-wire shape (no neutral, phase-to-phase return) is NOT landed: its
// return modeling is an open design question (ac-axis-interface-design.md
// §3.3/§8-2), so no contract declares it yet.

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

interface AC.3P(volt::UV.VOLT, freq::UV.HZ) // Three-phase AC mains interface (4-wire Y)
{
    topology = "point to point"
    mode = ["unidirectional"]
    voltage = volt
    frequency = freq

    // Core Rule: three live phase conductors over one shared neutral return,
    // the four-wire Y face. Phase order is the member order (L1, L2, L3);
    // the neutral is nominally at earth potential but is a current-carrying
    // member; PE is not — an earthed three-phase face binds AC.3P and carries
    // PE as its own pin (@role(protective)), same law as AC.1P (see header).
    pins = [
        1 = L1, "Phase 1 (live conductor)"
        2 = L2, "Phase 2 (live conductor)"
        3 = L3, "Phase 3 (live conductor)"
        4 = N, "Neutral (return conductor)"
    ]
}
