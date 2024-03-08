//
//  WeatherManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 02.12.2023.
//
//
//import Foundation
//import CoreLocation
//import SwiftUI
//
//class WeatherManager {
//    
//    private let networkManager = NetworkManager()
//    
//    // MARK: - API CALLING Current Weather
//    struct CurrentAPIConfig {
//        static let baseURL = "https://api.openweathermap.org/data/2.5/"
//        static let apiKey = "020e61171acbd0230c6f8fe970f138e7"
//    }
//    
//    init() {
//        URLSession.shared.configuration.timeoutIntervalForRequest = 5
//    }
//    
//    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentResponse {
//        guard let url = URL(string: "\(CurrentAPIConfig.baseURL)weather?lat=\(latitude)&lon=\(longitude)&appid=\(CurrentAPIConfig.apiKey)&units=metric") else { fatalError("Missing URL") }
//        
//        let urlRequest = URLRequest(url: url)
//        
//        do {
//            let (data, response) = try await URLSession.shared.data(for: urlRequest)
//            
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//                throw GHError.invalidResponse
//            }
//            
//            let decodedData = try JSONDecoder().decode(CurrentResponse.self, from: data)
//            
//            return decodedData
//            
//        } catch {
//            if networkManager.isConnected {
//                throw error
//            } else {
//                throw GHError.noInternetConnection
//            }
//        }
//    }
//    
//    // MARK: - API CALLING Forecast
//    struct ForecastAPIConfig {
//        static let baseURL = "https://api.openweathermap.org/data/2.5/"
//        static let apiKey = "020e61171acbd0230c6f8fe970f138e7"
//    }
//    
//    func getForecastWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastResponse {
//        guard let url = URL(string: "\(ForecastAPIConfig.baseURL)forecast?lat=\(latitude)&lon=\(longitude)&appid=\(ForecastAPIConfig.apiKey)&units=metric") else { fatalError("Missing URL") }
//        
//        let urlRequest = URLRequest(url: url)
//        
//        do {
//            let (data, response) = try await URLSession.shared.data(for: urlRequest)
//            
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//                throw GHError.invalidResponse
//            }
//            
//            let decoder = JSONDecoder()
//            
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            
//            let decodedData = try decoder.decode(ForecastResponse.self, from: data)
//                        
//            return decodedData
//            
//        } catch {
//            if networkManager.isConnected {
//                throw error
//            } else {
//                throw GHError.noInternetConnection
//            }
//        }
//    }
//}
//
//enum GHError: Error {
//    case invalidResponse
//    case noInternetConnection
//}
//
//// MARK: - Model of the response body we get from calling the OpenWeather API
//struct CurrentResponse: Codable {
//    var coord: CoordinatesResponse
//    var weather: [WeatherResponse]
//    var main: MainResponse
//    var name: String
//    var wind: WindResponse
//    var sys: CountryName
//    var rain: Precipitation?
//    
//    
//    struct CoordinatesResponse: Codable {
//        var lon: Double
//        var lat: Double
//    }
//    
//    struct WeatherResponse: Codable {
//        var id: Double
//        var main: String
//        var description: String
//        var icon: String
//    }
//    
//    struct MainResponse: Codable {
//        var temp: Double
//        var pressure: Double
//        var humidity: Double
//    }
//    
//    struct WindResponse: Codable {
//        var speed: Double
//        let deg: Double
//        var windDirection: String {
//            if deg >= 337 || deg < 23 {
//                return "N"
//            }
//            if deg < 67 {
//                return "NE"
//            }
//            if deg < 113 {
//                return "E"
//            }
//            if deg < 157 {
//                return "SE"
//            }
//            if deg < 203 {
//                return "S"
//            }
//            if deg < 247 {
//                return "SW"
//            }
//            if deg < 293 {
//                return "W"
//            }
//            return "NW"
//        }
//    }
//    
//    struct CountryName: Codable {
//        var country: String
//    }
//    
//    struct Precipitation: Codable {
//        var oneHour: Double?
//        
//        enum CodingKeys: String, CodingKey {
//            case oneHour = "1h"
//        }
//    }
//}
//
//struct ForecastResponse: Codable {
//    let city: CoordinatesResp
//    let list: [ListResponse]
//    
//    struct ListResponse: Codable {
//        var date: Double
//        var main: MainResponseForecast
//        var weather: [WeatherResponseForecast]
//        
//        enum CodingKeys: String, CodingKey {
//            case date = "dt"
//            case main
//            case weather
//        }
//    }
//    
//    struct CoordinatesResp: Codable {
//        var coord: Coordinates
//    }
//    
//    struct Coordinates: Codable {
//        var lon: Double
//        var lat: Double
//    }
//    
//    struct MainResponseForecast: Codable {
//        var temp: Double
//    }
//    
//    struct WeatherResponseForecast: Codable {
//        var icon: String
//    }
//}
//



