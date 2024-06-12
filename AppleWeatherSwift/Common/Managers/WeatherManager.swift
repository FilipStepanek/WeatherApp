//
//  WeatherManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 02.12.2023.
//

//import Foundation
//import CoreLocation
//import SwiftUI
//import OSLog
//
//protocol WeatherManaging {
//    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentResponse
//    func getForecastWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastResponse
//    func request<T: Decodable>(router: Router) async throws -> T
//}
//
//class WeatherManager: WeatherManaging {
//    
//    private let networkManager = Network.shared
//    
//    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentResponse {
//        let router = RouterWeatherManager.getCurrentWeather(latitude: latitude, longitude: longitude)
//        do {
//            Logger.networking.info("Fetching weather data for current weather")
//            let response: CurrentResponse = try await networkManager.request(router: router)
//            Logger.networking.info("Weather data for current weather fetched")
//            return response
//        } catch {
//            throw networkManager.handleNetworkError(error)
//        }
//    }
//    
//    func getForecastWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastResponse {
//        let router = RouterWeatherManager.getForecast(latitude: latitude, longitude: longitude)
//        do {
//            Logger.networking.info("Fetching weather data for forecast")
//            let response: ForecastResponse = try await networkManager.request(router: router)
//            Logger.networking.info("Weather data for forecast fetched")
//            return response
//        } catch {
//            throw networkManager.handleNetworkError(error)
//        }
//    }
//    
//    func request<T: Decodable>(router: Router) async throws -> T {
//        return try await networkManager.request(router: router)
//    }
//}
