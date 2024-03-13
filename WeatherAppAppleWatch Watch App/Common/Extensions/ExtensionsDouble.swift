//
//  Extensions.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 15.02.2024.
//

import Foundation
import SwiftUI

// MARK: - Extension for rounded Double to 0 decimals
extension Double {
    func roundDouble() -> String {
        String(format: "%.0f", self)
    }
    
    // MARK: - Extension for m/s to km/h
    func metersPerSecondToKilometersPerHour() -> Double {
        self * 3.6
    }
    
    // MARK: - Extension for date format
    func kelvinToCelsius() -> Double {
        self - 273.15
    }
}
