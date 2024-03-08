//
//  WeatherAppWidgets.swift
//  WeatherAppWidgets
//
//  Created by Filip Štěpánek on 18.02.2024.
//

//import WidgetKit
//import SwiftUI
//
//struct WeatherProvider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), temperature: 25) // Provide default placeholder data
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        if let currentResponse = SharedDataSource().getCurrentResponse() {
//            let entry = SimpleEntry(date: Date(), temperature: currentResponse.main.temp)
//            completion(entry)
//        } else {
//            let entry = SimpleEntry(date: Date(), temperature: 25) // Provide default snapshot data
//            completion(entry)
//        }
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
//        if let currentResponse = SharedDataSource().getCurrentResponse() {
//            // Use currentResponse data to generate timeline entries
//            let currentDate = Date()
//            let entry = SimpleEntry(date: currentDate, temperature: currentResponse.main.temp)
//            let timeline = Timeline(entries: [entry], policy: .atEnd)
//            completion(timeline)
//        } else {
//            // If data is not available, provide default timeline entries
//            let currentDate = Date()
//            let entry = SimpleEntry(date: currentDate, temperature: 0)
//            let timeline = Timeline(entries: [entry], policy: .atEnd)
//            completion(timeline)
//        }
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let temperature: Double // Temperature should be of type Double
//}
//
//struct WeatherEntryView: View {
//    var entry: WeatherProvider.Entry
//
//    var body: some View {
//        VStack {
//            Text("Current Weather")
//            Text("Temperature: \(entry.temperature.roundDouble())°C")
//                .fixedSize()
//                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//        }
//        .widgetBackground(backgroundView: Color.black)
//        .padding()
//    }
//}
//
//extension View {
//    func widgetBackground<Background: View>(backgroundView: Background) -> some View {
//        if #available(iOSApplicationExtension 17.0, *) {
//            return self.containerBackground(for: .widget) {
//                backgroundView
//            }
//        } else {
//            return self.background(backgroundView)
//        }
//    }
//}
//
//struct WidgetExtension: Widget {
//    let kind: String = "WidgetExtension"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: WeatherProvider()) { entry in
//            WeatherEntryView(entry: entry)
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget")
//        .supportedFamilies([.systemSmall, .systemMedium])
////        .environmentObject(SharedDataSource()) // Inject SharedDataSource here
//    }
//}
//
//// Provide sample data for preview
//struct WeatherWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherEntryView(entry: SimpleEntry(date: Date(), temperature: 25.0))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}

import WidgetKit
import SwiftUI

struct WeatherProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), temperature: 25) // Provide default placeholder data
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.stepanek.weatherapp")!
        let weatherManager = WeatherManager(userDefaults: userDefaults)
        
        if let currentResponse = weatherManager.retrieveWeatherData() {
            let entry = SimpleEntry(date: Date(), temperature: currentResponse.main.temp)
            completion(entry)
        } else {
            let entry = SimpleEntry(date: Date(), temperature: 25) // Provide default snapshot data
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let userDefaults = UserDefaults(suiteName: "group.stepanek.weatherapp")!
        let weatherManager = WeatherManager(userDefaults: userDefaults)
        
        if let currentResponse = weatherManager.retrieveWeatherData() {
            // Use currentResponse data to generate timeline entries
            let currentDate = Date()
            let entry = SimpleEntry(date: currentDate, temperature: currentResponse.main.temp)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        } else {
            // If data is not available, provide default timeline entries
            let currentDate = Date()
            let entry = SimpleEntry(date: currentDate, temperature: 0)
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let temperature: Double // Temperature should be of type Double
}

struct WeatherEntryView: View {
    var entry: WeatherProvider.Entry

    var body: some View {
        VStack {
            Text("Current Weather")
            Text("Temperature: \(entry.temperature.rounded())°C") // Use rounded() to round the temperature
                .fixedSize()
                .foregroundColor(.blue)
        }
        .widgetBackground(backgroundView: Color.black)
        .padding()
    }
}

extension View {
    func widgetBackground<Background: View>(backgroundView: Background) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return self.containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return self.background(backgroundView)
        }
    }
}

struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherProvider()) { entry in
            WeatherEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// Provide sample data for preview
struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherEntryView(entry: SimpleEntry(date: Date(), temperature: 25.0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
