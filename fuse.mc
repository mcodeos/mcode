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

# Fuse components
component FUSE(irated::UV.AMP, vrated::UV.VOLT)
{
    name = "Fuse"
    spec = [
        rating = irated // [0.1A, 0.5A, 1A, 2A, 5A, 10A, 20A]
        voltage = vrated // [5V, 12V, 24V, 120V, 240V]
        type = _ // [fast, slow, medium]
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}
component FUSE.SMD(irated::UV.AMP, vrated::UV.VOLT)
{
    name = "Surface Mount Fuse"
    spec = [
        rating = irated // [0.1A, 0.5A, 1A, 2A, 5A]
        voltage = vrated // [5V, 12V, 24V, 120V]
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}
component FUSE.CERAMIC(irated::UV.AMP, vrated::UV.VOLT, ibreak::UV.AMP)
{
    name = "Ceramic Fuse"
    spec = [
        rating = irated
        voltage = vrated
        breaking_capacity = ibreak
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}
component FUSE.GLASS(irated::UV.AMP, vrated::UV.VOLT)
{
    name = "Glass Fuse"
    spec = [
        rating = irated // [0.5A, 1A, 2A, 5A, 10A]
        voltage = vrated // [12V, 24V, 120V, 240V]
        speed = _ // [fast, slow, medium]
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}
component FUSE.PTC(irated::UV.AMP, vrated::UV.VOLT, itrip::UV.AMP)
{
    name = "PTC Fuse"
    spec = [
        rating = irated
        voltage = vrated
        trip_current = itrip
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}