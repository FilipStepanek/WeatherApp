//
//  ForecastView.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 13.02.2024.
//

import SwiftUI

struct ForecastView: View {
    
    @StateObject private var viewModelForecast = ForecastViewModel()
    @StateObject private var viewModelToday = TodayViewModel()
    
    var body: some View {
        ZStack {
            switch viewModelForecast.state {
            case .loading:
                LoadingView()
            case .missingLocation:
                EnableLocationView(locationManager: viewModelForecast.locationManager)
            case .success(let forecastResponse, let currentResponse ):
                ForecastViewContent(weather: forecastResponse, weatherNow: currentResponse)
            case .error:
                ErrorFetchingDataView()
            case .errorNetwork:
                ErrorInternetConnectionView {
                    viewModelForecast.onRefresh()
                }
            }
        }
        .task {
            viewModelForecast.initialLoad()
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
