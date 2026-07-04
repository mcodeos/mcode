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

enum PKG
{
    //片式电容
    C01005,
    C0201,
    C0402,
    C0603,
    C0805,
    C1206,
    C1210,
    C1808,
    C1812,
    C2010,
    C2512,
    C3216,
    C3225,
    C4532,
    C5040,
    
    //轴向电解电容
    DIP_CAP_Axial_3x5mm,
    DIP_CAP_Axial_5x11_5mm,
    DIP_CAP_Axial_6_3x12_5mm,
    DIP_CAP_Axial_8x16mm,
    DIP_CAP_Axial_10x16mm,
    DIP_CAP_Axial_10x20mm,
    DIP_CAP_Axial_12_5x25mm,
    
    //径向电解电容
    DIP_CAP_Radial_5x5mm,
    DIP_CAP_Radial_5x7mm,
    DIP_CAP_Radial_6_3x5mm,
    DIP_CAP_Radial_6_3x7_5mm,
    DIP_CAP_Radial_6_3x11mm,
    DIP_CAP_Radial_8x10mm,
    DIP_CAP_Radial_8x12mm,
    DIP_CAP_Radial_8x16mm,
    DIP_CAP_Radial_10x12mm,
    DIP_CAP_Radial_10x16mm,
    DIP_CAP_Radial_10x20mm,
    DIP_CAP_Radial_12_5x20mm,
    DIP_CAP_Radial_12_5x25mm,
    DIP_CAP_Radial_16x25mm,
    
    //钽电容
    TANTALUM_A,
    TANTALUM_B,
    TANTALUM_C,
    TANTALUM_D,
    TANTALUM_E,
    TANTALUM_V,
    TANTALUM_VJ,
    TANTALUM_VK,
    
    //其他特殊电容
    DIP_CAP_MKT,
    DIP_CAP_CBB,
    DIP_CAP_X2,
    DIP_CAP_Y1,
    DIP_CAP_Y2,
    
    //片式电阻
    R01005,
    R0201,
    R0402,
    R0603,
    R0805,
    R1206,
    R1210,
    R1808,
    R1812,
    R2010,
    R2512,
    R3216,
    R3225,
    R4532,
    R5040,
    
    //插针式电阻
    DIP_RES_Axial_1_4W,
    DIP_RES_Axial_1_2W,
    DIP_RES_Axial_1W,
    DIP_RES_Axial_2W,
    DIP_RES_Axial_3W,
    DIP_RES_Axial_5W,
    
    //电位器
    POT_3mm,
    POT_4mm,
    POT_5mm,
    POT_6mm,
    POT_8mm,
    POT_10mm,
    POT_12mm,
    POT_16mm,
    POT_20mm,
    POT_25mm,
    POT_DIP_6mm,
    POT_DIP_10mm,
    POT_DIP_15mm,
    
    //排阻
    RN_2PIN,
    RN_3PIN,
    RN_4PIN,
    RN_5PIN,
    RN_6PIN,
    RN_7PIN,
    RN_8PIN,
    RN_9PIN,
    RN_10PIN,
    RN_12PIN,
    RN_16PIN,
    
    //SMD排阻
    RN_SMD_0603_4PIN,
    RN_SMD_0805_4PIN,
    RN_SMD_1206_4PIN,
    RN_SMD_0603_8PIN,
    RN_SMD_0805_8PIN,
    RN_SMD_1206_8PIN,
    
    //片式电感
    L0201,
    L0402,
    L0603,
    L0805,
    L1206,
    L1210,
    L1808,
    L1812,
    L2010,
    L2512,
    
    //功率电感
    POWER_IND_3x3mm,
    POWER_IND_4x4mm,
    POWER_IND_5x5mm,
    POWER_IND_6x6mm,
    POWER_IND_8x8mm,
    POWER_IND_10x10mm,
    POWER_IND_12x12mm,
    POWER_IND_14x14mm,
    POWER_IND_16x16mm,
    
    //插件式电感
    DIP_IND_Axial_5x10mm,
    DIP_IND_Axial_6x12mm,
    DIP_IND_Axial_8x15mm,
    DIP_IND_Radial_5x10mm,
    DIP_IND_Radial_6x12mm,
    DIP_IND_Radial_8x15mm,
    
    //磁珠
    BEAD_0402,
    BEAD_0603,
    BEAD_0805,
    BEAD_1206,
    
    //片式二极管
    SOD_123,
    SOD_323,
    SOD_523,
    SOD_723,
    SMA,
    SMB,
    SMC,
    DO_214AC,
    DO_214AB,
    DO_214AA,
    
    //插件式二极管
    DO_41,
    DO_35,
    DO_15,
    DO_201AD,
    AXIAL_1N400X,
    AXIAL_1N540X,
    
