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

# Sensor components
#
# Output mode is expressed by interface adoption (pin-expectation v0.3):
# the construction parameter selects WHICH interface set the sensor adopts,
# and the adopted interface carries the mode identity -- the analog variant
# adopts ADC.SINGLE as Transmitter (the sensor is the signal source; the
# @class(analog) lane default rides the adoption path), the digital variants
# adopt I2C / SPI as Slave. Expectations follow the adopted interface's
# defaults; board-side row attributes refine per pin. Bare rows are kept only
# for mode-less pins (HEATER). Former "digital" output_type value retired:
# it had no resolvable pairing identity (only the named buses do).

component SENSOR.TEMP(otype::STRING, range::STRING, acc::STRING)
{
    name = "Temperature Sensor"
    spec = [
        output_type = otype // [analog, i2c, spi]
        temperature_range = range // [-40°C to 125°C, -20°C to 85°C]
        accuracy = acc // [±0.1°C, ±0.5°C, ±1.0°C]
    ]
    if output_type == "i2c"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3,4] = BUS::I2C(Slave)
        ]
    else if output_type == "spi"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3:6] = BUS::SPI(Slave)
        ]
    else
        pins = [
            [1,3] = [VCC, GND]::DC()
            2 = AOUT::ADC.SINGLE(Transmitter)
        ]
}
component SENSOR.HUMIDITY(otype::STRING, range::STRING, acc::STRING)
{
    name = "Humidity Sensor"
    spec = [
        output_type = otype // [analog, i2c, spi]
        humidity_range = range // [0-100% RH, 10-90% RH]
        accuracy = acc // [±2%, ±3%, ±5%]
    ]
    if output_type == "i2c"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3,4] = BUS::I2C(Slave)
        ]
    else if output_type == "spi"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3:6] = BUS::SPI(Slave)
        ]
    else
        pins = [
            [1,3] = [VCC, GND]::DC()
            2 = AOUT::ADC.SINGLE(Transmitter)
        ]
}
component SENSOR.PRESSURE(otype::STRING, range::STRING, acc::STRING)
{
    name = "Pressure Sensor"
    spec = [
        output_type = otype // [analog, i2c, spi]
        pressure_range = range // [0-100kPa, 0-1MPa, 0-10MPa]
        accuracy = acc // [±0.5%, ±1%, ±2%]
    ]
    if output_type == "i2c"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3,4] = BUS::I2C(Slave)
        ]
    else if output_type == "spi"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3:6] = BUS::SPI(Slave)
        ]
    else
        pins = [
            [1,3] = [VCC, GND]::DC()
            2 = AOUT::ADC.SINGLE(Transmitter)
        ]
}
component SENSOR.LIGHT(otype::STRING, range::STRING, sens::STRING)
{
    name = "Light Sensor"
    spec = [
        output_type = otype // [analog, i2c, spi]
        spectral_range = range // [400-700nm, 380-850nm]
        sensitivity = sens // [1000mV/lux, 500mV/lux, 100mV/lux]
    ]
    if output_type == "i2c"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3,4] = BUS::I2C(Slave)
        ]
    else if output_type == "spi"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3:6] = BUS::SPI(Slave)
        ]
    else
        pins = [
            [1,3] = [VCC, GND]::DC()
            2 = AOUT::ADC.SINGLE(Transmitter)
        ]
}
component SENSOR.PROX(otype::STRING, range::STRING, rtime::UV.TIME)
{
    name = "Proximity Sensor"
    spec = [
        output_type = otype // [analog, i2c, spi]
        detection_range = range // [0-10cm, 0-50cm, 0-1m]
        response_time = rtime // [1ms, 10ms, 50ms]
    ]
    if output_type == "i2c"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3,4] = BUS::I2C(Slave)
        ]
    else if output_type == "spi"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3:6] = BUS::SPI(Slave)
        ]
    else
        pins = [
            [1,3] = [VCC, GND]::DC()
            2 = AOUT::ADC.SINGLE(Transmitter)
        ]
}
component SENSOR.MOTION(otype::STRING, range::STRING, sens::STRING)
{
    name = "Motion Sensor"
    spec = [
        output_type = otype // [analog, i2c, spi]
        detection_range = range // [0-5m, 0-10m, 0-15m]
        sensitivity = sens // [low, medium, high]
    ]
    if output_type == "i2c"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3,4] = BUS::I2C(Slave)
        ]
    else if output_type == "spi"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3:6] = BUS::SPI(Slave)
        ]
    else
        pins = [
            [1,3] = [VCC, GND]::DC()
            2 = AOUT::ADC.SINGLE(Transmitter)
        ]
}
component SENSOR.GAS(otype::STRING, gas::STRING, sens::STRING)
{
    name = "Gas Sensor"
    spec = [
        output_type = otype // [analog, i2c, spi]
        gas_type = gas // [CO, CH4, LPG, smoke, VOC]
        sensitivity = sens // [low, medium, high]
    ]
    if output_type == "i2c"
        pins = [
            [1,2] = [VCC, GND]::DC()
            3 = HEATER
            [4,5] = BUS::I2C(Slave)
        ]
    else if output_type == "spi"
        pins = [
            [1,2] = [VCC, GND]::DC()
            3 = HEATER
            [4:7] = BUS::SPI(Slave)
        ]
    else
        pins = [
            [1,4] = [VCC, GND]::DC()
            2 = HEATER
            3 = AOUT::ADC.SINGLE(Transmitter)
        ]
}
component SENSOR.ACCEL(otype::STRING, range::STRING, sens::STRING)
{
    name = "Accelerometer"
    spec = [
        output_type = otype // [analog, i2c, spi]
        measurement_range = range // [±2g, ±4g, ±8g, ±16g]
        sensitivity = sens // [1mg/LSB, 2mg/LSB, 4mg/LSB]
    ]
    if output_type == "i2c"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3,4] = BUS::I2C(Slave)
        ]
    else if output_type == "spi"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3:6] = BUS::SPI(Slave)
        ]
    else
        pins = [
            [1,5] = [VCC, GND]::DC()
            2 = AOUTX::ADC.SINGLE(Transmitter)
            3 = AOUTY::ADC.SINGLE(Transmitter)
            4 = AOUTZ::ADC.SINGLE(Transmitter)
        ]
}
component SENSOR.GYRO(otype::STRING, range::STRING, sens::STRING)
{
    name = "Gyroscope"
    spec = [
        output_type = otype // [analog, i2c, spi]
        measurement_range = range // [±250°/s, ±500°/s, ±1000°/s, ±2000°/s]
        sensitivity = sens // [1°/s/LSB, 2°/s/LSB, 4°/s/LSB]
    ]
    if output_type == "i2c"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3,4] = BUS::I2C(Slave)
        ]
    else if output_type == "spi"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3:6] = BUS::SPI(Slave)
        ]
    else
        pins = [
            [1,5] = [VCC, GND]::DC()
            2 = AOUTX::ADC.SINGLE(Transmitter)
            3 = AOUTY::ADC.SINGLE(Transmitter)
            4 = AOUTZ::ADC.SINGLE(Transmitter)
        ]
}
component SENSOR.MAG(otype::STRING, range::STRING, sens::STRING)
{
    name = "Magnetometer"
    spec = [
        output_type = otype // [analog, i2c, spi]
        measurement_range = range // [±1.3mT, ±2.5mT, ±4.7mT, ±9.5mT]
        sensitivity = sens // [0.5mT/LSB, 1mT/LSB, 2mT/LSB]
    ]
    if output_type == "i2c"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3,4] = BUS::I2C(Slave)
        ]
    else if output_type == "spi"
        pins = [
            [1,2] = [VCC, GND]::DC()
            [3:6] = BUS::SPI(Slave)
        ]
    else
        pins = [
            [1,5] = [VCC, GND]::DC()
            2 = AOUTX::ADC.SINGLE(Transmitter)
            3 = AOUTY::ADC.SINGLE(Transmitter)
            4 = AOUTZ::ADC.SINGLE(Transmitter)
        ]
}

# Usage Examples:
# SENSOR.TEMP("I2C", "-40~125C", "±0.5C") ts
# SENSOR.HUMIDITY("I2C", "0~100RH", "±2RH") rhs
# SENSOR.PRESSURE("I2C", "300~1100hPa", "±1hPa") baro
# SENSOR.ACCEL("SPI", "±2g", "0.01g") acc
# SENSOR.MAG("I2C", "±8gauss", "5mG") mag
