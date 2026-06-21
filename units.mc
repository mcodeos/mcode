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

/*
UV.VOLT        // Voltage (volts)
                ("V"|"v"|"mV"|"mv"|"μV"|"µV"|"uV"|"nV"|"NV"|"pV"|"PV"|"fV"|"FV"|"kV"|"KV"|"MV"|"MV"|"GV"|"GV")
UV.AMP         // Current (amperes)
                ("A"|"mA"|"μA"|"µA"|"uA"|"nA"|"kA")
UV.CAP         // Capacitance (farads)
                ("F"|"mF"|"μF"|"µF"|"uF"|"nF"|"pF")
UV.IND         // Inductance (henries)
                ("H"|"mH"|"μH"|"µH"|"uH"|"nH"|"pH")
UV.TIME        // Time (seconds)
                ("s"|"ms"|"μs"|"µs"|"us"|"ns"|"ps")
UV.LEN         // Length (meters)
                ("nm"|"μm"|"µm"|"um"|"mm"|"cm"|"m"|"km"|"mil"|"inch")
UV.WAT         // Power (watts)
                ("W"|"mW"|"μW"|"µW"|"uW"|"nW"|"kW"|"MW"|"GW")
UV.OHM         // Resistance (ohms)
                ("R"|"Ω"|"mΩ"|"μΩ"|"µΩ"|"uΩ"|"nΩ"|"kΩ"|"MΩ"|"GΩ")
UV.TEMP        // Temperature (celsius)
                ("℃"|"℉"|"°C"|"°F")
UV.HZ          // Frequency (hertz)
                ("Hz"|"kHz"|"MHz"|"GHz"|"THz")
UV.DB          // Decibels
                ("dBc"|"dBd"|"dBi"|"dBm"|"dBw"|"dB")
UV.PPM         // Parts per million
                ("ppm")
UV.PERCENT     // Percentage
                ("%")
UV.BAUD        // Baud rate (symbols per second)
                ("bps"|"Bps"|"kbps"|"kBps"|"Mbps"|"MBps"|"Gbps"|"GBps"|"Tbps"|"TBps")
UV.DATASIZE    // Data size (bytes)
                ("b"|"B"|"kb"|"kB"|"Mb"|"MB"|"Gb"|"GB"|"Tb"|"TB")
UV.SPS         // ADC sampling rate (samples per second)
                ("SPS"|"kSPS"|"MSPS"|"GSPS")
UV.SIEMENS     // Conductance (siemens)
                ("S"|"mS"|"μS"|"µS"|"uS"|"nS"|"pS"|"kS"|"MS")
UV.RESPONSIVITY // Photodiode responsivity (amperes per watt)
                ("A/W"|"mA/W"|"μA/W"|"µA/W"|"uA/W"|"nA/W")

*/

