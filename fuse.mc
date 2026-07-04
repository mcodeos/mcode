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
component FUSE(i_rated::UV.AMP, v::UV.VOLT)
{
    name = "Fuse"
    spec = [
        rating = i_rated // [0.1A, 0.5A, 1A, 2A, 5A, 10A, 20A]
        voltage = v // [5V, 12V, 24V, 120V, 240V]
        type = _ // [fast, slow, medium]
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}
component FUSE.SMD(i_rated::UV.AMP, v::UV.VOLT)
{
    name = "Surface Mount Fuse"
    spec = [
        rating = i_rated // [0.1A, 0.5A, 1A, 2A, 5A]
        voltage = v // [5V, 12V, 24V, 120V]
        package = _ // [0603, 0805, 1206, 1210]
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}
component FUSE.CERAMIC(i_rated::UV.AMP, v::UV.VOLT, i_break::UV.AMP)
{
    name = "Ceramic Fuse"
    spec = [
        rating = i_rated
        voltage = v
        breaking_capacity = i_break
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}
component FUSE.GLASS(i_rated::UV.AMP, v::UV.VOLT)
{
    name = "Glass Fuse"
    spec = [
        rating = i_rated // [0.5A, 1A, 2A, 5A, 10A]
        voltage = v // [12V, 24V, 120V, 240V]
        speed = _ // [fast, slow, medium]
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}
component FUSE.PTC(i_rated::UV.AMP, v::UV.VOLT, i_trip::UV.AMP)
{
    name = "PTC Fuse"
    spec = [
        rating = i_rated
        voltage = v
        trip_current = i_trip
    ]
    pins = [
        1 = 1
        2 = 2
    ]
}