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
component SENSOR.TEMP(output_type::STRING, range::STRING, accuracy::STRING)
{
    name = "Temperature Sensor"
    spec = [
        output_type = output_type // [analog, digital, i2c, spi]
        temperature_range = range // [-40°C to 125°C, -20°C to 85°C]
        accuracy = accuracy // [±0.1°C, ±0.5°C, ±1.0°C]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.HUMIDITY(output_type::STRING, range::STRING, accuracy::STRING)
{
    name = "Humidity Sensor"
    spec = [
        output_type = output_type // [analog, digital, i2c, spi]
        humidity_range = range // [0-100% RH, 10-90% RH]
        accuracy = accuracy // [±2%, ±3%, ±5%]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.PRESSURE(output_type::STRING, range::STRING, accuracy::STRING)
{
    name = "Pressure Sensor"
    spec = [
        output_type = output_type // [analog, digital, i2c, spi]
        pressure_range = range // [0-100kPa, 0-1MPa, 0-10MPa]
        accuracy = accuracy // [±0.5%, ±1%, ±2%]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.LIGHT(output_type::STRING, range::STRING, sensitivity::STRING)
{
    name = "Light Sensor"
    spec = [
        output_type = output_type // [analog, digital, i2c, spi]
        spectral_range = range // [400-700nm, 380-850nm]
        sensitivity = sensitivity // [1000mV/lux, 500mV/lux, 100mV/lux]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.PROX(output_type::STRING, range::STRING, response_time::UV.TIME)
{
    name = "Proximity Sensor"
    spec = [
        output_type = output_type // [analog, digital, i2c, spi]
        detection_range = range // [0-10cm, 0-50cm, 0-1m]
        response_time = response_time // [1ms, 10ms, 50ms]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.MOTION(output_type::STRING, range::STRING, sensitivity::STRING)
{
    name = "Motion Sensor"
    spec = [
        output_type = output_type // [analog, digital, i2c, spi]
        detection_range = range // [0-5m, 0-10m, 0-15m]
        sensitivity = sensitivity // [low, medium, high]
    ]
    pins = [
        1 = VCC
        2 = OUTPUT
        3 = GND
    ]
}
component SENSOR.GAS(output_type::STRING, gas::STRING, sensitivity::STRING)
{
    name = "Gas Sensor"
    spec = [
        output_type = output_type // [analog, digital, i2c, spi]
        gas_type = gas // [CO, CH4, LPG, smoke, VOC]
        sensitivity = sensitivity // [low, medium, high]
    ]
    pins = [
        1 = VCC
        2 = HEATER
        3 = OUTPUT
        4 = GND
    ]
}
component SENSOR.ACCEL(output_type::STRING, range::STRING, sensitivity::STRING)
{
    name = "Accelerometer"
    spec = [
        output_type = output_type // [analog, digital, i2c, spi]
        measurement_range = range // [±2g, ±4g, ±8g, ±16g]
        sensitivity = sensitivity // [1mg/LSB, 2mg/LSB, 4mg/LSB]
    ]
    pins = [
        1 = VCC
        2 = X_OUT
        3 = Y_OUT
        4 = Z_OUT
        5 = GND
    ]
}
component SENSOR.GYRO(output_type::STRING, range::STRING, sensitivity::STRING)
{
    name = "Gyroscope"
    spec = [
        output_type = output_type // [analog, digital, i2c, spi]
        measurement_range = range // [±250°/s, ±500°/s, ±1000°/s, ±2000°/s]
        sensitivity = sensitivity // [1°/s/LSB, 2°/s/LSB, 4°/s/LSB]
    ]
    pins = [
        1 = VCC
        2 = X_OUT
        3 = Y_OUT
        4 = Z_OUT
        5 = GND
    ]
}
component SENSOR.MAG(output_type::STRING, range::STRING, sensitivity::STRING)
{
    name = "Magnetometer"
    spec = [
        output_type = output_type // [analog, digital, i2c, spi]
        measurement_range = range // [±1.3mT, ±2.5mT, ±4.7mT, ±9.5mT]
        sensitivity = sensitivity // [0.5mT/LSB, 1mT/LSB, 2mT/LSB]
    ]
    pins = [
        1 = VCC
        2 = X_OUT
        3 = Y_OUT
        4 = Z_OUT
        5 = GND
    ]
}