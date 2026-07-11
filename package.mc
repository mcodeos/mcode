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

# Naming convention (JEDEC / IPC standard, see package-catalog doc):
#   1. Base family name is glued to the pin count — `DIP8`, `QFN48`,
#      `LQFP100`. Putting an underscore between family and pin count
#      (`QFN_8`, `DIP_16`) is a deprecated form and is not used here.
#   2. When the same pin count ships in multiple body sizes, the body
#      size is appended after an underscore: `QFN20_4x4`, `QFN20_5x5`,
#      `LQFP48_7x7`, `DFN8_3x3`.
#   3. Family prefix modifiers (T/TSSOP, V/VQFN, W/WQFN, U/UQFN, HV/HVQFN,
#      EP/exposed pad) are part of the family name and do NOT take a
#      separator before the pin count: `VQFN16_3x3`, `UQFN8_2x2`.
#   4. Where JEDEC uses a hyphen inside the family name (`SOT-23`,
#      `TO-220`, `TSOP-I`, `SC-70`) the hyphen is replaced by an
#      underscore so the identifier is parser-legal: `SOT_23_3`,
#      `TO_220`, `TSOP_I48`, `SC_70_3`.
#   5. All identifiers are upper-case; datasheet prose may use any case.

enum PKG
{
    // ----------------------------------------------------------------
    // Chip capacitors (EIA size code — length x width in 0.01 in / inch)
    // ----------------------------------------------------------------
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

    // ----------------------------------------------------------------
    // Axial-lead through-hole electrolytic capacitors (body L x D, mm)
    // ----------------------------------------------------------------
    DIP_CAP_Axial_3x5mm,
    DIP_CAP_Axial_5x11_5mm,
    DIP_CAP_Axial_6_3x12_5mm,
    DIP_CAP_Axial_8x16mm,
    DIP_CAP_Axial_10x16mm,
    DIP_CAP_Axial_10x20mm,
    DIP_CAP_Axial_12_5x25mm,

    // ----------------------------------------------------------------
    // Radial-lead through-hole electrolytic capacitors (body L x D, mm)
    // ----------------------------------------------------------------
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

    // ----------------------------------------------------------------
    // Tantalum chip capacitors (EIA/A case-size letter)
    // ----------------------------------------------------------------
    TANTALUM_A,
    TANTALUM_B,
    TANTALUM_C,
    TANTALUM_D,
    TANTALUM_E,
    TANTALUM_V,
    TANTALUM_VJ,
    TANTALUM_VK,

    // ----------------------------------------------------------------
    // Through-hole film / safety capacitors
    // ----------------------------------------------------------------
    DIP_CAP_MKT,    // Metallized polyester (MKT) film
    DIP_CAP_CBB,    // Metallized polypropylene (CBB) film
    DIP_CAP_X2,     // X2 safety, across the line
    DIP_CAP_Y1,     // Y1 safety, line-to-ground
    DIP_CAP_Y2,     // Y2 safety, line-to-ground

    // ----------------------------------------------------------------
    // Chip resistors (EIA size code — length x width in 0.01 in / inch)
    // ----------------------------------------------------------------
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

    // ----------------------------------------------------------------
    // Axial-lead through-hole resistors (rated power)
    // ----------------------------------------------------------------
    DIP_RES_Axial_1_4W,
    DIP_RES_Axial_1_2W,
    DIP_RES_Axial_1W,
    DIP_RES_Axial_2W,
    DIP_RES_Axial_3W,
    DIP_RES_Axial_5W,

    // ----------------------------------------------------------------
    // Potentiometers (body diameter or DIP pin spacing, mm)
    // ----------------------------------------------------------------
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

    // ----------------------------------------------------------------
    // Through-hole resistor networks (DIP/SIP, common-bussed or isolated)
    // ----------------------------------------------------------------
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

    // ----------------------------------------------------------------
    // SMD resistor networks (EIA size code + pin count)
    // ----------------------------------------------------------------
    RN_SMD_0603_4PIN,
    RN_SMD_0805_4PIN,
    RN_SMD_1206_4PIN,
    RN_SMD_0603_8PIN,
    RN_SMD_0805_8PIN,
    RN_SMD_1206_8PIN,

    // ----------------------------------------------------------------
    // Chip inductors (EIA size code — length x width in 0.01 in / inch)
    // ----------------------------------------------------------------
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

