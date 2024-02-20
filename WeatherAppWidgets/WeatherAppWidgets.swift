//
//  WeatherAppWidgets.swift
//  WeatherAppWidgets
//
//  Created by Filip Štěpánek on 18.02.2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var enteries: [SimpleEntry] = []
    }
    
    func timeline(in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
//    let configuration: ConfigurationAppIntent
}

struct WeatherAppWidgetsEntryView: View {
    @Environment(\.widgetFamily) var widgetFamily
    
    var weather: CurrentResponse
//    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
        case .accessoryCircular:
            VStack {
                temperatureInfo
                    .containerBackground(for: .widget) {
                        Color.white
                    }
            }
            .gaugeStyle(.accessoryCircular)
        case .accessoryRectangular:
            HStack {
                Text(WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: weather.weather.first?.icon ?? ""))
                    .font(.headline)
                
                temperatureInfo
            }
            .padding(.trailing)
            .containerBackground(for: .widget) {
                Color.white
            }
            
        default:
        Text("Not implemented")
        }
        
    }
    
    @ViewBuilder
    var temperatureInfo: some View {
        
        let temperatureWithUnits = "\(temperatureUnitSymbol())"
        
        Text(temperatureWithUnits)
            .font(.headline)
            .padding(.vertical, 4)
    }
    
    func temperatureUnitSymbol() -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperature = Measurement(value: weather.main.temp, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
    }
    
    
}

struct WeatherAppWidgets: Widget {
    let kind: String = "WeatherAppWidgets"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherAppWidgetsEntryView(weather: previewWeather)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Widgets")
        .description("This is my example widget.")
        .supportedFamilies([.accessoryInline, .accessoryCircular, .accessoryRectangular])
    }
}

struct WeatherAppWidgets_Previews: PreviewProvider {
    static var previews: some View {
        WeatherAppWidgetsEntryView(weather: previewWeather)
            .previewContext(WidgetPreviewContext(family: .accessoryCircular))
            .previewDisplayName("Circular")
        
        WeatherAppWidgetsEntryView(weather: previewWeather)
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
            .previewDisplayName("Rectangular")

    }
}
