//
//  AppleWeatherSwiftApp.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

//import SwiftUI
//
//@main
//struct AppleWeatherSwiftApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}
//


import SwiftUI

@main
struct AppleWeatherSwiftApp: App {
    let userDefaults = UserDefaults(suiteName: "group.stepanek.weatherapp")!
    var body: some Scene {
        let weatherManager = WeatherManager(userDefaults: userDefaults)
        WindowGroup {
            ContentView().environmentObject(weatherManager)
        }
    }
}
