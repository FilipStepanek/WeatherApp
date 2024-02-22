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


// MARK: - Extension for TodayDetailInfo view
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
            .frame(maxWidth: 28.8, maxHeight: 28.8)
            .aspectRatio(contentMode: .fit)
    }
}

// MARK: - Extension for ForecastDetailView Apple Watch
extension Image {
    func imageSizeWatch() -> some View {
        self
            .resizable()
            .frame(maxWidth: 20, maxHeight: 20)
            .aspectRatio(contentMode: .fit)
    }
}
