# Copyright (c) 2026 MCode. Built with MCode Bench(TM).
# Licensed under the Apache License, Version 2.0.

// SENSOR container: the measurement-family contract. output_type is the
// require face (it selects which interface set the class pins adopt); the
// per-population range, accuracy and sensitivity faces are options. Datasheet
// evidence (6-sheet sample: LM75B / HDC1080 / BME280 / MPU6050 / ADXL345 /
// DS18B20): the heads are full words/phrases (Accuracy / Sensitivity /
// Response Time / Operating range); the HDC1080 sheet spells the symbols
// RHACC (accuracy) and RHRT (response time) - the only witnessed symbol
// faces. Range bounds ride single start-end columns (the range face, 305).
// Terminal faces stay on the classes (conditional pins per output mode).

recipe ANCH.SENSOR {
    require = [
        interface = [
            output_type = Words, desc: "output mode identity (analog / i2c / spi; the class-conditional pins face selects the interface set by this value)"
        ]
    ]
    option = [
        measurement = [
            temperature_range = Words, desc: "measurable temperature span (sheet head Operating Temperature Range - full phrase)"
            humidity_range    = Words, desc: "measurable relative-humidity span (BME280 witness: one Operating range line folds humidity into the range)"
            pressure_range    = Words, desc: "measurable pressure span (BMP280 witness: Pressure range bullet)"
            spectral_range    = Words, desc: "spectral response span (light population)"
            detection_range   = Words, desc: "detection distance span (proximity / motion populations; no corpus witness - model face)"
            measurement_range = Words, desc: "full-scale span (sheet head Measurement Range / Full-Scale Range on IMU sheets)"
            gas_type          = Words, desc: "target gas identity (gas population; no MQ-class sheet in the corpus - model face)"
            accuracy          = Words, alias: [RHACC], desc: "measurement accuracy at the stated span (sheet head Accuracy; HDC1080 spells the symbol RHACC)"
            sensitivity       = Words, desc: "sensitivity at the stated span (sheet head Sensitivity, per-axis classes on IMU sheets)"
            response_time     = Time, alias: [RHRT], desc: "response / conversion time (sheet head Response Time; HDC1080 spells the symbol RHRT, DS18B20 a Conversion Time row)"
        ]
    ]
}

// Sensor output mode is expressed by interface adoption: the construction
// parameter (otype) selects WHICH interface set the sensor adopts, and the
// adopted interface carries the mode identity. The analog variant adopts
// ADC.SINGLE as Transmitter (the sensor is the signal source); the digital
// variants adopt I2C / SPI as Slave. Expectations follow the adopted
// interface's defaults; board-side row attributes refine per pin. Bare rows
// are kept only for mode-less pins (HEATER).

// SENSOR.TEMP - Temperature Sensor Component Definition
// Core Rule: measures ambient temperature over the specified range and
// accuracy; output mode set by interface adoption.

general component SENSOR.TEMP(otype::STRING, range::STRING, acc::STRING) :: ANCH.SENSOR {
    name = "Temperature Sensor"
    spec += [
        output_type       = otype  // [analog, i2c, spi]
        temperature_range = range  // [-40°C to 125°C, -20°C to 85°C]
        accuracy          = acc    // [±0.1°C, ±0.5°C, ±1.0°C]
    ]
    if output_type == "i2c"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3, 4] = BUS::I2C(SLAVE)
    ]
    else if output_type == "spi"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3:6]  = BUS::SPI(SLAVE)
    ]
    else

        pins   = [
        [1, 3] = [VCC, GND]::DC()
        2      = AOUT::ADC.SINGLE(TRANSMITTER)
    ]
}

// SENSOR.HUMIDITY - Humidity Sensor Component Definition
// Core Rule: measures relative humidity over the specified range and
// accuracy; output mode set by interface adoption.

general component SENSOR.HUMIDITY(otype::STRING, range::STRING, acc::STRING) :: ANCH.SENSOR {
    name = "Humidity Sensor"
    spec += [
        output_type    = otype  // [analog, i2c, spi]
        humidity_range = range  // [0-100% RH, 10-90% RH]
        accuracy       = acc    // [±2%, ±3%, ±5%]
    ]
    if output_type == "i2c"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3, 4] = BUS::I2C(SLAVE)
    ]
    else if output_type == "spi"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3:6]  = BUS::SPI(SLAVE)
    ]
    else

        pins   = [
        [1, 3] = [VCC, GND]::DC()
        2      = AOUT::ADC.SINGLE(TRANSMITTER)
    ]
}

