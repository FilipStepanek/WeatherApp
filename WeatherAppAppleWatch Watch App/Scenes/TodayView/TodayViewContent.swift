//
//  TodayViewContent.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 12.02.2024.
//

import SwiftUI

struct TodayViewContent: View {
    
    @EnvironmentObject private var viewModel: TodayViewModel
    @State private var isShowingForecast = false
    
    let weather: CurrentResponse
    
    var body: some View {
        VStack {
            todayInformationHeader
            
            ScrollView {
                VStack {
                    VStack(
                        alignment: .center,
                        spacing: 4
                    ){
                        todayInformation
                    }
                    
                    todayInformationDetail
                }
                .background(.mainBackground)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder
    var todayInformationHeader: some View {
        HStack(alignment: .top) {
            Button(action: {
                isShowingForecast = true
            }) {
                Image(.tabBarForecast)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(ForecastButton())
            .sheet(isPresented: $isShowingForecast) {
                ForecastView()
            }
            .padding(.top, 15)
            .padding(.bottom, 5)
            .padding(.leading, 10)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    var todayInformationDetail: some View {
        VStack(
            alignment: .center,
            spacing: 15
        ){
            Rectangle()
                .frame(maxHeight: 1)
                .foregroundColor(.devider)
                .padding()
                .padding(.top, 20)
            TodayDetailInfo(weather: weather)
        }
    }
    
    @ViewBuilder
    var todayInformation: some View {
        
        let temperatureWithUnits = "\(temperatureUnitSymbol())"
        
        Text((weather.name ) + ", " + (String().countryName(countryCode: weather.sys.country ) ?? "Unknown"))
                    .modifier(ContentModifier())
                    .padding(.vertical, 8)
        
        Image(viewModel.weatherManagerExtension.getImageNameFromWeatherIcon(icon: weather.weather.first?.icon ?? ""))
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: 40, maxWidth: 40)
        
        Text(temperatureWithUnits)
            .modifier(TemperatureModifier())
            .padding(.vertical, 4)
        
        Text(WeatherManagerExtension().getWeatherInfoFromWeatherIcon(icon: weather.weather.first?.icon ?? "", temperature: weather.main.temp))
            .modifier(ContentMediumModifier())
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
    TodayViewContent(weather: .previewMock)
}
#endif
