//
//  Extension.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 04.12.2023.
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
