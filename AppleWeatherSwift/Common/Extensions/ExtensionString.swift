//
//  ExtensionString.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 13.03.2024.
//

import Foundation
import SwiftUI

// MARK: - Extension country code to full name
extension String {
    func countryName(countryCode: String) -> String? {
        let current = Locale.current
        let countryName = current.localizedString(forRegionCode: countryCode)
        return countryName
    }
}

// ?????
extension Locale {
    func countryName(countryCode: String) -> String? {
        localizedString(forRegionCode: countryCode)
    }
}

