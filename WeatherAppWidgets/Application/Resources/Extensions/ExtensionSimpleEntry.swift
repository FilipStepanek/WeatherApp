//
//  ExtensionSimpleEntry.swift
//  WeatherAppWidgetsExtension
//
//  Created by Filip Štěpánek on 01.04.2024.
//

import SwiftUI
import WidgetKit

//MARK: - Extension for ModelData
extension SimpleEntry {
    static let placeholder = SimpleEntry(
        date: .now,
        temperature: 10,
        icon: Image(.todaySun),
        location: "Prague"
    )

//MARK: - Extension for getSnapshot
    static let getSnapshot = SimpleEntry(
        date: Date(),
        temperature: 0,
        icon: Image(systemName: "photo.circle.fill"),
        location: "Unknown"
    )
}
