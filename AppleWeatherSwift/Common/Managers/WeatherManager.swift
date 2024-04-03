//
//  WeatherManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 02.12.2023.
//
//

import Foundation
import CoreLocation
import SwiftUI

protocol WeatherManaging {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentResponse
    func getForecastWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastResponse
}

class WeatherManager: WeatherManaging {
    
    private let networkManager = NetworkManager()
    
    init() {
        URLSession.shared.configuration.timeoutIntervalForRequest = 5
    }
    
    // MARK: - API CALLING Current Weather
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentResponse {
        
        // try awit -> provolavnani API client or nertwork service 
        guard let url = URL(string: "\(Constants.baseURL)weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.apiKey)&units=metric") else { fatalError("Missing URL") }
        // url zde nevytvaret -> vytvorit API client
        let urlRequest = URLRequest(url: url)
        
        do {
            // zanechat
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw GHError.invalidResponse
            }
            
            let decodedData = try JSONDecoder().decode(CurrentResponse.self, from: data)
            
            SharedDataSource.shared.saveCurrentResponse(decodedData)
            
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
    func getForecastWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastResponse {
        guard let url = URL(string: "\(Constants.baseURL)forecast?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.apiKey)&units=metric") else { fatalError("Missing URL") }
        
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
