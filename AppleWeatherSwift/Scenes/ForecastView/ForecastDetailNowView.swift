//
//  ForecastDetailNowView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 07.02.2024.
//

import SwiftUI

struct ForecastDetailNowView: View {
    
    let weatherNow: ResponseData.CurrentResponse
    
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
                Image(WeatherManagerExtension().getImageNameFromForecastIcon(icon: weatherNow.weather.first?.icon ?? ""))
                    .imageSize()
                
            }
            .padding(.leading, 16)
            
            VStack(
                alignment: .leading
                
            ) {
                Text("Now")
                    .modifier(ContentMediumModifier())
                
            
                Text(WeatherManagerExtension().getWeatherInfoFromForecastIcon(icon: weatherNow.weather.first?.icon ?? ""))
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
        
        let temperature = Measurement(value: weatherNow.main.temp, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
    }
}

struct ForecastDetailNowView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDetailNowView(weatherNow: previewWeather)
    }
}
