//
//  MyLocationView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

//import SwiftUI
//
//struct TodayView: View {
//    
//    @StateObject private var viewModelToday = TodayViewModel()
//    
//    var body: some View {
//        ZStack {
//            switch viewModelToday.state {
//            case .loading:
//                LoadingView()
//            case .missingLocation:
//                EnableLocationView(locationManager: viewModelToday.locationManager)
//            case .succes(let currentResponse):
//                TodayViewContent(weatherManager: WeatherManager(), weather: currentResponse)
//            case .error:
//                ErrorFetchingDataView()
//            case .errorNetwork:
//                ErrorInternetConnectionView {
//                    viewModelToday.onRefresh()
//                }
//            }
//        }
//        .task {
//            viewModelToday.initialLoad()
//        }
//    }
//}
//
//struct TodayView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodayView()
//    }
//}

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
                TodayViewContent(weatherManager: WeatherManager(), weather: currentResponse)
            case .error:
                ErrorFetchingDataView()
            case .errorNetwork:
                ErrorInternetConnectionView {
                    viewModelToday.onRefresh()
                }
            }
        }
        .task {
            viewModelToday.initialLoad()
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
