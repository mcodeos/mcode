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
// Header (HDR) Component Definitions
// ---------------------------------------------------------------------------------------------
// Naming: the family separator is the dot, as everywhere else in the library
// (HDR.1X4, not HDR_1x4); face names are all-uppercase (the parametric row
// count is spelled 1X4). The generic faces carry the formals; the concrete
// faces below are fixed-size variants in the IEC.C8/C14 style.

// Single-row Header
component HDR.SINGLE(cols::INT)
{
    name = "Single-row Header"
    description = "Standard single-row header with " + cols + " pins"

    spec = [
        cols = cols
        pitch = _ // [2.54mm, 1.27mm]
    ]

    // Standard pin numbering: 1 to cols
    pins = [
        1:cols = 1:cols
    ]
}

// Multi-row Header
component HDR.MULTI(rows::INT, cols::INT)
{
    name = "Multi-row Header"
    description = "Standard multi-row header with " + rows + " rows, " + cols + " columns"

    spec = [
        rows = rows
        cols = cols
        pitch = _ // [2.54mm, 1.27mm]
    ]

    // Pin numbering: R1C1, R1C2...R2C1, R2C2...
    pins = [
        1 : rows*cols = R[1:rows]C[1:cols]  // pins are rows * cols, ie, R1C1, R1C2...R2C1,R2C2...
    ]
}

// Common Standard Headers
// Single-row Headers (1X1 to 1X20, complete series)

// 1x1 Header
component HDR.1X1()
{
    name = "1x1 Header"
    description = "Standard 1x1 header (1 pin)"

    spec = [
        cols = 1
        pitch = _
    ]

    pins = [
        1:1 = 1:1
    ]
}

// 1x2 Header
component HDR.1X2()
{
    name = "1x2 Header"
    description = "Standard 1x2 header (2 pins)"

    spec = [
        cols = 2
        pitch = _
    ]

    pins = [
        1:2 = 1:2
    ]
}

// 1x3 Header
component HDR.1X3()
{
    name = "1x3 Header"
    description = "Standard 1x3 header (3 pins)"

    spec = [
        cols = 3
        pitch = _
    ]

    pins = [
        1:3 = 1:3
    ]
}

// 1x4 Header
component HDR.1X4()
{
    name = "1x4 Header"
    description = "Standard 1x4 header (4 pins)"

    spec = [
        cols = 4
        pitch = _
    ]

    pins = [
        1:4 = 1:4
    ]
}

// 1x5 Header
component HDR.1X5()
{
    name = "1x5 Header"
    description = "Standard 1x5 header (5 pins)"

    spec = [
        cols = 5
        pitch = _
    ]

    pins = [
        1:5 = 1:5
    ]
}

// 1x6 Header
component HDR.1X6()
{
    name = "1x6 Header"
    description = "Standard 1x6 header (6 pins)"

    spec = [
        cols = 6
        pitch = _
    ]

    pins = [
        1:6 = 1:6
    ]
}

// 1x7 Header
component HDR.1X7()
{
    name = "1x7 Header"
    description = "Standard 1x7 header (7 pins)"

    spec = [
        cols = 7
        pitch = _
    ]

    pins = [
        1:7 = 1:7
    ]
}

// 1x8 Header
component HDR.1X8()
{
    name = "1x8 Header"
    description = "Standard 1x8 header (8 pins)"

    spec = [
        cols = 8
        pitch = _
    ]

    pins = [
        1:8 = 1:8
    ]
}

// 1x9 Header
component HDR.1X9()
{
    name = "1x9 Header"
    description = "Standard 1x9 header (9 pins)"

    spec = [
        cols = 9
        pitch = _
    ]

    pins = [
        1:9 = 1:9
    ]
}

// 1x10 Header
component HDR.1X10()
{
    name = "1x10 Header"
    description = "Standard 1x10 header (10 pins)"

    spec = [
        cols = 10
        pitch = _
    ]

    pins = [
        1:10 = 1:10
    ]
}

// 1x11 Header
component HDR.1X11()
{
    name = "1x11 Header"
    description = "Standard 1x11 header (11 pins)"

    spec = [
        cols = 11
        pitch = _
    ]

    pins = [
        1:11 = 1:11
    ]
}

// 1x12 Header
component HDR.1X12()
{
    name = "1x12 Header"
    description = "Standard 1x12 header (12 pins)"

    spec = [
        cols = 12
        pitch = _
    ]

    pins = [
        1:12 = 1:12
    ]
}

// 1x13 Header
component HDR.1X13()
{
    name = "1x13 Header"
    description = "Standard 1x13 header (13 pins)"

    spec = [
        cols = 13
        pitch = _
    ]

    pins = [
        1:13 = 1:13
    ]
}

