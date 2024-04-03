//
//  WeatherProvider.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.04.2024.
//

import WidgetKit
import SwiftUI

struct WeatherProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        .placeholder
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        if let currentResponse = SharedDataSource.shared.getCurrentResponse() {
            let widgetExtension = weatherManagerExtensionWidget()
            let icon = Image(widgetExtension.getImageNameFromWeatherIcon(icon: currentResponse.weather.first?.icon ?? ""))
            let entry = SimpleEntry(date: Date(), temperature: currentResponse.main.temp, icon: icon, location: currentResponse.name)
            completion(entry)
        } else {
            let icon = Image("todaySun")
            let entry = SimpleEntry(date: Date(), temperature: 25, icon: icon, location: "Prague")
            completion(entry)
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        if let currentResponse = SharedDataSource.shared.getCurrentResponse() {
            let currentDate = Date()
            let widgetExtension = weatherManagerExtensionWidget()
            let icon = Image(widgetExtension.getImageNameFromWeatherIcon(icon: currentResponse.weather.first?.icon ?? ""))
            let entry = SimpleEntry(date: currentDate, temperature: currentResponse.main.temp, icon: icon, location: currentResponse.name)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        } else {
            let currentDate = Date()
            let icon = Image(systemName: "photo.circle.fill")
            let entry = SimpleEntry(date: currentDate, temperature: 0, icon: icon, location: "uknow")
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}
