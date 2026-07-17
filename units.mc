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
UV.CHARGE      // Battery capacity / electric charge (ampere-hours)
                ("μAh"|"µAh"|"uAh"|"mAh"|"Ah"|"kAh")

*/

/*
Complete unit character set for electronics design (Standard + Compatible)
Categorized as basic general / core electrical / physical measurement / RF & microwave / magnetics / power supply / analog circuits / timing & precision / optoelectronics / PCB engineering / acoustics & EMC. All entries use the ("XX"|"XX") format, no duplicates, unified rules; micro units keep all 3 spellings μX/µX/uX. Directly usable for regex matching / data validation.
I. Basic general units
Standard
("ppm"|"ppb"|"ppt"|"ppq"|"%"|"‰"|"‱"|"%RH")
Compatible
("ppm"|"PPM"|"ppb"|"PPB"|"ppt"|"PPT"|"ppq"|"PPQ"|"%"|"‰"|"‱"|"%RH"|"%rh"|"%%")
II. Core electrical units
1. Voltage (V)
Standard
("V"|"mV"|"μV"|"µV"|"uV"|"nV"|"pV"|"kV"|"MV"|"GV")
Compatible
("V"|"v"|"mV"|"μV"|"µV"|"uV"|"nV"|"NV"|"pV"|"PV"|"kV"|"KV"|"MV"|"GV")
2. Current (A)
Standard
("A"|"mA"|"μA"|"µA"|"uA"|"nA"|"pA"|"kA"|"MA"|"GA")
Compatible
("A"|"a"|"mA"|"μA"|"µA"|"uA"|"nA"|"NA"|"pA"|"PA"|"kA"|"KA"|"MA"|"GA")
3. Capacitance (F)
Standard
("F"|"mF"|"μF"|"µF"|"uF"|"nF"|"pF"|"kF"|"MF"|"GF")
Compatible
("F"|"f"|"mF"|"μF"|"µF"|"uF"|"nF"|"NF"|"pF"|"PF"|"kF"|"KF"|"MF"|"GF")
4. Inductance (H)
Standard
("H"|"mH"|"μH"|"µH"|"uH"|"nH"|"pH"|"kH"|"MH"|"GH")
Compatible
("H"|"h"|"mH"|"μH"|"µH"|"uH"|"nH"|"NH"|"pH"|"PH"|"kH"|"KH"|"MH"|"GH")
5. Power (W)
Standard
("W"|"mW"|"μW"|"µW"|"uW"|"nW"|"kW"|"MW"|"GW")
Compatible
("W"|"w"|"mW"|"μW"|"µW"|"uW"|"nW"|"NW"|"kW"|"KW"|"MW"|"GW")
6. Resistance (Ω/R)
Standard
("R"|"Ω"|"mΩ"|"μΩ"|"µΩ"|"uΩ"|"nΩ"|"kΩ"|"MΩ"|"GΩ")
Compatible
("R"|"r"|"Ω"|"mΩ"|"μΩ"|"µΩ"|"uΩ"|"nΩ"|"NΩ"|"kΩ"|"KΩ"|"MΩ"|"GΩ")
7. Conductance (siemens S)
Standard
("S"|"mS"|"μS"|"µS"|"uS"|"nS"|"pS"|"kS"|"MS"|"GS")
Compatible
("S"|"s"|"mS"|"μS"|"µS"|"uS"|"nS"|"NS"|"pS"|"PS"|"kS"|"KS"|"MS"|"GS")
8. Decibel (dB)
Standard
("dB"|"dBc"|"dBd"|"dBi"|"dBm"|"dBw"|"dBV"|"dBu"|"dBμV"|"dBµV"|"dBuV")
Compatible
("dB"|"db"|"DB"|"dBc"|"dBd"|"dBi"|"dBm"|"dBw"|"dBV"|"dBu"|"dBμV"|"dBµV"|"dBuV")
9. Current-to-power ratio (A/W)
Standard
("A/W"|"mA/W"|"μA/W"|"µA/W"|"uA/W"|"nA/W"|"kA/W")
Compatible
("A/W"|"a/w"|"mA/W"|"μA/W"|"µA/W"|"uA/W"|"nA/W"|"NA/W"|"kA/W"|"KA/W")
10. Battery capacity / electric charge (Ah)
Standard
("μAh"|"µAh"|"uAh"|"mAh"|"Ah"|"kAh")
Compatible
("μAh"|"µAh"|"uAh"|"mAh"|"mAH"|"mah"|"Ah"|"AH"|"ah"|"kAh"|"KAh"|"kAH")
III. Physical measurement units
1. Temperature
Standard
("℃"|"℉"|"°C"|"°F"|"K")
Compatible
("℃"|"℉"|"°C"|"°F"|"°c"|"°f"|"K"|"k")
2. Time
Standard
("s"|"ms"|"μs"|"µs"|"us"|"ns"|"ps"|"fs"|"ks"|"Ms"|"Gs")
Compatible
("s"|"S"|"ms"|"MS"|"μs"|"µs"|"us"|"ns"|"NS"|"ps"|"PS"|"fs"|"FS"|"ks"|"KS"|"Ms"|"Gs")
3. Length
Standard
("nm"|"μm"|"µm"|"um"|"mm"|"cm"|"dm"|"m"|"km"|"pm"|"fm"|"mil"|"inch"|"ft"|"yd")
Compatible
("nm"|"NM"|"μm"|"µm"|"um"|"mm"|"MM"|"cm"|"CM"|"dm"|"DM"|"m"|"M"|"km"|"KM"|"pm"|"PM"|"fm"|"FM"|"mil"|"MIL"|"inch"|"INCH"|"ft"|"FT"|"yd"|"YD")
4. Frequency (Hz)
Standard
("Hz"|"mHz"|"μHz"|"µHz"|"uHz"|"nHz"|"kHz"|"MHz"|"GHz"|"THz")
Compatible
("Hz"|"hz"|"HZ"|"mHz"|"μHz"|"µHz"|"uHz"|"nHz"|"kHz"|"KHz"|"MHz"|"GHz"|"THz")
5. Data rate (bps/Bps)
Standard
("bps"|"Bps"|"kbps"|"kBps"|"Mbps"|"MBps"|"Gbps"|"GBps"|"Tbps"|"TBps")
Compatible
("bps"|"Bps"|"kbps"|"Kbps"|"kBps"|"KBps"|"Mbps"|"MBps"|"Gbps"|"GBps"|"Tbps"|"TBps")
6. Storage / bits (b/B)
Standard
("b"|"bit"|"B"|"Byte"|"kb"|"kB"|"Mb"|"MB"|"Gb"|"GB"|"Tb"|"TB"|"Pb"|"PB"|"Eb"|"EB")
Compatible
("b"|"bit"|"B"|"Byte"|"kb"|"Kb"|"kB"|"KB"|"Mb"|"MB"|"Gb"|"GB"|"Tb"|"TB"|"Pb"|"PB"|"Eb"|"EB")
7. Sampling rate (SPS)
Standard
("SPS"|"kSPS"|"MSPS"|"GSPS"|"TSPS")
Compatible
("SPS"|"sps"|"Sps"|"kSPS"|"KSPS"|"MSPS"|"GSPS"|"TSPS")
IV. RF / microwave units
Standard
("Ω·m"|"S/m"|"λ"|"mmλ"|"dBm/mW"|"dBi/m²"|"VSWR"|"Γ"|"dB/Oct"|"dB/dec"|"ns/m"|"ps/m")
Compatible
("Ω"|"ohm"|"OHM"|"Ω·m"|"Ω·M"|"S/m"|"s/m"|"λ"|"MMλ"|"dBm/mW"|"dBi/m²"|"VSWR"|"vswr"|"Γ"|"dB/Oct"|"dB/oct"|"dB/dec"|"dB/DEC"|"ns/m"|"ps/m")
V. Magnetics units
Standard
("H/m"|"mH/m"|"μH/m"|"µH/m"|"uH/m"|"T"|"mT"|"G"|"Gs"|"Wb"|"mWb"|"μWb"|"µWb"|"uWb"|"Mx"|"kA/m"|"Oe"|"Φ")
Compatible
("H/m"|"mH/m"|"μH/m"|"µH/m"|"uH/m"|"T"|"mT"|"G"|"GS"|"Gs"|"Wb"|"mWb"|"μWb"|"µWb"|"uWb"|"Mx"|"MX"|"kA/m"|"KA/m"|"Oe"|"OE"|"Φ")
VI. Power supply design units
Standard
("mVpp"|"Vpp"|"mVrms"|"Vrms"|"Arms"|"Apeak"|"W/㎡"|"W/cm²"|"%/℃"|"ppm/℃"|"mV/℃"|"μV/℃"|"µV/℃"|"uV/℃")
Compatible
("mVpp"|"MVpp"|"Vpp"|"mVrms"|"Vrms"|"Arms"|"ARMS"|"Apeak"|"APEAK"|"W/㎡"|"w/㎡"|"W/cm²"|"w/cm²"|"%/℃"|"ppm/℃"|"mV/℃"|"MV/℃"|"μV/℃"|"µV/℃"|"uV/℃")
VII. Analog circuit / signal processing units
Standard
("V/μs"|"V/µs"|"V/us"|"V/ns"|"mA/μs"|"mA/µs"|"mA/us"|"Slew"|"dB/V"|"dB/A"|"THD"|"THD+N"|"SNR"|"ENOB"|"LSB"|"MSB"|"FS"|"FSR")
Compatible
("V/μs"|"V/µs"|"V/us"|"V/ns"|"mA/μs"|"mA/µs"|"mA/us"|"Slew"|"slew"|"dB/V"|"db/V"|"dB/A"|"db/A"|"THD"|"thd"|"THD+N"|"SNR"|"snr"|"ENOB"|"LSB"|"MSB"|"FS"|"fs"|"FSR"|"fsr")
VIII. Timing / clock / precision units
Standard
("ps"|"ps/m"|"jitter"|"skew"|"ppm"|"ppb"|"UI"|"Tj"|"Ta"|"Tc"|"Tr"|"Tf"|"Ton"|"Toff"|"Hz/℃"|"MHz/℃")
Compatible
("ps"|"PS"|"ps/m"|"PS/M"|"jitter"|"JITTER"|"skew"|"SKEW"|"ppm"|"PPM"|"ppb"|"PPB"|"UI"|"ui"|"Tj"|"TJ"|"Ta"|"TA"|"Tc"|"TC"|"Tr"|"TR"|"Tf"|"TF"|"Ton"|"TON"|"Toff"|"TOFF"|"Hz/℃"|"MHz/℃")
IX. Optics / optoelectronics design units
Standard
("lm"|"lm/W"|"cd"|"lx"|"klx"|"W/sr"|"mW/sr"|"μW/sr"|"µW/sr"|"uW/sr"|"nm"|"μm"|"µm"|"um"|"mW/㎡"|"W/μm"|"W/µm"|"W/um")
Compatible
("lm"|"LM"|"lm/W"|"LM/W"|"cd"|"CD"|"lx"|"LX"|"klx"|"KLX"|"W/sr"|"w/sr"|"mW/sr"|"μW/sr"|"µW/sr"|"uW/sr"|"nm"|"NM"|"μm"|"µm"|"um"|"mW/㎡"|"W/μm"|"W/µm"|"W/um")
X. PCB engineering / packaging units
Standard
("mil"|"inch"|"mm"|"cm"|"μm"|"µm"|"um"|"oz"|"sq.mil"|"mm²"|"cm²"|"mil²"|"kΩ/□"|"Ω/□"|"mΩ/□"|"V/mil"|"A/mil")
Compatible
("mil"|"MIL"|"inch"|"INCH"|"mm"|"MM"|"cm"|"CM"|"μm"|"µm"|"um"|"oz"|"OZ"|"sq.mil"|"SQ.MIL"|"mm²"|"MM²"|"cm²"|"CM²"|"mil²"|"MIL²"|"kΩ/□"|"KΩ/□"|"Ω/□"|"mΩ/□"|"V/mil"|"V/MIL"|"A/mil"|"A/MIL")
XI. Acoustics / EMC auxiliary units
Standard
("dB(A)"|"dB(SPL)"|"Pa"|"mPa"|"μPa"|"µPa"|"uPa"|"dBuV/m"|"dBµV/m"|"dBuV/m")
Compatible
("dB(A)"|"db(a)"|"dB(SPL)"|"db(spl)"|"Pa"|"PA"|"mPa"|"μPa"|"µPa"|"uPa"|"dBuV/m"|"dBµV/m"|"dBuV/m"|"dbuv/m")
Unified rules
Micro units: every unit with a micro magnitude keeps 3 spellings — μX (Greek mu U+03BC), µX (micro sign U+00B5), uX (letter u substitute) — covering all input scenarios;
Case compatibility: non-standard upper/lower-case variants are added only for base units and the kilo prefix; higher prefixes like M/G/T get no redundant variants, matching real engineering input habits;
Compound units: ratio units take magnitude prefixes on the numerator only, the denominator stays the base unit (e.g. mA/W, not A/mW), unified as the XX/XX format;
Industry abbreviations: common RF / analog / timing abbreviations (e.g. VSWR, SNR, THD) only get an all-lowercase variant, never split / rewritten;
Special symbols: dedicated symbols like ohm Ω, per-mille ‰, per-ten-thousand ‱ have no case variants and keep their native form.
*/