// 1x14 Header
component HDR.1X14()
{
    name = "1x14 Header"
    description = "Standard 1x14 header (14 pins)"

    spec = [
        cols = 14
        pitch = _
    ]

    pins = [
        1:14 = 1:14
    ]
}

// 1x15 Header
component HDR.1X15()
{
    name = "1x15 Header"
    description = "Standard 1x15 header (15 pins)"

    spec = [
        cols = 15
        pitch = _
    ]

    pins = [
        1:15 = 1:15
    ]
}

// 1x16 Header
component HDR.1X16()
{
    name = "1x16 Header"
    description = "Standard 1x16 header (16 pins)"

    spec = [
        cols = 16
        pitch = _
    ]

    pins = [
        1:16 = 1:16
    ]
}

// 1x17 Header
component HDR.1X17()
{
    name = "1x17 Header"
    description = "Standard 1x17 header (17 pins)"

    spec = [
        cols = 17
        pitch = _
    ]

    pins = [
        1:17 = 1:17
    ]
}

// 1x18 Header
component HDR.1X18()
{
    name = "1x18 Header"
    description = "Standard 1x18 header (18 pins)"

    spec = [
        cols = 18
        pitch = _
    ]

    pins = [
        1:18 = 1:18
    ]
}

// 1x19 Header
component HDR.1X19()
{
    name = "1x19 Header"
    description = "Standard 1x19 header (19 pins)"

    spec = [
        cols = 19
        pitch = _
    ]

    pins = [
        1:19 = 1:19
    ]
}

// 1x20 Header
component HDR.1X20()
{
    name = "1x20 Header"
    description = "Standard 1x20 header (20 pins)"

    spec = [
        cols = 20
        pitch = _
    ]

    pins = [
        1:20 = 1:20
    ]
}

// Dual-row Headers (2X2 to 2X10, complete series)

// 2x2 Header
component HDR.2X2()
{
    name = "2x2 Header"
    description = "Standard 2x2 header (4 pins)"

    spec = [
        rows = 2
        cols = 2
        pitch = _
    ]

    pins = [
        1:4 = R[1:2]C[1:2]
    ]
}

// 2x3 Header
component HDR.2X3()
{
    name = "2x3 Header"
    description = "Standard 2x3 header (6 pins)"

    spec = [
        rows = 2
        cols = 3
        pitch = _
    ]

    pins = [
        1:6 = R[1:2]C[1:3]
    ]
}

// 2x4 Header
component HDR.2X4()
{
    name = "2x4 Header"
    description = "Standard 2x4 header (8 pins)"

    spec = [
        rows = 2
        cols = 4
        pitch = _
    ]

    pins = [
        1:8 = R[1:2]C[1:4]
    ]
}

// 2x5 Header
component HDR.2X5()
{
    name = "2x5 Header"
    description = "Standard 2x5 header (10 pins)"

    spec = [
        rows = 2
        cols = 5
        pitch = _
    ]

    pins = [
        1:10 = R[1:2]C[1:5]
    ]
}

// 2x6 Header
component HDR.2X6()
{
    name = "2x6 Header"
    description = "Standard 2x6 header (12 pins)"

    spec = [
        rows = 2
        cols = 6
        pitch = _
    ]

    pins = [
        1:12 = R[1:2]C[1:6]
    ]
}

// 2x7 Header
component HDR.2X7()
{
    name = "2x7 Header"
    description = "Standard 2x7 header (14 pins)"

    spec = [
        rows = 2
        cols = 7
        pitch = _
    ]

    pins = [
        1:14 = R[1:2]C[1:7]
    ]
}

// 2x8 Header
component HDR.2X8()
{
    name = "2x8 Header"
    description = "Standard 2x8 header (16 pins)"

    spec = [
        rows = 2
        cols = 8
        pitch = _
    ]

    pins = [
        1:16 = R[1:2]C[1:8]
    ]
}

// 2x9 Header
component HDR.2X9()
{
    name = "2x9 Header"
    description = "Standard 2x9 header (18 pins)"

    spec = [
        rows = 2
        cols = 9
        pitch = _
    ]

    pins = [
        1:18 = R[1:2]C[1:9]
    ]
}

// 2x10 Header
component HDR.2X10()
{
    name = "2x10 Header"
    description = "Standard 2x10 header (20 pins)"

    spec = [
        rows = 2
        cols = 10
        pitch = _
    ]

    pins = [
        1:20 = R[1:2]C[1:10]
    ]
}

// Usage Examples:
// 1. Single-row 1x8 header
// HDR.SINGLE(8)
//
// 2. 2x10 box header
// HDR.MULTI(2, 10)
//
// 3. Fixed 1x4 header
// HDR.1X4()
