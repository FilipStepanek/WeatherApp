//
//  ExtensionDate.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 13.03.2024.
//

import Foundation
import SwiftUI

// MARK: - Extension for date format
extension Date {
    static func formatUnixTimestampInGMT(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        
        return dateFormatter.string(from: date)
    }

// MARK: - Extension for time format
    func adjusting(byHours hours: TimeInterval) -> Date {
        addingTimeInterval(3600 * hours)
    }
}
