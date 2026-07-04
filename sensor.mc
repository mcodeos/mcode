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
component SENSOR.TEMP()
{
    name = "Temperature Sensor"
    spec = [
        output_type = _ // [analog, digital, i2c, spi]
        temperature_range = _ // [-40°C to 125°C, -20°C to 85°C]
        accuracy = _ // [±0.1°C, ±0.5°C, ±1.0°C]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.HUMIDITY()
{
    name = "Humidity Sensor"
    spec = [
        output_type = _ // [analog, digital, i2c, spi]
        humidity_range = _ // [0-100% RH, 10-90% RH]
        accuracy = _ // [±2%, ±3%, ±5%]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.PRESSURE()
{
    name = "Pressure Sensor"
    spec = [
        output_type = _ // [analog, digital, i2c, spi]
        pressure_range = _ // [0-100kPa, 0-1MPa, 0-10MPa]
        accuracy = _ // [±0.5%, ±1%, ±2%]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.LIGHT()
{
    name = "Light Sensor"
    spec = [
        output_type = _ // [analog, digital, i2c, spi]
        spectral_range = _ // [400-700nm, 380-850nm]
        sensitivity = _ // [1000mV/lux, 500mV/lux, 100mV/lux]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.PROX()
{
    name = "Proximity Sensor"
    spec = [
        output_type = _ // [analog, digital, i2c, spi]
        detection_range = _ // [0-10cm, 0-50cm, 0-1m]
        response_time = _ // [1ms, 10ms, 50ms]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.MOTION()
{
    name = "Motion Sensor"
    spec = [
        output_type = _ // [analog, digital, i2c, spi]
        detection_range = _ // [0-5m, 0-10m, 0-15m]
        sensitivity = _ // [low, medium, high]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.GAS()
{
    name = "Gas Sensor"
    spec = [
        output_type = _ // [analog, digital, i2c, spi]
        gas_type = _ // [CO, CH4, LPG, smoke, VOC]
        sensitivity = _ // [low, medium, high]
    ]
    pins = [
        1 = VCC
        2 = HEATER
        3 = OUTPUT
        4 = GND
    ]
}
component SENSOR.ACCEL()
{
    name = "Accelerometer"
    spec = [
        output_type = _ // [analog, digital, i2c, spi]
        measurement_range = _ // [±2g, ±4g, ±8g, ±16g]
        sensitivity = _ // [1mg/LSB, 2mg/LSB, 4mg/LSB]
    ]
    pins = [
        1 = VCC
        2 = X_OUT
        3 = Y_OUT
        4 = Z_OUT
        5 = GND
    ]
}
component SENSOR.GYRO()
{
    name = "Gyroscope"
    spec = [
        output_type = _ // [analog, digital, i2c, spi]
        measurement_range = _ // [±250°/s, ±500°/s, ±1000°/s, ±2000°/s]
        sensitivity = _ // [1°/s/LSB, 2°/s/LSB, 4°/s/LSB]
    ]
    pins = [
        1 = VCC
        2 = X_OUT
        3 = Y_OUT
        4 = Z_OUT
        5 = GND
    ]
}
component SENSOR.MAG()
{
    name = "Magnetometer"
    spec = [
        output_type = _ // [analog, digital, i2c, spi]
        measurement_range = _ // [±1.3mT, ±2.5mT, ±4.7mT, ±9.5mT]
        sensitivity = _ // [0.5mT/LSB, 1mT/LSB, 2mT/LSB]
    ]
    pins = [
        1 = VCC
        2 = X_OUT
        3 = Y_OUT
        4 = Z_OUT
        5 = GND
    ]
}