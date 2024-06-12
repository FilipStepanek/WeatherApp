//
//  WeatherAppWidgetsBundle.swift
//  WeatherAppWidgets
//
//  Created by Filip Štěpánek on 18.02.2024.
//

import WidgetKit
import SwiftUI
import Factory
import Shared

@main
struct WeatherAppWidgetsBundle: WidgetBundle {
    
    var body: some Widget {
        WidgetExtension()
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

