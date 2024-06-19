//
//  MyLocationView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
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
                EnableLocationView()
            case .success(let currentResponse):
                TodayViewContent(weather: currentResponse)
            case .error:
                ErrorFetchingDataView {
                    viewModelToday.onRefresh()
                }
            case .errorNetwork:
                ErrorInternetConnectionView {
                    viewModelToday.onRefresh()
                }
            }
        }
        .environmentObject(viewModelToday)
    }
}

#if DEBUG
#Preview {
    TodayView()
}
#endif
