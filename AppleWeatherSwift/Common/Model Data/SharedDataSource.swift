//
//  SharedDataSource.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.03.2024.
//


//import SwiftUI
//
//class SharedDataSource: ObservableObject {
//    // Define your data model
//    @AppStorage("currentResponse", store: UserDefaults(suiteName: "group.weatherapp.stepanek")) var currentResponseData: Data?
//    @AppStorage("forecastResponse", store: UserDefaults(suiteName: "group.weatherapp.stepanek")) var forecastResponseData: Data?
//    
//    // Functions to save and retrieve data
//    func saveCurrentResponse(_ response: CurrentResponse) {
//        if let encoded = try? JSONEncoder().encode(response) {
//            currentResponseData = encoded
//        }
//    }
//    
//    func getCurrentResponse() -> CurrentResponse? {
//        if let data = currentResponseData {
//            if let response = try? JSONDecoder().decode(CurrentResponse.self, from: data) {
//                return response
//            }
//        }
//        return nil
//    }
//    
//    func saveForecastResponse(_ response: ForecastResponse) {
//        if let encoded = try? JSONEncoder().encode(response) {
//            forecastResponseData = encoded
//        }
//    }
//    
//    func getForecastResponse() -> ForecastResponse? {
//        if let data = forecastResponseData {
//            if let response = try? JSONDecoder().decode(ForecastResponse.self, from: data) {
//                return response
//            }
//        }
//        return nil
//    }
//}

import Foundation
import OSLog

class SharedDataSource {
    static let shared = SharedDataSource()

    let sharedContainer: UserDefaults

    private init() {
        let sharedSuiteName = "group.stepanek.weatherapp"
        sharedContainer = UserDefaults(suiteName: sharedSuiteName)!
    }

    func saveCurrentResponse(_ response: ResponseData.CurrentResponse) {
        if let encodedData = try? JSONEncoder().encode(response) {
            sharedContainer.set(encodedData, forKey: "currentResponse")
            Logger.viewCycle.info("Data saved for widget")
        }
    }

    func getCurrentResponse() -> ResponseData.CurrentResponse? {
        if let data = sharedContainer.data(forKey: "currentResponse"),
           let decodedResponse = try? JSONDecoder().decode(ResponseData.CurrentResponse.self, from: data) {
            Logger.viewCycle.info("Data ready for widget")
            return decodedResponse
        }
        return nil
    }
}
