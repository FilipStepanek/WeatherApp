//
//  Extensions.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 27.02.2024.
//

import Foundation

// MARK: - Extension for rounded Double to 0 decimals
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
