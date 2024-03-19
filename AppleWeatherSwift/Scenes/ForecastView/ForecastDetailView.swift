//
//  ForecastDetailView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 28.11.2023.
//

import SwiftUI

struct ForecastDetailView: View {
    
    let weather: ResponseData.ForecastResponse.ListResponse
    
    var body: some View {
        
        let temperatureWithUnits = "\(temperatureUnitSymbol())"
        
        HStack(
            spacing: 17
            
        ) {
            ZStack {
                
                Circle()
                    .frame(maxWidth: 48, maxHeight: 48)
                    .cornerRadius(48)
                    .foregroundColor(.iconBase)
                Image(WeatherManagerExtension().getImageNameFromForecastIcon(icon: weather.weather.first?.icon ?? ""))
                    .imageSize()
                
            }
            .padding(.leading, 16)
            
            VStack(
                alignment: .leading
                
            ) {
                Text(Date.formatUnixTimestampInGMT(weather.date))
                    .modifier(ContentMediumModifier())
                
                Text(WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: weather.weather.first?.icon ?? ""))
                    .modifier(ContentSmallInfoModifier())
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
