//
//  WeatherAppWidgetsView.swift
//  WeatherAppWidgets
//
//  Created by Filip Štěpánek on 18.02.2024.
//

import WidgetKit
import SwiftUI

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
