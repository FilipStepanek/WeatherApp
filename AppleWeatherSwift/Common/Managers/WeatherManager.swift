//
//  WeatherManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 02.12.2023.
//

import Foundation
import CoreLocation
import SwiftUI

class WeatherManager {
    
    private let networkManager = NetworkManager()
    
    // MARK: - API CALLING Current Weather
    struct CurrentAPIConfig {
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = "020e61171acbd0230c6f8fe970f138e7"
    }
    
    init() {
        URLSession.shared.configuration.timeoutIntervalForRequest = 5
    }
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentResponse {
        guard let url = URL(string: "\(CurrentAPIConfig.baseURL)weather?lat=\(latitude)&lon=\(longitude)&appid=\(CurrentAPIConfig.apiKey)&units=metric") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw GHError.invalidResponse
            }
            
            let decodedData = try JSONDecoder().decode(CurrentResponse.self, from: data)
            
            return decodedData
            
        } catch {
            if networkManager.isConnected {
                throw error
            } else {
                throw GHError.noInternetConnection
            }
        }
    }
    
    // MARK: - API CALLING Forecast
    struct ForecastAPIConfig {
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = "020e61171acbd0230c6f8fe970f138e7"
    }
    
    func getForecastWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastResponse {
        guard let url = URL(string: "\(ForecastAPIConfig.baseURL)forecast?lat=\(latitude)&lon=\(longitude)&appid=\(ForecastAPIConfig.apiKey)&units=metric") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw GHError.invalidResponse
            }
            
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try decoder.decode(ForecastResponse.self, from: data)
            
            return decodedData
            
        } catch {
            if networkManager.isConnected {
                throw error
            } else {
                throw GHError.noInternetConnection
            }
        }
    }
}

enum GHError: Error {
    case invalidResponse
    case noInternetConnection
}

// MARK: - Model of the response body we get from calling the OpenWeather API
struct CurrentResponse: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var sys: CountryName
    var rain: Precipitation?
    
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
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
    
    struct CountryName: Decodable {
        var country: String
    }
    
    struct Precipitation: Decodable {
        var oneHour: Double?
        
        enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
        }
    }
}

struct ForecastResponse: Decodable {
    let city: CoordinatesResp
    let list: [ListResponse]
    
    struct ListResponse: Decodable {
        var date: Double
        var main: MainResponseForecast
        var weather: [WeatherResponseForecast]
        
        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
        }
    }
    
    struct CoordinatesResp: Decodable {
        var coord: Coordinates
    }
    
    struct Coordinates: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct MainResponseForecast: Decodable {
        var temp: Double
    }
    
    struct WeatherResponseForecast: Decodable {
        var icon: String
    }
}
