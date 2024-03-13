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
//        let icon = Image("TodaySun")
//        return SimpleEntry(date: Date(), temperature: 25, icon: icon, location: "Prague")
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        if let currentResponse = SharedDataSource().getCurrentResponse() {
//            let icon = Image(currentResponse.weather.first?.icon ?? "")
//            let entry = SimpleEntry(date: Date(), temperature: currentResponse.main.temp, icon: icon, location: currentResponse.name)
//            
//            completion(entry)
//        } else {
//            let icon = Image("TodaySun")
//            let entry = SimpleEntry(date: Date(), temperature: 25, icon: icon, location: "Prague")
//            completion(entry)
//        }
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
//        if let currentResponse = SharedDataSource().getCurrentResponse() {
//            let currentDate = Date()
//            let icon = Image(currentResponse.weather.first?.icon ?? "")
//            let entry = SimpleEntry(date: currentDate, temperature: currentResponse.main.temp, icon: icon, location: currentResponse.name)
//            let timeline = Timeline(entries: [entry], policy: .atEnd)
//            completion(timeline)
//        } else {
//            let currentDate = Date()
//            let icon = Image(systemName: "photo.circle.fill")
//            let entry = SimpleEntry(date: currentDate, temperature: 0, icon: icon, location: "uknow")
//            let timeline = Timeline(entries: [entry], policy: .atEnd)
//            completion(timeline)
//        }
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let temperature: Double
//    let icon: Image
//    let location: String
//}
//
//struct WeatherEntryView: View {
//    var entry: WeatherProvider.Entry
//
//    var body: some View {
//        
//        let temperatureWithUnits = self.temperatureUnitSymbol()
//        VStack(alignment: .center) {
//                
//                entry.icon
//                    .resizable()
//                    .scaledToFit()
//                    .frame(minWidth: 50, maxWidth: 50)
//            
//            Text(temperatureWithUnits)
//                .modifier(TemperatureModifier())
//            
//            Text(entry.location)
//                .modifier(ContentModifier())
//                
//            
//        }
//        .widgetBackground(backgroundView: Color.mainBackground)
//        .padding()
//    }
//    
//    func temperatureUnitSymbol() -> String {
//        let measurementFormatter = MeasurementFormatter()
//        measurementFormatter.numberFormatter.maximumFractionDigits = 0
//        
//        let temperature = Measurement(value: entry.temperature, unit: UnitTemperature.celsius)
//        return measurementFormatter.string(from: temperature)
//    }
//
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
//        .supportedFamilies([.systemSmall])
//    }
//}
//
//// Provide sample data for preview
//struct WeatherWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        let icon = Image("TodaySun")
//        WeatherEntryView(entry: SimpleEntry(date: Date(), temperature: 25.0, icon: icon, location: "Prague"))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}

import WidgetKit
import SwiftUI

struct WeatherProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let icon = Image("TodaySun")
        return SimpleEntry(date: Date(), temperature: 25, icon: icon, location: "Prague")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        if let currentResponse = SharedDataSource.shared.getCurrentResponse() {
            let icon = Image(currentResponse.weather.first?.icon ?? "")
            let entry = SimpleEntry(date: Date(), temperature: currentResponse.main.temp, icon: icon, location: currentResponse.name)
            completion(entry)
        } else {
            let icon = Image("TodaySun")
            let entry = SimpleEntry(date: Date(), temperature: 25, icon: icon, location: "Prague")
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        if let currentResponse = SharedDataSource.shared.getCurrentResponse() {
            let currentDate = Date()
            let icon = Image(currentResponse.weather.first?.icon ?? "")
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

struct SimpleEntry: TimelineEntry {
    let date: Date
    let temperature: Double
    let icon: Image
    let location: String
}

struct WeatherEntryView: View {
    var entry: WeatherProvider.Entry

    var body: some View {
        
        let temperatureWithUnits = self.temperatureUnitSymbol()
        VStack(alignment: .center) {
                
                entry.icon
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 50, maxWidth: 50)
            
            Text(temperatureWithUnits)
                .modifier(TemperatureModifier())
            
            Text(entry.location)
                .modifier(ContentModifier())
                
            
        }
        .widgetBackground(backgroundView: Color.mainBackground)
        .padding()
    }
    
    func temperatureUnitSymbol() -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperature = Measurement(value: entry.temperature, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
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
        .supportedFamilies([.systemSmall])
    }
}

// Provide sample data for preview
struct WeatherWidget_Previews: PreviewProvider {
    static var previews: some View {
        let icon = Image("TodaySun")
        WeatherEntryView(entry: SimpleEntry(date: Date(), temperature: 25.0, icon: icon, location: "Prague"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
