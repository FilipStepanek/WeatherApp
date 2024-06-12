//
//  ForecastDetailView.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 13.02.2024.
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
        
        HStack(
            spacing: 6
            
        ) {
            ZStack {
                
                Circle()
                    .frame(maxWidth: 35, maxHeight: 35)
                    .cornerRadius(35)
                    .foregroundColor(.iconBase)
                Image(WeatherManagerExtension().getImageNameFromForecastIcon(icon: weatherData.icon))
                    .imageSize()
                
            }
            .padding(.leading, 5)
            .padding(.vertical, 6)
            
            VStack(
                alignment: .leading
            ) {
                if let listResponse = weatherData as? ForecastResponse.ListResponse {
                    Text(listResponse.dateInfo)
                        .modifier(ContentMediumModifier())
                } else if let currentResponse = weatherData as? CurrentResponse {
                    Text(currentResponse.dateInfo)
                        .modifier(ContentMediumModifier())
                }
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

//#if DEBUG
//struct ForecastDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let mockForecastResponse = ForecastResponse.ListResponse(
//            date: 1702749600,
//            main: ForecastResponse.MainResponseForecast(temp: 30),
//            weather: [ForecastResponse.WeatherResponseForecast(icon: "01d")]
//        )
//        
//        let mockCurrentResponse = CurrentResponse(
//            coord: CurrentResponse.CoordinatesResponse(lon: 0, lat: 0),
//            weather: [CurrentResponse.WeatherResponse(id: 800, main: "Clear", description: "clear sky", icon: "01d")],
//            main: CurrentResponse.MainResponse(temp: 25, pressure: 1013, humidity: 60),
//            name: "Sample City",
//            wind: CurrentResponse.WindResponse(speed: 5.0, deg: 180),
//            sys: CurrentResponse.CountryName(country: "Sample Country"),
//            rain: nil
//        )
//
//        return Group {
//            ForecastDetailView(weatherData: mockForecastResponse)
//            ForecastDetailView(weatherData: mockCurrentResponse)
//        }
//    }
//}
//#endif
