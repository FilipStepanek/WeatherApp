//
//  WidgetExtension .swift
//  WeatherAppWidgetsExtension
//
//  Created by Filip Štěpánek on 01.04.2024.
//

import SwiftUI
import WidgetKit

struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherProvider()) { entry in
            WeatherEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget")
        .supportedFamilies([.systemSmall])
    }
}