/*
电子设计领域全量单位字符集（标准版 + 兼容版）
按基础通用 / 电学核心 / 物理计量 / 射频微波 / 磁学 / 电源 / 模拟电路 / 时序精度 / 光电 / PCB 工程 / 声学 EMC分类，均为("XX"|"XX")格式，无重复、规则统一，微单位均保留μX/µX/uX3 种写法，可直接用于正则匹配 / 数据校验。
一、基础通用单位
标准版
("ppm"|"ppb"|"ppt"|"ppq"|"%"|"‰"|"‱"|"%RH")
兼容版
("ppm"|"PPM"|"ppb"|"PPB"|"ppt"|"PPT"|"ppq"|"PPQ"|"%"|"‰"|"‱"|"%RH"|"%rh"|"%%")
二、电学核心单位
1. 电压（V）
标准版
("V"|"mV"|"μV"|"µV"|"uV"|"nV"|"pV"|"kV"|"MV"|"GV")
兼容版
("V"|"v"|"mV"|"μV"|"µV"|"uV"|"nV"|"NV"|"pV"|"PV"|"kV"|"KV"|"MV"|"GV")
2. 电流（A）
标准版
("A"|"mA"|"μA"|"µA"|"uA"|"nA"|"pA"|"kA"|"MA"|"GA")
兼容版
("A"|"a"|"mA"|"μA"|"µA"|"uA"|"nA"|"NA"|"pA"|"PA"|"kA"|"KA"|"MA"|"GA")
3. 电容（F）
标准版
("F"|"mF"|"μF"|"µF"|"uF"|"nF"|"pF"|"kF"|"MF"|"GF")
兼容版
("F"|"f"|"mF"|"μF"|"µF"|"uF"|"nF"|"NF"|"pF"|"PF"|"kF"|"KF"|"MF"|"GF")
4. 电感（H）
标准版
("H"|"mH"|"μH"|"µH"|"uH"|"nH"|"pH"|"kH"|"MH"|"GH")
兼容版
("H"|"h"|"mH"|"μH"|"µH"|"uH"|"nH"|"NH"|"pH"|"PH"|"kH"|"KH"|"MH"|"GH")
5. 功率（W）
标准版
("W"|"mW"|"μW"|"µW"|"uW"|"nW"|"kW"|"MW"|"GW")
兼容版
("W"|"w"|"mW"|"μW"|"µW"|"uW"|"nW"|"NW"|"kW"|"KW"|"MW"|"GW")
6. 电阻（Ω/R）
标准版
("R"|"Ω"|"mΩ"|"μΩ"|"µΩ"|"uΩ"|"nΩ"|"kΩ"|"MΩ"|"GΩ")
兼容版
("R"|"r"|"Ω"|"mΩ"|"μΩ"|"µΩ"|"uΩ"|"nΩ"|"NΩ"|"kΩ"|"KΩ"|"MΩ"|"GΩ")
7. 电导（西门子 S）
标准版
("S"|"mS"|"μS"|"µS"|"uS"|"nS"|"pS"|"kS"|"MS"|"GS")
兼容版
("S"|"s"|"mS"|"μS"|"µS"|"uS"|"nS"|"NS"|"pS"|"PS"|"kS"|"KS"|"MS"|"GS")
8. 分贝（dB）
标准版
("dB"|"dBc"|"dBd"|"dBi"|"dBm"|"dBw"|"dBV"|"dBu"|"dBμV"|"dBµV"|"dBuV")
兼容版
("dB"|"db"|"DB"|"dBc"|"dBd"|"dBi"|"dBm"|"dBw"|"dBV"|"dBu"|"dBμV"|"dBµV"|"dBuV")
9. 电流功率比（A/W）
标准版
("A/W"|"mA/W"|"μA/W"|"µA/W"|"uA/W"|"nA/W"|"kA/W")
兼容版
("A/W"|"a/w"|"mA/W"|"μA/W"|"µA/W"|"uA/W"|"nA/W"|"NA/W"|"kA/W"|"KA/W")
三、物理计量单位
1. 温度
标准版
("℃"|"℉"|"°C"|"°F"|"K")
兼容版
("℃"|"℉"|"°C"|"°F"|"°c"|"°f"|"K"|"k")
2. 时间
标准版
("s"|"ms"|"μs"|"µs"|"us"|"ns"|"ps"|"fs"|"ks"|"Ms"|"Gs")
兼容版
("s"|"S"|"ms"|"MS"|"μs"|"µs"|"us"|"ns"|"NS"|"ps"|"PS"|"fs"|"FS"|"ks"|"KS"|"Ms"|"Gs")
3. 长度
标准版
("nm"|"μm"|"µm"|"um"|"mm"|"cm"|"dm"|"m"|"km"|"pm"|"fm"|"mil"|"inch"|"ft"|"yd")
兼容版
("nm"|"NM"|"μm"|"µm"|"um"|"mm"|"MM"|"cm"|"CM"|"dm"|"DM"|"m"|"M"|"km"|"KM"|"pm"|"PM"|"fm"|"FM"|"mil"|"MIL"|"inch"|"INCH"|"ft"|"FT"|"yd"|"YD")
4. 频率（Hz）
标准版
("Hz"|"mHz"|"μHz"|"µHz"|"uHz"|"nHz"|"kHz"|"MHz"|"GHz"|"THz")
兼容版
("Hz"|"hz"|"HZ"|"mHz"|"μHz"|"µHz"|"uHz"|"nHz"|"kHz"|"KHz"|"MHz"|"GHz"|"THz")
5. 速率（bps/Bps）
标准版
("bps"|"Bps"|"kbps"|"kBps"|"Mbps"|"MBps"|"Gbps"|"GBps"|"Tbps"|"TBps")
兼容版
("bps"|"Bps"|"kbps"|"Kbps"|"kBps"|"KBps"|"Mbps"|"MBps"|"Gbps"|"GBps"|"Tbps"|"TBps")
6. 存储 / 比特（b/B）
标准版
("b"|"bit"|"B"|"Byte"|"kb"|"kB"|"Mb"|"MB"|"Gb"|"GB"|"Tb"|"TB"|"Pb"|"PB"|"Eb"|"EB")
兼容版
("b"|"bit"|"B"|"Byte"|"kb"|"Kb"|"kB"|"KB"|"Mb"|"MB"|"Gb"|"GB"|"Tb"|"TB"|"Pb"|"PB"|"Eb"|"EB")
7. 采样率（SPS）
标准版
("SPS"|"kSPS"|"MSPS"|"GSPS"|"TSPS")
兼容版
("SPS"|"sps"|"Sps"|"kSPS"|"KSPS"|"MSPS"|"GSPS"|"TSPS")
四、射频 / 微波专属单位
标准版
("Ω·m"|"S/m"|"λ"|"mmλ"|"dBm/mW"|"dBi/m²"|"VSWR"|"Γ"|"dB/Oct"|"dB/dec"|"ns/m"|"ps/m")
兼容版
("Ω"|"ohm"|"OHM"|"Ω·m"|"Ω·M"|"S/m"|"s/m"|"λ"|"MMλ"|"dBm/mW"|"dBi/m²"|"VSWR"|"vswr"|"Γ"|"dB/Oct"|"dB/oct"|"dB/dec"|"dB/DEC"|"ns/m"|"ps/m")
五、磁学专属单位
标准版
("H/m"|"mH/m"|"μH/m"|"µH/m"|"uH/m"|"T"|"mT"|"G"|"Gs"|"Wb"|"mWb"|"μWb"|"µWb"|"uWb"|"Mx"|"kA/m"|"Oe"|"Φ")
兼容版
("H/m"|"mH/m"|"μH/m"|"µH/m"|"uH/m"|"T"|"mT"|"G"|"GS"|"Gs"|"Wb"|"mWb"|"μWb"|"µWb"|"uWb"|"Mx"|"MX"|"kA/m"|"KA/m"|"Oe"|"OE"|"Φ")
六、电源设计专属单位
标准版
("mVpp"|"Vpp"|"mVrms"|"Vrms"|"Arms"|"Apeak"|"W/㎡"|"W/cm²"|"%/℃"|"ppm/℃"|"mV/℃"|"μV/℃"|"µV/℃"|"uV/℃")
兼容版
("mVpp"|"MVpp"|"Vpp"|"mVrms"|"Vrms"|"Arms"|"ARMS"|"Apeak"|"APEAK"|"W/㎡"|"w/㎡"|"W/cm²"|"w/cm²"|"%/℃"|"ppm/℃"|"mV/℃"|"MV/℃"|"μV/℃"|"µV/℃"|"uV/℃")
七、模拟电路 / 信号处理单位
标准版
("V/μs"|"V/µs"|"V/us"|"V/ns"|"mA/μs"|"mA/µs"|"mA/us"|"Slew"|"dB/V"|"dB/A"|"THD"|"THD+N"|"SNR"|"ENOB"|"LSB"|"MSB"|"FS"|"FSR")
兼容版
("V/μs"|"V/µs"|"V/us"|"V/ns"|"mA/μs"|"mA/µs"|"mA/us"|"Slew"|"slew"|"dB/V"|"db/V"|"dB/A"|"db/A"|"THD"|"thd"|"THD+N"|"SNR"|"snr"|"ENOB"|"LSB"|"MSB"|"FS"|"fs"|"FSR"|"fsr")
八、时序 / 时钟 / 精度单位
标准版
("ps"|"ps/m"|"jitter"|"skew"|"ppm"|"ppb"|"UI"|"Tj"|"Ta"|"Tc"|"Tr"|"Tf"|"Ton"|"Toff"|"Hz/℃"|"MHz/℃")
兼容版
("ps"|"PS"|"ps/m"|"PS/M"|"jitter"|"JITTER"|"skew"|"SKEW"|"ppm"|"PPM"|"ppb"|"PPB"|"UI"|"ui"|"Tj"|"TJ"|"Ta"|"TA"|"Tc"|"TC"|"Tr"|"TR"|"Tf"|"TF"|"Ton"|"TON"|"Toff"|"TOFF"|"Hz/℃"|"MHz/℃")
九、光学 / 光电设计单位
标准版
("lm"|"lm/W"|"cd"|"lx"|"klx"|"W/sr"|"mW/sr"|"μW/sr"|"µW/sr"|"uW/sr"|"nm"|"μm"|"µm"|"um"|"mW/㎡"|"W/μm"|"W/µm"|"W/um")
兼容版
("lm"|"LM"|"lm/W"|"LM/W"|"cd"|"CD"|"lx"|"LX"|"klx"|"KLX"|"W/sr"|"w/sr"|"mW/sr"|"μW/sr"|"µW/sr"|"uW/sr"|"nm"|"NM"|"μm"|"µm"|"um"|"mW/㎡"|"W/μm"|"W/µm"|"W/um")
十、PCB 工程 / 封装专属单位
标准版
("mil"|"inch"|"mm"|"cm"|"μm"|"µm"|"um"|"oz"|"sq.mil"|"mm²"|"cm²"|"mil²"|"kΩ/□"|"Ω/□"|"mΩ/□"|"V/mil"|"A/mil")
兼容版
("mil"|"MIL"|"inch"|"INCH"|"mm"|"MM"|"cm"|"CM"|"μm"|"µm"|"um"|"oz"|"OZ"|"sq.mil"|"SQ.MIL"|"mm²"|"MM²"|"cm²"|"CM²"|"mil²"|"MIL²"|"kΩ/□"|"KΩ/□"|"Ω/□"|"mΩ/□"|"V/mil"|"V/MIL"|"A/mil"|"A/MIL")
十一、声学 / EMC 辅助单位
标准版
("dB(A)"|"dB(SPL)"|"Pa"|"mPa"|"μPa"|"µPa"|"uPa"|"dBuV/m"|"dBµV/m"|"dBuV/m")
兼容版
("dB(A)"|"db(a)"|"dB(SPL)"|"db(spl)"|"Pa"|"PA"|"mPa"|"μPa"|"µPa"|"uPa"|"dBuV/m"|"dBµV/m"|"dBuV/m"|"dbuv/m")
统一规则说明
微单位：所有含微量级的单位，均保留μX（希腊字母缪 U+03BC）、µX（计量微符 U+00B5）、uX（字母 u 替代）3 种写法，覆盖所有输入场景；
大小写兼容：仅对基础单位、千级前缀补充大写 / 小写非标写法，M/G/T 等高级前缀无冗余兼容，贴合实际工程输入习惯；
复合单位：比值单位仅分子添加量级前缀，分母固定为基础单位（如mA/W而非A/mW），格式统一为XX/XX；
行业缩写：射频 / 模拟 / 时序领域的通用缩写（如 VSWR、SNR、THD），仅补充全小写兼容，无拆分 / 改写；
特殊符号：欧姆Ω、千分号‰、万分号‱等专属符号，无大小写兼容，保留原生形式。
*/