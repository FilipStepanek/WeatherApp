//
//  ForecastDetailView.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 13.02.2024.
//

import SwiftUI

struct ForecastDetailView: View {
    
    let weather: ForecastResponse.ListResponse
    
    var body: some View {
    
        let temperatureWithUnits = "\(temperatureUnitSymbol())"
        
        HStack(
            spacing: 6
            
        ) {
            ZStack {
                
                Circle()
                    .frame(maxWidth: 35, maxHeight: 35)
                    .cornerRadius(35)
                    .foregroundColor(.iconBase)
                Image(WeatherManagerExtension().getImageNameFromForecastIcon(icon: weather.weather.first?.icon ?? ""))
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

#if DEBUG
#Preview {
        let mockListResponse = ForecastResponse.ListResponse(date: 1702749600, main: ForecastResponse.MainResponseForecast(temp: 0), weather: [])
        let mockForecastResponse = ForecastResponse(city: ForecastResponse.CoordinatesResp(coord: ForecastResponse.Coordinates(lon: 0, lat: 0)), list: [mockListResponse])
        
        return ForecastDetailView(weather: mockForecastResponse.list.first ?? mockListResponse)
    }
#endif
