//
//  ExtensionTemperatureLogic.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 15.03.2024.
//

import Foundation
import Shared 

class TemperatureLogic {
    let weather: CurrentResponse
    
    init(weather: CurrentResponse) {
        self.weather = weather
    }
    
    func temperatureUnitSymbol() -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperature = Measurement(value: weather.main.temp, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
    }
}