import Foundation
import CoreLocation
import Combine

class WeatherManager: ObservableObject {
    
    private let networkManager = NetworkManager()
    private let userDefaults: UserDefaults
    
    // MARK: - API Configurations
    struct APIConfig {
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = "020e61171acbd0230c6f8fe970f138e7"
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        URLSession.shared.configuration.timeoutIntervalForRequest = 5
    }
    
    // MARK: - Fetch Current Weather
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (CurrentResponse?, Error?) -> Void) {
        guard let url = URL(string: "\(APIConfig.baseURL)weather?lat=\(latitude)&lon=\(longitude)&appid=\(APIConfig.apiKey)&units=metric") else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(nil, NSError(domain: "Invalid response", code: -1, userInfo: nil))
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: -1, userInfo: nil))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(CurrentResponse.self, from: data)
                self.saveWeatherData(decodedData)
                completion(decodedData, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    // MARK: - Fetch Forecast Weather
    func getForecastWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (ForecastResponse?, Error?) -> Void) {
        guard let url = URL(string: "\(APIConfig.baseURL)forecast?lat=\(latitude)&lon=\(longitude)&appid=\(APIConfig.apiKey)&units=metric") else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(nil, NSError(domain: "Invalid response", code: -1, userInfo: nil))
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: -1, userInfo: nil))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(ForecastResponse.self, from: data)
                completion(decodedData, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    // MARK: - Save Weather Data
    private func saveWeatherData(_ weatherData: CurrentResponse) {
        do {
            let encodedData = try JSONEncoder().encode(weatherData)
            userDefaults.set(encodedData, forKey: "weatherData")
        } catch {
            print("Error saving weather data: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Retrieve Weather Data
    func retrieveWeatherData() -> CurrentResponse? {
        guard let data = userDefaults.data(forKey: "weatherData") else {
            return nil
        }
        
        do {
            let decodedData = try JSONDecoder().decode(CurrentResponse.self, from: data)
            return decodedData
        } catch {
            print("Error decoding weather data: \(error.localizedDescription)")
            return nil
        }
    }
}

// MARK: - Model of the response body we get from calling the OpenWeather API
struct CurrentResponse: Codable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var sys: CountryName
    var rain: Precipitation?
    
    
    struct CoordinatesResponse: Codable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Codable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Codable {
        var temp: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Codable {
        var speed: Double
        let deg: Double
        var windDirection: String {
            if deg >= 337 || deg < 23 {
                return "N"
            }
            if deg < 67 {
                return "NE"
            }
            if deg < 113 {
                return "E"
            }
            if deg < 157 {
                return "SE"
            }
            if deg < 203 {
                return "S"
            }
            if deg < 247 {
                return "SW"
            }
            if deg < 293 {
                return "W"
            }
            return "NW"
        }
    }
    
    struct CountryName: Codable {
        var country: String
    }
    
    struct Precipitation: Codable {
        var oneHour: Double?
        
        enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
        }
    }
}

struct ForecastResponse: Codable {
    let city: CoordinatesResp
    let list: [ListResponse]
    
    struct ListResponse: Codable {
        var date: Double
        var main: MainResponseForecast
        var weather: [WeatherResponseForecast]
        
        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
        }
    }
    
    struct CoordinatesResp: Codable {
        var coord: Coordinates
    }
    
    struct Coordinates: Codable {
        var lon: Double
        var lat: Double
    }
    
    struct MainResponseForecast: Codable {
        var temp: Double
    }
    
    struct WeatherResponseForecast: Codable {
        var icon: String
    }
}