    // ----------------------------------------------------------------
    // Power inductors (SMD, body L x W, mm)
    // ----------------------------------------------------------------
    POWER_IND_3x3mm,
    POWER_IND_4x4mm,
    POWER_IND_5x5mm,
    POWER_IND_6x6mm,
    POWER_IND_8x8mm,
    POWER_IND_10x10mm,
    POWER_IND_12x12mm,
    POWER_IND_14x14mm,
    POWER_IND_16x16mm,

    // ----------------------------------------------------------------
    // Through-hole inductors (axial / radial, body L x D, mm)
    // ----------------------------------------------------------------
    DIP_IND_Axial_5x10mm,
    DIP_IND_Axial_6x12mm,
    DIP_IND_Axial_8x15mm,
    DIP_IND_Radial_5x10mm,
    DIP_IND_Radial_6x12mm,
    DIP_IND_Radial_8x15mm,

    // ----------------------------------------------------------------
    // Ferrite beads (SMD, EIA size code)
    // ----------------------------------------------------------------
    BEAD_0402,
    BEAD_0603,
    BEAD_0805,
    BEAD_1206,

    // ----------------------------------------------------------------
    // SMD diodes (SOD family + flat-package rectifiers)
    // ----------------------------------------------------------------
    SOD_123,    // SOD-123 small-signal diode
    SOD_323,    // SOD-323 small-signal diode
    SOD_523,    // SOD-523 small-signal diode
    SOD_723,    // SOD-723 small-signal diode
    SMA,        // DO-214AC / SMA flat package
    SMB,        // DO-214AA / SMB flat package
    SMC,        // DO-214AB / SMC flat package
    DO_214AC,   // SMA explicit (DO-214AC)
    DO_214AB,   // SMC explicit (DO-214AB)
    DO_214AA,   // SMB explicit (DO-214AA)

    // ----------------------------------------------------------------
    // Through-hole axial-lead diodes
    // ----------------------------------------------------------------
    DO_41,        // DO-41 small-signal rectifier
    DO_35,        // DO-35 glass small-signal diode
    DO_15,        // DO-15 medium-power rectifier
    DO_201AD,     // DO-201AD high-power rectifier
    AXIAL_1N400X, // 1N4001..1N4007 family axial rectifier
    AXIAL_1N540X, // 1N5400..1N5408 family axial rectifier

    // ----------------------------------------------------------------
    // LEDs (SMD EIA size codes, through-hole diameters, DIP)
    // ----------------------------------------------------------------
    LED_0603,
    LED_0805,
    LED_1206,
    LED_3mm,   // 3 mm through-hole LED
    LED_5mm,   // 5 mm through-hole LED
    LED_8mm,   // 8 mm through-hole LED
    LED_DIP,   // rectangular DIP LED

    // ----------------------------------------------------------------
    // Bridge rectifiers (KBPC/GBU series; DIP-4 is the through-hole SIL form)
    // ----------------------------------------------------------------
    BRIDGE_KBPC_2A,
    BRIDGE_KBPC_3A,
    BRIDGE_KBPC_5A,
    BRIDGE_KBPC_10A,
    BRIDGE_GBU_4A,
    BRIDGE_GBU_6A,
    BRIDGE_GBU_8A,
    BRIDGE_DIP_4PIN,

    // ----------------------------------------------------------------
    // SMD transistors / MOSFETs (SOT/SC family + DPAK/D2PAK + QFN)
    // See SOT section below for SOT-23-3/5/6 etc.
    // ----------------------------------------------------------------
    SOT_23,        // SOT-23 generic (3-lead)
    SOT_23_3,      // SOT-23, 3-lead variant
    SOT_23_5,      // SOT-23, 5-lead variant
    SOT_23_6,      // SOT-23, 6-lead variant
    SOT_323,       // SOT-323 (smaller than SOT-23)
    SOT_523,       // SOT-523 (smaller than SOT-323)
    SOT_89,        // SOT-89 medium-power
    SOT_143,       // SOT-143 RF / dual-gate
    SOT_223,       // SOT-223 medium-power

    // SC (sub-SOT) packages — JEDEC SC-70 / SC-88
    SC_70_3,       // SC-70, 3-lead
    SC_70_5,       // SC-70, 5-lead
    SC_70_6,       // SC-70, 6-lead
    SC_88A,        // SC-88A (SOT-363 footprint)

