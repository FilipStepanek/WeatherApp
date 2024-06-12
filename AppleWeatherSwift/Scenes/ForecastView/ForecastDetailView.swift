//
//  ForecastDetailView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 28.11.2023.
//

import SwiftUI
import Shared 

protocol WeatherData {
    var temperature: Double { get }
    var icon: String { get }
    var weatherInfo: String { get }
    var dateInfo: String { get }
}

extension ForecastResponse.ListResponse: WeatherData {
    var temperature: Double {
        return main.temp
    }
    
    var icon: String {
        return weather.first?.icon ?? ""
    }
    
    var weatherInfo: String {
        return WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: icon)
    }
    
    var dateInfo: String {
        return Date.formatUnixTimestampInGMT(self.date)
    }
}

extension CurrentResponse: WeatherData {
    var temperature: Double {
        return main.temp
    }
    
    var icon: String {
        return weather.first?.icon ?? ""
    }
    
    var weatherInfo: String {
        return WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: icon)
    }
    
    var dateInfo: String {
        return "Now"
    }
}

struct ForecastDetailView: View {
    let weatherData: WeatherData
    
    var body: some View {
        
        let temperatureWithUnits = "\(temperatureUnitSymbol())"
        
        HStack(spacing: 17) {
            ZStack {
                Circle()
                    .frame(maxWidth: 48, maxHeight: 48)
                    .cornerRadius(48)
                    .foregroundColor(.iconBase)
                Image(WeatherManagerExtension().getImageNameFromForecastIcon(icon: weatherData.icon))
                    .imageSize()
            }
            .padding(.leading, 16)
            
            VStack(alignment: .leading) {
                if let listResponse = weatherData as? ForecastResponse.ListResponse {
                    Text(listResponse.dateInfo)
                        .modifier(ContentMediumModifier())
                } else if let currentResponse = weatherData as? CurrentResponse {
                    Text(currentResponse.dateInfo)
                        .modifier(ContentMediumModifier())
                }
                
                Text(weatherData.weatherInfo)
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
        
        let temperature = Measurement(value: weatherData.temperature, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
    }
}

struct MockWeatherData: WeatherData {
    var temperature: Double
    var icon: String
    var weatherInfo: String
    var dateInfo: String
}

struct ForecastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForecastDetailView(weatherData: MockWeatherData(temperature: 22.0, icon: "01d", weatherInfo: "Clear Sky", dateInfo: "Now"))
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Current Weather")

            ForecastDetailView(weatherData: MockWeatherData(temperature: 18.0, icon: "03d", weatherInfo: "Partly Cloudy", dateInfo: "Tomorrow"))
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Forecast Weather")
        }
    }
}
