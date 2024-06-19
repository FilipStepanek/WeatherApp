//
//  ResponseData.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 14.03.2024.
//

import Foundation

// MARK: - Model of the response body we get from calling the OpenWeather API
public struct CurrentResponse: Codable, Equatable {
    public var coord: CoordinatesResponse
    public var weather: [WeatherResponse]
    public var main: MainResponse
    public var name: String
    public var wind: WindResponse
    public var sys: CountryName
    public var rain: Precipitation?
    
    public static func == (lhs: CurrentResponse, rhs: CurrentResponse) -> Bool {
        return lhs.coord == rhs.coord &&
               lhs.weather == rhs.weather &&
               lhs.main == rhs.main &&
               lhs.name == rhs.name &&
               lhs.wind == rhs.wind &&
               lhs.sys == rhs.sys &&
               lhs.rain == rhs.rain
    }
    
    public struct CoordinatesResponse: Codable, Equatable {
        public var lon: Double
        public var lat: Double
    }
    
    public struct WeatherResponse: Codable, Equatable {
        public var id: Double
        public var main: String
        public var description: String
        public var icon: String
    }
    
    public struct MainResponse: Codable, Equatable {
        public var temp: Double
        public var pressure: Double
        public var humidity: Double
    }
    
    public struct WindResponse: Codable, Equatable {
        public var speed: Double
        public let deg: Double
        public var windDirection: String {
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
    
    public struct CountryName: Codable, Equatable {
        public var country: String
    }
    
    public struct Precipitation: Codable, Equatable {
        public var oneHour: Double?
        
        enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
        }
    }
}

public struct ForecastResponse: Codable, Equatable {
    public let city: CoordinatesResp
    public let list: [ListResponse]
    
    public static func == (lhs: ForecastResponse, rhs: ForecastResponse) -> Bool {
        return lhs.city == rhs.city && lhs.list == rhs.list
    }
    
    public struct ListResponse: Codable, Equatable {
        public var date: Double
        public var main: MainResponseForecast
        public var weather: [WeatherResponseForecast]
        
        public enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
        }
    }
    
    public struct CoordinatesResp: Codable, Equatable {
        public var coord: Coordinates
    }
    
    public struct Coordinates: Codable, Equatable {
        public var lon: Double
        public var lat: Double
    }
    
    public struct MainResponseForecast: Codable, Equatable {
        public var temp: Double
    }
    
    public struct WeatherResponseForecast: Codable, Equatable {
        public var icon: String
    }
}

#if DEBUG
//MARK: - Extension for ModelData
public extension CurrentResponse {
    static let previewMock: Self = load("weatherDataCurrentWeather.json")
}

public extension ForecastResponse {
    static let previewMock: Self = load("weatherDataForecast.json")
}
#endif
