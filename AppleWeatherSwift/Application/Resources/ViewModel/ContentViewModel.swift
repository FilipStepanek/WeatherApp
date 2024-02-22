//
//  ContentViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 13.12.2023.
//

import Foundation
import CoreLocationUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var weather: CurrentResponse?
        @Published var forecast: ForecastResponse?
        @Published var loadingError: Bool = false
        @Published var selectedTab = 0
        @Published private var isLocationEnabled: Bool = true
    }
}