    //发光二极管
    LED_0603,
    LED_0805,
    LED_1206,
    LED_3mm,
    LED_5mm,
    LED_8mm,
    LED_DIP,
    //桥堆
    BRIDGE_KBPC_2A,
    BRIDGE_KBPC_3A,
    BRIDGE_KBPC_5A,
    BRIDGE_KBPC_10A,
    BRIDGE_GBU_4A,
    BRIDGE_GBU_6A,
    BRIDGE_GBU_8A,
    BRIDGE_DIP_4PIN,
    
    //贴片三极管
    SOT_23,
    SOT_323,
    SOT_523,
    SOT_89,
    SOT_223,
    DPAK,
    D2PAK,
    TO_252,
    TO_263,
    TO_220_SMD,
    
    //插件三极管
    TO_92,
    TO_126,
    TO_220,
    TO_3,
    TO_39,
    TO_5,
    TO_18,
    TO_202,
    TO_3P,
    
    //贴片MOS管
    SOT_23_3,
    SOT_23_5,
    SOIC_8_MOS,
    DPAK,
    D2PAK,
    TO_251,
    TO_262,
    TO_252,
    TO_263,
    TO_220_SMD,
    QFN_8,
    QFN_16,
    PowerPAK_SO8,
    PowerPAK_8x8,
    
    //插件MOS管
    TO_92,
    TO_220,
    TO_220FP,
    TO_247,
    TO_3,
    TO_3P,
    TO_3PL,
    TO_264,
    
    //IC封装 - DIP系列
    DIP_6,
    DIP_8,
    DIP_10,
    DIP_12,
    DIP_14,
    DIP_16,
    DIP_18,
    DIP_20,
    DIP_24,
    DIP_28,
    DIP_40,
    DIP_64,
    
    //IC封装 - SMD系列
    SOIC_4,
    SOIC_6,
    SOIC_8,
    SOIC_10,
    SOIC_12,
    SOIC_14,
    SOIC_16,
    SOIC_18,
    SOIC_20,
    SOIC_24,
    SOIC_28,
    
    //IC封装 - SOP系列
    SOP_8,
    SOP_14,
    SOP_16,
    SOP_20,
    SOP_24,
    SOP_28,
    
    //IC封装 - TSSOP系列
    TSSOP_8,
    TSSOP_10,
    TSSOP_14,
    TSSOP_16,
    TSSOP_20,
    TSSOP_24,
    TSSOP_28,
    
    //IC封装 - QFP系列
    QFP_32,
    QFP_44,
    QFP_48,
    QFP_64,
    QFP_80,
    QFP_100,
    QFP_128,
    //IC封装 - BGA系列
    BGA_144,
    BGA_196,
    BGA_256,
    BGA_324,
    
    //IC封装 - 其他
    TSOP_48,
    TSOP_56,
    LGA_100,
    LGA_144,
    QFN20,

    //连接器
    HEADER_2PIN,
    HEADER_4PIN,
    HEADER_6PIN,
    HEADER_8PIN,
    HEADER_10PIN,
    HEADER_12PIN,
    HEADER_16PIN,
    HEADER_20PIN,
    HEADER_24PIN,
    HEADER_40PIN,
    
    //USB连接器
    USB_A,
    USB_B,
    USB_Mini,
    USB_Micro,
    USB_C,

    //其他连接器
    SIP2,

    //HDMI连接器
    HDMI_A,
    
    //晶振
    Xtal_3225,
    Xtal_3215,
    Xtal_2520,
    Xtal_2016,
    Xtal_1612,
    Xtal_DIP_2PIN,
    Xtal_DIP_4PIN,
    
    //继电器
    RELAY_SMD,
    RELAY_DIP_2PIN,
    RELAY_DIP_4PIN,
    RELAY_DIP_5PIN,
    RELAY_DIP_8PIN,
    
    //传感器
    SENSOR_SMD,
    SENSOR_DIP_3PIN,
    SENSOR_DIP_4PIN,
    //麦克风
    MIC_SIP2,
    MIC_WM7121P,

    //变压器
    TRANSFORMER_SMD,
    TRANSFORMER_DIP,
    
    //开关
    SWITCH_SMD,
    SWITCH_TACTILE,
    SWITCH_DIP,

    //扬声器
    SPEAKER_PHB2AWB,

    //保险丝
    FUSE_SMD_0402,
    FUSE_SMD_0603,
    FUSE_SMD_0805,
    FUSE_DIP,

    //单点焊盘 - 矩形
    PAD_0402,
    PAD_0603,
    PAD_0805,
    PAD_1206,
    
    //单点焊盘 - 圆形
    PAD_CIRC_0_6MM,
    PAD_CIRC_0_8MM,
    PAD_CIRC_1_0MM,
    PAD_CIRC_1_2MM,
    PAD_CIRC_1_5MM,
    PAD_CIRC_2_0MM,
    PAD_CIRC_2_5MM,
    
    //测试点
    TEST_POINT
}

