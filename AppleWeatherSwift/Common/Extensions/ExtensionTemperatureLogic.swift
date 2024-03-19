//
//  ExtensionTemperatureLogic.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 15.03.2024.
//

import Foundation

class TemperatureLogic {
    let weather: ResponseData.CurrentResponse
    
    init(weather: ResponseData.CurrentResponse) {
        self.weather = weather
    }
    
    func temperatureUnitSymbol() -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperature = Measurement(value: weather.main.temp, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
    }
}
