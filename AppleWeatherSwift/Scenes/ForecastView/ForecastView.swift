//
//  ForecastView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI

struct ForecastView: View {
    
    @StateObject private var viewModelForecast = ForecastViewModel()
    
    var body: some View {
        ZStack {
            switch viewModelForecast.state {
            case .loading:
                LoadingView()
            case .missingLocation:
                EnableLocationView()
            case .success(let forecastResponse, let currentResponse ):
                ForecastViewContent(weather: forecastResponse, weatherNow: currentResponse)
            case .error:
                ErrorFetchingDataView {
                    viewModelForecast.onRefresh()
                }
            case .errorNetwork:
                ErrorInternetConnectionView {
                    viewModelForecast.onRefresh()
                }
            }
        }
        .environmentObject(viewModelForecast)
    }
}

#if DEBUG
#Preview {
    ForecastView()
}
#endif
