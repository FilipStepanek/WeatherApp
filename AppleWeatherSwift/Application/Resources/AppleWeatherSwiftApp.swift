//
//  AppleWeatherSwiftApp.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI
import Factory

@main
@MainActor
struct AppleWeatherSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension Container {
    var weatherManager: Factory<WeatherManaging> {
        Factory(self) {
            WeatherManager()
        }
    }
}