    // SMD power packages (JEDEC TO-252 / TO-263 / Vishay PowerPAK / QFN)
    DPAK,                 // TO-252 (DPAK), 3-lead
    D2PAK,                // TO-263 (D2PAK), 3-lead
    TO_252,               // JEDEC TO-252 alias
    TO_263,               // JEDEC TO-263 alias
    TO_220_SMD,           // SMD version of TO-220
    TO_251,               // JEDEC TO-251 (3-lead IPAK)
    TO_262,               // JEDEC TO-262 (3-lead I2PAK)
    PowerPAK_SO8,         // Vishay PowerPAK SO-8
    PowerPAK_8x8,         // Vishay PowerPAK 8x8

    // ----------------------------------------------------------------
    // Through-hole discrete transistors / MOSFETs (JEDEC TO family)
    // ----------------------------------------------------------------
    TO_92,      // Small-signal (e.g. 2N3904)
    TO_126,     // Medium-power (e.g. BD135)
    TO_220,     // Most common power transistor footprint
    TO_220_3,   // TO-220, 3-lead (standard)
    TO_220_4,   // TO-220, 4-lead (e.g. some linear regulators)
    TO_220_5,   // TO-220, 5-lead (e.g. LM2596, LM7805-style regulators)
    TO_220_7,   // TO-220, 7-lead (e.g. LM317HV, dual MOSFETs)
    TO_220FP,   // TO-220 Full Pack (insulated tab)
    TO_3,       // Large metal-can power
    TO_3P,      // TO-3P plastic power
    TO_3PL,     // TO-3PL (long-lead variant)
    TO_247,     // High-current power (e.g. IRFP)
    TO_247_4,   // TO-247, 4-lead (e.g. some IGBTs)
    TO_264,     // High-power plastic
    TO_39,      // Metal-can small-signal
    TO_46,      // Metal-can, photo-transistor / optocoupler
    TO_5,       // Metal-can, TO-39 family
    TO_18,      // Metal-can, smaller than TO-39
    TO_202,     // Plastic medium-power

    // =================================================================
    // IC packages — JEDEC / IPC standard naming (family glued to pin count)
    // =================================================================

    // -----------------------------------------------------------------
    // DIP — Dual In-line Package, 2.54 mm pitch (Through Hole)
    // -----------------------------------------------------------------
    DIP4,        // 4-pin (optocoupler, small SSR, rectifier bridges)
    DIP6,        // 6-pin
    DIP8,        // 8-pin (e.g. NE555, LM741, ATtiny DIP)
    DIP10,
    DIP12,
    DIP14,       // 14-pin (e.g. 74LS00, LM324)
    DIP16,       // 16-pin
    DIP18,
    DIP20,
    DIP22,
    DIP24,
    DIP28,
    DIP32,
    DIP36,
    DIP40,       // 40-pin (e.g. ATmega32, Z80)
    DIP64,       // non-standard, but used by some 65xx / 68xx logic
    DIP_TAB,     // Generic DIP with attached metal heat-spreading tab

    // CDIP — Ceramic DIP (hermetic glass seal)
    CDIP8,
    CDIP14,
    CDIP16,
    CDIP24,

    // SDIP — Shrink DIP (narrower body / pitch)
    SDIP16,
    SDIP24,
    SDIP28,

    // -----------------------------------------------------------------
    // SIP / ZIP — Single In-line Package / Zig-zag In-line Package
    // -----------------------------------------------------------------
    SIP3,
    SIP4,
    SIP5,
    SIP6,
    SIP7,
    SIP8,
    SIP9,
    SIP10,
    SIP12,
    ZIP10,
    ZIP16,
    ZIP24,
    ZIP28,

    // -----------------------------------------------------------------
    // PGA — Pin Grid Array (CPU / legacy logic)
    // -----------------------------------------------------------------
    // Generic PGA (no substrate specified)
    PGA48,
    PGA84,
    PGA132,
    // PPGA — Plastic PGA (standard organic substrate)
    PPGA48,
    PPGA84,
    PPGA132,
    // CPGA — Ceramic PGA (hermetic, used on classic CPUs)
    CPGA44,
    CPGA80,
    CPGA132,

    // -----------------------------------------------------------------
    // SOIC / SOP — Small-Outline IC, 1.27 mm pitch (wing lead)
    // -----------------------------------------------------------------
    SOIC4,
    SOIC6,
    SOIC8,        // e.g. TL072, MAX232
    SOIC10,
    SOIC12,
    SOIC14,
    SOIC16,       // e.g. 74HC595, MAX485
    SOIC18,
    SOIC20,
    SOIC24,
    SOIC28,
    SOIC32,
    SOIC36,
    SOIC40,

