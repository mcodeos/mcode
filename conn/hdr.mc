# Copyright 2026 MCode Alliance
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

// Single-row Header
component HDR_SINGLE(cols::INT)
{
    name = "Single-row Header"
    description = "Standard single-row header with " + cols + " pins"
    
    spec = [
        cols = cols
        pitch = _ // [100mil, 50mil, 2.54mm, 1.27mm]
    ]
    
    // Standard pin numbering: 1 to cols
    pins = [
        1:cols = 1:cols
    ]
    schpkg = "./svg/header_single.sym"
}

// Multi-row Header
component HDR_MULTI(rows::INT, cols::INT)
{
    name = "Multi-row Header"
    description = "Standard multi-row header with " + rows + " rows, " + cols + " columns"
    
    spec = [
        rows = rows
        cols = cols
        pitch = _ // 100mil, 50mil, 2.54mm, 1.27mm //q
    ]
    
    // Pin numbering: R1C1, R1C2...R2C1, R2C2...
    //pins = [
    //..    1 : rows*cols = R[1:rows]C[1:cols]  // pins are rows * cols, ie, R1C1, R1C2...R2C1,R2C2...
    //]
    schpkg = "./svg/header_multi.sym"
}

// Common Standard Headers
// Single-row Headers (1x1 to 1x20)

// 1x1 Header
component HDR_1x1()
{
    name = "1x1 Header"
    description = "Standard 1x1 header (1 pin)"
    
    pins = [
        1:1 = 1:1
    ]
    schpkg = "./svg/header_1x1.sym"
}

// 1x2 Header
component HDR_1x2()
{
    name = "1x2 Header"
    description = "Standard 1x2 header (2 pins)"
    
    pins = [
        1:2 = 1:2
    ]
    schpkg = "./svg/header_1x2.sym"
}

// 1x3 Header
component HDR_1x3()
{
    name = "1x3 Header"
    description = "Standard 1x3 header (3 pins)"
    
    pins = [
        1:3 = 1:3
    ]
    schpkg = "./svg/header_1x3.sym"
}

// 1x4 Header
component HDR_1x4()
{
    name = "1x4 Header"
    description = "Standard 1x4 header (4 pins)"
    
    pins = [
        1:4 = 1:4
    ]
    schpkg = "./svg/header_1x4.sym"
}

// 1x5 Header
component HDR_1x5()
{
    name = "1x5 Header"
    description = "Standard 1x5 header (5 pins)"
    
    pins = [
        1:5 = 1:5
    ]
    schpkg = "./svg/header_1x5.sym"
}

// 1x6 Header
component HDR_1x6()
{
    name = "1x6 Header"
    description = "Standard 1x6 header (6 pins)"
    
    pins = [
        1:6 = 1:6
    ]
    schpkg = "./svg/header_1x6.sym"
}

// 1x7 Header
component HDR_1x7()
{
    name = "1x7 Header"
    description = "Standard 1x7 header (7 pins)"
    
    pins = [
        1:7 = 1:7
    ]
    schpkg = "./svg/header_1x7.sym"
}

// 1x8 Header
component HDR_1x8()
{
    name = "1x8 Header"
    description = "Standard 1x8 header (8 pins)"
    
    pins = [
        1:8 = 1:8
    ]
    schpkg = "./svg/header_1x8.sym"
}

// 1x9 Header
component HDR_1x9()
{
    name = "1x9 Header"
    description = "Standard 1x9 header (9 pins)"
    
    pins = [
        1:9 = 1:9
    ]
    schpkg = "./svg/header_1x9.sym"
}

// 1x10 Header
component HDR_1x10()
{
    name = "1x10 Header"
    description = "Standard 1x10 header (10 pins)"
    
    pins = [
        1:10 = 1:10
    ]
    schpkg = "./svg/header_1x10.sym"
}

// 1x12 Header
component HDR_1x12()
{
    name = "1x12 Header"
    description = "Standard 1x12 header (12 pins)"
    
    pins = [
        1:12 = 1:12
    ]
    schpkg = "./svg/header_1x12.sym"
}

// 1x14 Header
component HDR_1x14()
{
    name = "1x14 Header"
    description = "Standard 1x14 header (14 pins)"
    
    pins = [
        1:14 = 1:14
    ]
    schpkg = "./svg/header_1x14.sym"
}

// 1x16 Header
component HDR_1x16()
{
    name = "1x16 Header"
    description = "Standard 1x16 header (16 pins)"
    
    pins = [
        1:16 = 1:16
    ]
    schpkg = "./svg/header_1x16.sym"
}

// 1x20 Header
component HDR_1x20()
{
    name = "1x20 Header"
    description = "Standard 1x20 header (20 pins)"
    
    pins = [
        1:20 = 1:20
    ]
    schpkg = "./svg/header_1x20.sym"
}

// Dual-row Headers (2x2 to 2x10)

// 2x2 Header
component HDR_2x2()
{
    name = "2x2 Header"
    description = "Standard 2x2 header (4 pins)"
    
    pins = [
        1:4 = R[1:2]C[1:2]
    ]
    schpkg = "./svg/header_2x2.sym"
}

// 2x3 Header
component HDR_2x3()
{
    name = "2x3 Header"
    description = "Standard 2x3 header (6 pins)"
    
    pins = [
        1:6 = R[1:2]C[1:3]
    ]
    schpkg = "./svg/header_2x3.sym"
}

// 2x4 Header
component HDR_2x4()
{
    name = "2x4 Header"
    description = "Standard 2x4 header (8 pins)"
    
    pins = [
        1:8 = R[1:2]C[1:4]
    ]
    schpkg = "./svg/header_2x4.sym"
}

// 2x5 Header
component HDR_2x5()
{
    name = "2x5 Header"
    description = "Standard 2x5 header (10 pins)"
    
    pins = [
        1:10 = R[1:2]C[1:5]
    ]
    schpkg = "./svg/header_2x5.sym"
}

// 2x6 Header
component HDR_2x6()
{
    name = "2x6 Header"
    description = "Standard 2x6 header (12 pins)"
    
    pins = [
        1:12 = R[1:2]C[1:6]
    ]
    schpkg = "./svg/header_2x6.sym"
}

// 2x7 Header
component HDR_2x7()
{
    name = "2x7 Header"
    description = "Standard 2x7 header (14 pins)"
    
    pins = [
        1:14 = R[1:2]C[1:7]
    ]
    schpkg = "./svg/header_2x7.sym"
}

// 2x8 Header
component HDR_2x8()
{
    name = "2x8 Header"
    description = "Standard 2x8 header (16 pins)"
    
    pins = [
        1:16 = R[1:2]C[1:8]
    ]
    schpkg = "./svg/header_2x8.sym"
}

// 2x9 Header
component HDR_2x9()
{
    name = "2x9 Header"
    description = "Standard 2x9 header (18 pins)"
    
    pins = [
        1:18 = R[1:2]C[1:9]
    ]
    schpkg = "./svg/header_2x9.sym"
}

// 2x10 Header
component HDR_2x10()
{
    name = "2x10 Header"
    description = "Standard 2x10 header (20 pins)"
    
    pins = [
        1:20 = R[1:2]C[1:10]
    ]
    schpkg = "./svg/header_2x10.sym"
    
}
