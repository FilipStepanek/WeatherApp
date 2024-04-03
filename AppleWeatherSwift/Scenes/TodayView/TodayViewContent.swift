//
//  TodayViewContent.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 08.01.2024.
//

import SwiftUI
import OSLog

struct TodayViewContent: View {
    
        @StateObject private var viewModel = TodayViewModel()
        let weather: CurrentResponse
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                shareButton
                
                    .padding(.trailing)
            }
            .padding(.top)
            
            VStack(alignment: .leading) {
                ScrollView(showsIndicators: false)
                {
                    VStack(alignment: .leading) {
                        Spacer(minLength: 115)
                        
                        VStack (
                            alignment: .leading,
                            spacing: 48
                        ){
                            
                            todayTitleInformation
                            
                            todayInformation
                        }
                        
                        VStack (
                            alignment: .leading,
                            spacing: 15
                        ){
                            rectangles
                            
                            TodayDetailInfo(weather: weather)
                            
                            rectangles
                        }
                        .padding(.vertical)
                    }
                    
                }
                .refreshable{
                    viewModel.onRefresh()
                }
            }
            .padding(.horizontal)
        }
        .background(
            TodayAnimationBackgroundView(weather: weather)
        )
        .sheet(isPresented: $viewModel.isShareSheetPresented) {
            ShareSheetView(activityItems: [ URL(string: Constants.openWeatherMapURL)])
                .presentationDetents([.medium, .large])
        }
    }
    @ViewBuilder
    var shareButton: some View {
        
        Button(action: {
            Logger.viewCycle.info("Button pressed Share")
            viewModel.isShareSheetPresented = true
        }) {
            Text("share.button.title")
                .cornerRadius(40)
                .accentColor(.tabBar)
                .font(.buttons)
                .foregroundStyle(.shareButtonText)
        }
        .buttonStyle(ShareButton())
    }
    
    var todayTitleInformation: some View {
        Text(WeatherManagerExtension().getWeatherInfoFromWeatherIcon(icon: weather.weather.first?.icon ?? "", temperature: weather.main.temp))
            .modifier(TitleModifier())
            .foregroundColor(.mainText)
    }
    
    var rectangles: some View {
        Rectangle()
            .frame(maxHeight: 1)
            .foregroundColor(.devider)
    }
    
    @ViewBuilder
    var todayInformation: some View {
        
        let temperatureWithUnits = "\(temperatureUnitSymbol())"
        
        VStack (alignment: .leading, spacing: -4) {
            Image(viewModel.weatherManagerExtension.getImageNameFromWeatherIcon(icon: weather.weather.first?.icon ?? ""))
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 40, maxWidth: 40)
            
            Text(temperatureWithUnits)
                .modifier(TemperatureModifier())
                .padding(.vertical, 4)
            
            Text((weather.name ) + ", " + (String().countryName(countryCode: weather.sys.country ) ?? "Unknown"))
                .modifier(ContentModifier())
                .padding(.vertical, 8)
        }
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