    // SOP family alias (industry shorthand, identical to SOIC)
    SOP8,
    SOP16,
    SOP24,
    SOP28,

    // SSOP — Shrink Small-Outline Package, 0.65 mm pitch
    SSOP8,
    SSOP14,
    SSOP16,
    SSOP20,
    SSOP24,
    SSOP28,
    SSOP32,
    SSOP36,
    SSOP40,
    SSOP48,
    SSOP56,

    // MSOP — Mini Small-Outline Package
    // Also marketed as MiniSOIC (TI nomenclature). Same body as SSOP but
    // with fewer pins for a given outline size.
    MSOP8,
    MSOP10,
    MSOP16,
    MSOP20,

    // TSSOP — Thin Shrink Small-Outline Package, 0.65 mm pitch, thin body
    TSSOP8,
    TSSOP10,
    TSSOP14,
    TSSOP16,
    TSSOP20,
    TSSOP24,
    TSSOP28,
    TSSOP32,
    TSSOP36,
    TSSOP40,
    TSSOP44,
    TSSOP48,
    TSSOP56,
    TSSOP64,

    // VSOP — Very Small-Outline Package (ultra-thin)
    VSOP8,
    VSOP16,
    VSOP24,

    // HSOP — Small-Outline Package with Heat Sink (power)
    HSOP8,
    HSOP16,
    HSOP28,

    // TSOP — Thin Small-Outline Package (flash / DRAM), Type I and Type II
    TSOP_I40,
    TSOP_I48,
    TSOP_I56,
    TSOP_II40,
    TSOP_II44,
    TSOP_II48,

    // SOJ — Small-Outline J-lead (DRAM, inward J-bend)
    SOJ24,
    SOJ32,
    SOJ40,

    // -----------------------------------------------------------------
    // DFN / SON — Dual / Small Outline No-lead, two-sided
    // -----------------------------------------------------------------
    DFN8_2x2,
    DFN8_3x3,
    DFN10_3x3,
    DFN12_3x3,
    DFN16_3x3,
    DFN16_4x4,
    DFN20_4x4,
    DFN20_5x5,
    DFN24_5x5,
    DFN32_6x6,

    SON8,
    SON10,
    SON12,
    SON16,
    SON20,

    // uDFN — ultra-thin DFN (0.4 mm pitch, ultra-low body, hand-portable)
    uDFN8,

    // USON — ultra-thin SON (smaller than SON, typically < 0.5 mm body)
    USON8,
    USON10,
    USON12,
    USON16,

    // -----------------------------------------------------------------
    // QFN — Quad Flat No-lead, four-sided (high-frequency / power / MCU)
    // Body size appended after `_` when the same pin count ships in
    // multiple sizes; "EP" (exposed pad) is implicit on every QFN here.
    // -----------------------------------------------------------------
    // Generic QFN (pin count only — accept any body size)
    QFN8,
    QFN12,
    QFN16,
    QFN20,
    QFN24,
    QFN32,
    QFN40,
    QFN48,
    QFN64,

    // Body-size-specific QFN variants
    QFN8_3x3,
    QFN12_3x3,
    QFN16_3x3,
    QFN16_4x4,
    QFN20_4x4,
    QFN20_5x5,
    QFN24_4x4,
    QFN24_5x5,
    QFN32_5x5,
    QFN32_6x6,
    QFN40_6x6,
    QFN40_8x8,
    QFN48_7x7,
    QFN48_9x9,
    QFN64_10x10,

    // VQFN — Very-thin QFN (low-profile)
    VQFN16_3x3,
    VQFN20_4x4,
    VQFN24_5x5,
    VQFN32_6x6,
    VQFN48_7x7,

    // WQFN — Wide-body QFN
    WQFN16,
    WQFN24,
    WQFN32,
    WQFN48,

    // UQFN — Ultra-small QFN, 0.4 mm pitch
    // Bare UQFN tokens (pin count only — accept any standard 0.4 mm body)
    UQFN8,
    UQFN12,
    UQFN16,
    // Body-size-specific UQFN variants
    UQFN8_2x2,
    UQFN12_2x2,
    UQFN16_3x3,

    // HVQFN — High-Voltage QFN (power)
    HVQFN16,
    HVQFN24,
    HVQFN32,

