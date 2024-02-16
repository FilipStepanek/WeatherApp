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
        return String(format: "%.0f", self)
    }
}

// MARK: - Extension for m/s to km/h
extension Double {
    func metersPerSecondToKilometersPerHour() -> Double {
        return self * 3.6
    }
}

// MARK: - Extension country code to full name
func countryName(countryCode: String) -> String? {
    let current = Locale(identifier: "en_US")
    return current.localizedString(forRegionCode: countryCode)
}

// MARK: - Extension for date format
extension Date {
    static func formatUnixTimestampInGMT(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        
        return dateFormatter.string(from: date)
    }
}

// MARK: - Extension for date format
extension Double {
    func kelvinToCelsius() -> Double {
        return self - 273.15
    }
}

// MARK: - Extension for time format
extension Date {
    func adjusting(byHours hours: TimeInterval) -> Date {
        return addingTimeInterval(3600 * hours)
    }
}


// MARK: - Extension for TodayDetailInfoview
extension Image {
    func imageFrameShape() -> some View {
        self
            .frame(width: 40, height: 40)
            .background(.todayImageSpahe)
            .cornerRadius(40)
    }
}

// MARK: - Extension for ForecastDetailView
extension Image {
    func imageSize() -> some View {
        self
            .resizable()
            .frame(maxWidth: 20, maxHeight: 20)
            .aspectRatio(contentMode: .fit)
    }
}
