//
//  SimpleEntry.swift
//  WeatherAppWidgetsExtension
//
//  Created by Filip Štěpánek on 01.04.2024.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let temperature: Double
    let icon: Image
    let location: String
}
