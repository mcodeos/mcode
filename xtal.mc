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

use ./ifs/xtal

# ---------------------------------------------------------------------------------------------
# 晶振组件
#
# cload 参数携带晶体负载电容值, 写入 spec (BOM/DRC) 并驱动 func loadcap 生成负载电容。
#
# func loadcap(gnd): 在 X1/X2 各生成一个到 gnd 的负载电容, 电容值 = cload。
#   - func 名不再要求小写开头。编译器已用「严格的大小写全名类检查」取代首字母大写启发式:
#     只有注册类 (如 CAP/RES) 才被当作类构造解析; 组件自身的标量形参同名方法
#     (如 `func Cap(gnd)`) 优先于全局内建 `.Cap` 接线 (仅 Cap 走此优先;
#     Pullup/Pulldown 仍走内建路径以保留 D7 信号桥检测);
#   - 必须用两行独立的 `[X, gnd] => CAP(cload).Cap(_)` 链 (ranged `cx[1:2].Cap(bus, gnd)`
#     只能生成一个电容);
#   - 已知编译器缺陷:
#     a) 若模块内没有任何其他匿名电容, 两个负载电容会撞同一自动名, 只生成一个;
#     b) 同一模块内有多个晶振实例时, func 内的 XTAL.X1/X2 不带实例前缀, 各实例的同名脚
#        会塌缩到同一网络 (晶振互相短路), 且电容自动命名碰撞 → 每个晶振只出一个电容。
#        多晶振场景必须用模块顶层向量电路 (方式 B)。
#
# 若需要精确控制原理图位号 (如 C8/C9), 请用模块顶层向量电路写法 —— 见文末 Usage Examples。
# ---------------------------------------------------------------------------------------------

# Basic 2-Pin Crystal Component
component XTAL2(freq::UV.HZ, cload::UV.CAP = 20pF)
{
    name = "2-Pin Crystal"
    description = "Basic 2-pin crystal oscillator"

    spec = [
        frequency = freq
        load_capacitance = cload
    ]

    pins = [
        [1,2] = XTAL{X1,X2}::XTAL() , ["Crystal oscillator input","Crystal oscillator output"]
    ]

    func Setup(gnd)
    {
        [XTAL.X1, gnd] => CAP(cload).Cap(_)
        [XTAL.X2, gnd] => CAP(cload).Cap(_)
        return XTAL{X1,X2}
    }
}

# 4-Pin Crystal Component
component XTAL4(freq::UV.HZ, cload::UV.CAP = 20pF)
{
    name = "4-Pin Crystal"
    description = "4-pin crystal oscillator with NC pins"

    spec = [
        frequency = freq
        load_capacitance = cload
    ]

    pins = [
        [1,3] = XTAL{X1,X2}::XTAL() , ["Crystal oscillator input","Crystal oscillator output"]
        2 = NC      , "No connection"
        4 = NC      , "No connection"
    ]

    func Setup(gnd)
    {
        [XTAL.X1, gnd] => CAP(cload).Cap(_)
        [XTAL.X2, gnd] => CAP(cload).Cap(_)
        return XTAL{X1,X2}
    }
}

# Oscillator Component
component OSC(freq::UV.HZ)
{
    name = "Oscillator"
    description = "Active oscillator module"

    spec = [
        frequency = freq
    ]

    pins = [
        1 = NC  , "No connection"
        2 = GND , "Ground"
        3 = XTAL , "Oscillator output"
        4 = VDD , "Power supply"
    ]
}

# Ceramic Resonator Component
component XTAL.CERAMIC(freq::UV.HZ)
{
    name = "Ceramic Resonator"
    description = "Ceramic resonator for timing applications"

    spec = [
        frequency = freq
    ]

    pins = [
        [1,2] = XTAL{X1,X2}::XTAL() , ["Resonator input","Resonator output"]
    ]
}

# Surface Mount Crystal Component
component XTAL.SMD(freq::UV.HZ, cload::UV.CAP)
{
    name = "SMD Crystal"
    description = "Surface mount crystal oscillator"

    spec = [
        frequency = freq
        load_capacitance = cload
    ]

    pins = [
        [1,2] = XTAL{X1,X2}::XTAL() , ["Crystal oscillator input","Crystal oscillator output"]
    ]

    func Setup(gnd)
    {
        [XTAL.X1, gnd] => CAP(cload).Cap(_)
        [XTAL.X2, gnd] => CAP(cload).Cap(_)
        return XTAL{X1,X2}
    }
}

# ---------------------------------------------------------------------------------------------
# Usage Examples
#
# 方式 A —— func 封装 (自动位号, 电容值取自 cload):
#    XTAL2(32.768kHz, 18pF) Y1.Setup(pwr.GND) -> MCU{XIN, XOUT}    // X1/X2 逐元素接 MCU
#    XTAL4(12MHz, 33pF)     Y2.Setup(pwr.GND) -> MCU{XIN, XOUT}    // 生成两个 33pF 负载电容到地
#
# 方式 B —— 模块顶层向量电路 (可精确指定位号 C[8:9], cload 值显式写出):
#    XTAL2(32.768kHz) Y3.XTAL -> [C[8:9]::CAP(18pF)] -> [GND, GND] // X1/X2 各接一个负载电容到地
#
# 方式 C —— 手动按脚接:
#    XTAL2(32.768kHz) Y4
#    CAP(33pF).Cap(Y4.XTAL.X1, pwr.GND)
#    CAP(33pF).Cap(Y4.XTAL.X2, pwr.GND)
#