    // MLF — MicroLeadFrame, Japanese vendor equivalent of QFN
    // (Microchip / ON Semi naming convention)
    MLF8,
    MLF16,
    MLF20,
    MLF24,
    MLF32,

    // -----------------------------------------------------------------
    // QFP / LQFP / TQFP — Quad Flat Package, four-sided wing lead
    // (multi-pin MCU / DSP)
    // -----------------------------------------------------------------
    // LQFP — Low-profile QFP (most common for MCUs)
    // Generic LQFP (pin count only — accept any standard body size)
    LQFP32,
    LQFP48,
    LQFP64,
    LQFP80,
    LQFP100,
    LQFP128,
    LQFP144,

    // Body-size-specific LQFP variants
    LQFP32_7x7,
    LQFP48_7x7,
    LQFP64_10x10,
    LQFP80_12x12,
    LQFP100_14x14,
    LQFP128_14x14,
    LQFP144_20x20,
    LQFP176_24x24,

    // TQFP — Thin QFP
    TQFP32,
    TQFP44,
    TQFP48,
    TQFP64,
    TQFP80,
    TQFP100,
    TQFP128,

    // QFP — Standard (thicker) QFP
    QFP32,
    QFP44,
    QFP48,
    QFP64,
    QFP80,
    QFP100,
    QFP128,

    // CQFP — Cerquad (ceramic) QFP
    CQFP44,
    CQFP64,
    CQFP100,

    // EQFP — Enhanced QFP (extra-wide body, high pin count)
    EQFP144,
    EQFP176,
    EQFP208,
    // MQFP — Metric QFP (JEDEC standard pin-pitch ladder)
    MQFP44,
    MQFP64,
    MQFP80,
    MQFP100,

    // -----------------------------------------------------------------
    // PLCC — Plastic Leaded Chip Carrier, J-bend, socketable
    // -----------------------------------------------------------------
    PLCC20,
    PLCC28,
    PLCC32,
    PLCC44,
    PLCC52,
    PLCC68,
    PLCC84,

    // CLCC — Ceramic LCC
    CLCC20,
    CLCC44,
    CLCC68,

    // -----------------------------------------------------------------
    // BGA / LGA / CSP — bottom-array contacts (high pin count)
    // -----------------------------------------------------------------
    // Family overview:
    //   PBGA = Plastic BGA, CBGA = Ceramic BGA, FBGA = Fine-pitch BGA,
    //   nFBGA = Next-generation fine-pitch BGA, FCBGA = Flip-chip BGA.
    //   Generic bare BGA tokens cover the catalog doc example list.

    // CBGA — Ceramic BGA (high reliability, CTE-matched to ceramic PCB)
    CBGA48,
    CBGA64,
    CBGA96,
    CBGA144,
    CBGA256,

    // FBGA — Fine-pitch Plastic BGA
    FBGA48,
    FBGA64,
    FBGA100,
    FBGA128,
    FBGA144,
    FBGA169,
    FBGA256,

    // nFBGA — Next-generation fine-pitch BGA (smaller ball pitch than FBGA)
    nFBGA64,
    nFBGA100,
    nFBGA144,
    nFBGA256,

    // PBGA — standard Plastic BGA
    PBGA100,
    PBGA144,
    PBGA208,
    PBGA256,
    PBGA384,

    // Generic BGA tokens (catalog doc example list)
    BGA128,
    BGA256,

    // FCBGA — Flip-Chip BGA (FPGA / high-end processors)
    FCBGA484,
    FCBGA676,
    FCBGA1152,

    // LGA — Land Grid Array (no solder balls)
    LGA48,
    LGA100,
    LGA144,
    LGA1156,    // Desktop CPU socket
    LGA1200,
    LGA1700,
    LGA2066,

    // CSP / WLCSP — wafer-level / chip-scale packages
    DSBGA6,     // TI die-size BGA, 6 bumps
    DSBGA8,     // TI die-size BGA, 8 bumps
    WCSP12,     // Wafer-level CSP, 12 bumps
    uCSP16,     // Micro-CSP, 16 bumps
    FCCSP20,    // Flip-chip CSP, 20 balls

    // -----------------------------------------------------------------
    // Discrete SMD power (JEDEC TO-style SMD, DPAK family aliases)
    // -----------------------------------------------------------------
    TO_268,     // D3PAK (TO-268), 3-lead
    TO_277,     // 4-lead SMD power
    LFPAK33,    // Nexperia LFPAK33
    LFPAK56,
    LFPAK88,

