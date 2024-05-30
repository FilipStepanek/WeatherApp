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
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                let _ = print(proxy.size.height)
                VStack(alignment: .leading) {
                    Spacer(minLength: 70)
                    
                    VStack(alignment: .leading, spacing: 48) {
                        todayTitleInformation
                            .modifier(ConditionalScrollTransition())
                        
                        todayInformation
                            .modifier(ConditionalScrollTransition())
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        rectangles
                            .modifier(ConditionalScrollTransition())
                        
                        TodayDetailInfo(weather: weather)
                            .modifier(ConditionalScrollTransition())
                        
                        rectangles
                            .modifier(ConditionalScrollTransition())
                    }
                    .padding(.vertical)
                }
                .frame(height: proxy.size.height)
            }
            
            .refreshable {
                viewModel.onRefresh()
            }
            
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .top, alignment: .trailing) {
            shareButton
                .padding(.trailing)
        }
        .background(
            TodayAnimationBackgroundView(weather: weather)
        )
        .sheet(isPresented: $viewModel.isShareSheetPresented) {
            ShareSheetView(activityItems: [URL(string: Constants.openWeatherMapURL)])
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
            .lineLimit(2)
            .minimumScaleFactor(0.8)
    }
    
    var rectangles: some View {
        Rectangle()
            .frame(maxHeight: 1)
            .foregroundColor(.divider)
    }
    
    @ViewBuilder
    var todayInformation: some View {
        let temperatureWithUnits = "\(temperatureUnitSymbol())"
        
        VStack(alignment: .leading, spacing: -4) {
            Image(viewModel.weatherManagerExtension.getImageNameFromWeatherIcon(icon: weather.weather.first?.icon ?? ""))
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 40, maxWidth: 40)
            
            Text(temperatureWithUnits)
                .modifier(TemperatureModifier())
                .padding(.vertical, 4)
            
            Text((weather.name) + ", " + (String().countryName(countryCode: weather.sys.country) ?? "Unknown"))
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
