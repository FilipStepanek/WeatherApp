//
//  ForecastDetailView.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 13.02.2024.
//

import SwiftUI

struct ForecastDetailView: View {
    
    var weather: ForecastResponse.ListResponse
    
    
    var body: some View {
        
        let temperature = Int(weather.main.temp.rounded())
        let temperatureWithUnits = "\(temperatureUnitSymbol())"
        
        HStack(
            spacing: 6
            
        ) {
            ZStack {
                
                Circle()
                    .frame(maxWidth: 35, maxHeight: 35)
                    .cornerRadius(35)
                    .foregroundColor(.iconBase)
                Image(WeatherManagerExtension().getImageNameForForecastIcon(icon: weather.weather.first?.icon ?? ""))
                    .imageSize()
                
            }
            .padding(.leading, 5)
            .padding(.vertical, 6)
            
            VStack(
                alignment: .leading
                
            ) {
                
                
                Text(Date.formatUnixTimestampInGMT(weather.date))
                    .modifier(ContentMediumModifier())
                
                Text(WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: weather.weather.first?.icon ?? ""))
                    .modifier(MediumModifier())
            }
            
            Spacer()
            
            Text(temperatureWithUnits)
                .modifier(HeadlineThreeModifier())
            
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(.row)
        .cornerRadius(16)
    }
    func temperatureUnitSymbol() -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperature = Measurement(value: weather.main.temp, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
    }
}

struct ForecastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDetailView(weather: previewForecast.list.first ?? .init(date: 1702749600, main: .init(temp: 0), weather: []))
    }
}