// SENSOR.PRESSURE - Pressure Sensor Component Definition
// Core Rule: measures absolute or gauge pressure over the specified range
// and accuracy; output mode set by interface adoption.

general component SENSOR.PRESSURE(otype::STRING, range::STRING, acc::STRING) :: ANCH.SENSOR {
    name = "Pressure Sensor"
    spec += [
        output_type    = otype  // [analog, i2c, spi]
        pressure_range = range  // [0-100kPa, 0-1MPa, 0-10MPa]
        accuracy       = acc    // [±0.5%, ±1%, ±2%]
    ]
    if output_type == "i2c"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3, 4] = BUS::I2C(SLAVE)
    ]
    else if output_type == "spi"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3:6]  = BUS::SPI(SLAVE)
    ]
    else

        pins   = [
        [1, 3] = [VCC, GND]::DC()
        2      = AOUT::ADC.SINGLE(TRANSMITTER)
    ]
}

// SENSOR.LIGHT - Ambient Light Sensor Component Definition
// Core Rule: measures illuminance over the specified spectral range with the
// given sensitivity; output mode set by interface adoption.

general component SENSOR.LIGHT(otype::STRING, range::STRING, sens::STRING) :: ANCH.SENSOR {
    name = "Light Sensor"
    spec += [
        output_type    = otype  // [analog, i2c, spi]
        spectral_range = range  // [400-700nm, 380-850nm]
        sensitivity    = sens   // [1000mV/lux, 500mV/lux, 100mV/lux]
    ]
    if output_type == "i2c"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3, 4] = BUS::I2C(SLAVE)
    ]
    else if output_type == "spi"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3:6]  = BUS::SPI(SLAVE)
    ]
    else

        pins   = [
        [1, 3] = [VCC, GND]::DC()
        2      = AOUT::ADC.SINGLE(TRANSMITTER)
    ]
}

// SENSOR.PROX - Proximity Sensor Component Definition
// Core Rule: detects target presence within the detection range, with the
// given response time; output mode set by interface adoption.

general component SENSOR.PROX(otype::STRING, range::STRING, rtime::UV.TIME) :: ANCH.SENSOR {
    name = "Proximity Sensor"
    spec += [
        output_type     = otype  // [analog, i2c, spi]
        detection_range = range  // [0-10cm, 0-50cm, 0-1m]
        response_time   = rtime  // [1ms, 10ms, 50ms]
    ]
    if output_type == "i2c"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3, 4] = BUS::I2C(SLAVE)
    ]
    else if output_type == "spi"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3:6]  = BUS::SPI(SLAVE)
    ]
    else

        pins   = [
        [1, 3] = [VCC, GND]::DC()
        2      = AOUT::ADC.SINGLE(TRANSMITTER)
    ]
}

// SENSOR.MOTION - Motion Sensor Component Definition
// Core Rule: detects movement within the detection range at the given
// sensitivity; output mode set by interface adoption.

general component SENSOR.MOTION(otype::STRING, range::STRING, sens::STRING) :: ANCH.SENSOR {
    name = "Motion Sensor"
    spec += [
        output_type     = otype  // [analog, i2c, spi]
        detection_range = range  // [0-5m, 0-10m, 0-15m]
        sensitivity     = sens   // [low, medium, high]
    ]
    if output_type == "i2c"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3, 4] = BUS::I2C(SLAVE)
    ]
    else if output_type == "spi"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3:6]  = BUS::SPI(SLAVE)
    ]
    else

        pins   = [
        [1, 3] = [VCC, GND]::DC()
        2      = AOUT::ADC.SINGLE(TRANSMITTER)
    ]
}

// SENSOR.GAS - Gas Sensor Component Definition
// Core Rule: detects the target gas at the given sensitivity; the sensing
// element needs a heater supply, so a HEATER pin exists in every mode.

