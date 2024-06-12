//
//  AppleWeatherSwiftApp.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI
import Factory
import OSLog
import Shared

@main
@MainActor
struct AppleWeatherSwiftApp: App {
    // Use @Environment to track the scene phase
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            // Inject the ViewModels into ContentView
            ContentView()
            // Add scene phase handling
                .onChange(of: scenePhase) { newScenePhase in
                    switch newScenePhase {
                    case .active:
                        Logger.viewCycle.info("App is active")
                        
                    case .inactive, .background:
                        Logger.viewCycle.info("App is in background")
                    @unknown default:
                        break
                    }
                }
        }
    }
}

extension Container {
    var weatherManager: Factory<WeatherManaging> {
        Factory(self) {
            WeatherManager()
        }
    }
    
    var locationManager: Factory<LocationManaging> {
        Factory(self) {
            LocationManager()
        }
    }
}
