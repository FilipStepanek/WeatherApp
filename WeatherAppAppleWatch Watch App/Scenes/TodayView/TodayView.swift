//
//  SwiftUIView.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 12.02.2024.
//

import SwiftUI

struct TodayView: View {
    
    @StateObject private var viewModelToday = TodayViewModel()
    
    var body: some View {
        ZStack {
            switch viewModelToday.state {
            case .loading:
                LoadingView()
            case .missingLocation:
                EnableLocationView(locationManager: viewModelToday.locationManager)
            case .succes(let currentResponse):
                TodayViewContent(weather: currentResponse)
            case .error:
                ErrorFetchingDataView()
            case .errorNetwork:
                ErrorInternetConnectionView {
                    viewModelToday.onRefresh()
                }
            }
        }
        .onLoad {
            viewModelToday.initialLoad()
        }
    }
}

#if DEBUG
#Preview {
    TodayView()
}
#endif