    // -----------------------------------------------------------------
    // Other discrete SMD packages
    // -----------------------------------------------------------------
    SOD_923,

    // -----------------------------------------------------------------
    // Special / advanced packages (RF, multi-chip, system-in-package)
    // -----------------------------------------------------------------
    SiP4,        // System-in-Package, 4-pin interface
    SiP8,
    SiP16,
    MCM,         // Multi-Chip Module
    AiP,         // Antenna-in-Package (mmWave RF)
    COB,         // Chip-on-Board
    FLGA,        // Fine-pitch LGA

    // =================================================================
    // Connectors
    // =================================================================

    // -----------------------------------------------------------------
    // Pin headers (2.54 mm pitch, vertical/right-angle through-hole)
    // -----------------------------------------------------------------
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

    // -----------------------------------------------------------------
    // USB connectors
    // -----------------------------------------------------------------
    USB_A,         // USB Type-A receptacle
    USB_B,         // USB Type-B receptacle
    USB_Mini,      // USB Mini-B receptacle
    USB_Micro,     // USB Micro-B receptacle
    USB_C,         // USB Type-C receptacle
    USB_TypeC,     // Alias of USB_C for projects that prefer the long form

    // -----------------------------------------------------------------
    // Other board-level connectors
    // -----------------------------------------------------------------
    SIP2,          // 2-pin SIP/socket
    HDMI_A,        // HDMI Type-A receptacle

    // =================================================================
    // Crystals & oscillators
    // =================================================================
    // Body size L x W in 0.1 mm units (e.g. 3225 = 3.2 x 2.5 mm)
    Xtal_3225,
    Xtal_3215,
    Xtal_2520,
    Xtal_2016,
    Xtal_1612,
    Xtal_DIP_2PIN,    // Through-hole HC-49 2-pin
    Xtal_DIP_4PIN,    // Through-hole 4-pin oscillator module
    XTAL,             // Generic crystal / oscillator package alias

    // =================================================================
    // Relays
    // =================================================================
    RELAY_SMD,         // SMD relay
    RELAY_DIP_2PIN,    // Through-hole, 2-pin
    RELAY_DIP_4PIN,    // Through-hole, 4-pin (coil + 2 form-A contacts)
    RELAY_DIP_5PIN,
    RELAY_DIP_8PIN,    // Through-hole, 8-pin DPDP

    // =================================================================
    // Sensors
    // =================================================================
    SENSOR_SMD,        // SMD sensor
    SENSOR_DIP_3PIN,   // 3-pin through-hole (e.g. linear temp sensor)
    SENSOR_DIP_4PIN,

    // =================================================================
    // Microphones
    // =================================================================
    MIC_SIP2,          // 2-pin SIP electret mic
    MIC_WM7121P,       // Specific part package reference

    // =================================================================
    // Transformers
    // =================================================================
    TRANSFORMER_SMD,   // SMD transformer
    TRANSFORMER_DIP,   // Through-hole transformer

    // =================================================================
    // Switches
    // =================================================================
    SWITCH_SMD,        // SMD tact switch
    SWITCH_TACTILE,    // Through-hole tact switch
    SWITCH_DIP,        // DIP switch (multi-pole)

    // =================================================================
    // Speakers & buzzers
    // =================================================================
    SPEAKER_PHB2AWB,   // Specific speaker footprint

    // =================================================================
    // Fuses
    // =================================================================
    FUSE_SMD_0402,     // SMD chip fuse, EIA 0402
    FUSE_SMD_0603,
    FUSE_SMD_0805,
    FUSE_DIP,          // Through-holder fuse (5 x 20 mm etc.)

    // =================================================================
    // Single-pad landing patterns
    // =================================================================
    // Rectangular SMD pads (EIA size code)
    PAD_0402,
    PAD_0603,
    PAD_0805,
    PAD_1206,

    // Round through-hole pads (hole diameter, mm)
    PAD_CIRC_0_6MM,
    PAD_CIRC_0_8MM,
    PAD_CIRC_1_0MM,
    PAD_CIRC_1_2MM,
    PAD_CIRC_1_5MM,
    PAD_CIRC_2_0MM,
    PAD_CIRC_2_5MM,

    // =================================================================
    // Test points
    // =================================================================
    TEST_POINT
}