general component SENSOR.GAS(otype::STRING, gas::STRING, sens::STRING) :: ANCH.SENSOR {
    name = "Gas Sensor"
    spec += [
        output_type = otype  // [analog, i2c, spi]
        gas_type    = gas    // [CO, CH4, LPG, smoke, VOC]
        sensitivity = sens   // [low, medium, high]
    ]
    if output_type == "i2c"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        3      = HEATER
        [4, 5] = BUS::I2C(SLAVE)
    ]
    else if output_type == "spi"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        3      = HEATER
        [4:7]  = BUS::SPI(SLAVE)
    ]
    else

        pins   = [
        [1, 4] = [VCC, GND]::DC()
        2      = HEATER
        3      = AOUT::ADC.SINGLE(TRANSMITTER)
    ]
}

// SENSOR.ACCEL - Accelerometer Component Definition
// Core Rule: measures acceleration over the specified range with the given
// sensitivity; analog mode exposes X/Y/Z outputs separately.

general component SENSOR.ACCEL(otype::STRING, range::STRING, sens::STRING) :: ANCH.SENSOR {
    name = "Accelerometer"
    spec += [
        output_type       = otype  // [analog, i2c, spi]
        measurement_range = range  // [±2g, ±4g, ±8g, ±16g]
        sensitivity       = sens   // [1mg/LSB, 2mg/LSB, 4mg/LSB]
    ]
    if output_type == "i2c"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3, 4] = BUS::I2C(SLAVE)
    ]
    else if output_type == "spi"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3:6]  = BUS::SPI(SLAVE)
    ]
    else

        pins   = [
        [1, 5] = [VCC, GND]::DC()
        2      = AOUTX::ADC.SINGLE(TRANSMITTER)
        3      = AOUTY::ADC.SINGLE(TRANSMITTER)
        4      = AOUTZ::ADC.SINGLE(TRANSMITTER)
    ]
}

// SENSOR.GYRO - Gyroscope Component Definition
// Core Rule: measures angular rate over the specified range with the given
// sensitivity; analog mode exposes X/Y/Z outputs separately.

general component SENSOR.GYRO(otype::STRING, range::STRING, sens::STRING) :: ANCH.SENSOR {
    name = "Gyroscope"
    spec += [
        output_type       = otype  // [analog, i2c, spi]
        measurement_range = range  // [±250°/s, ±500°/s, ±1000°/s, ±2000°/s]
        sensitivity       = sens   // [1°/s/LSB, 2°/s/LSB, 4°/s/LSB]
    ]
    if output_type == "i2c"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3, 4] = BUS::I2C(SLAVE)
    ]
    else if output_type == "spi"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3:6]  = BUS::SPI(SLAVE)
    ]
    else

        pins   = [
        [1, 5] = [VCC, GND]::DC()
        2      = AOUTX::ADC.SINGLE(TRANSMITTER)
        3      = AOUTY::ADC.SINGLE(TRANSMITTER)
        4      = AOUTZ::ADC.SINGLE(TRANSMITTER)
    ]
}

// SENSOR.MAG - Magnetometer Component Definition
// Core Rule: measures magnetic field over the specified range with the given
// sensitivity; analog mode exposes X/Y/Z outputs separately.

general component SENSOR.MAG(otype::STRING, range::STRING, sens::STRING) :: ANCH.SENSOR {
    name = "Magnetometer"
    spec += [
        output_type       = otype  // [analog, i2c, spi]
        measurement_range = range  // [±1.3mT, ±2.5mT, ±4.7mT, ±9.5mT]
        sensitivity       = sens   // [0.5mT/LSB, 1mT/LSB, 2mT/LSB]
    ]
    if output_type == "i2c"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3, 4] = BUS::I2C(SLAVE)
    ]
    else if output_type == "spi"

        pins   = [
        [1, 2] = [VCC, GND]::DC()
        [3:6]  = BUS::SPI(SLAVE)
    ]
    else

        pins   = [
        [1, 5] = [VCC, GND]::DC()
        2      = AOUTX::ADC.SINGLE(TRANSMITTER)
        3      = AOUTY::ADC.SINGLE(TRANSMITTER)
        4      = AOUTZ::ADC.SINGLE(TRANSMITTER)
    ]
}

// Usage Examples:
// SENSOR.TEMP("I2C", "-40~125C", "±0.5C") ts
// SENSOR.HUMIDITY("I2C", "0~100RH", "±2RH") rhs
// SENSOR.PRESSURE("I2C", "300~1100hPa", "±1hPa") baro
// SENSOR.ACCEL("SPI", "±2g", "0.01g") acc
// SENSOR.MAG("I2C", "±8gauss", "5mG") mag
