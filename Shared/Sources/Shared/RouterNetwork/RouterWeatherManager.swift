//
//  RouterWeatherManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 04.04.2024.
//

import Foundation
import CoreLocation

enum RouterWeatherManager {
    case getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    case getForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

extension RouterWeatherManager: Router {
    var baseURL: URL {
        Constants.baseURL.appendingPathComponent("2.5")
    }

    var path: String {
        switch self {
        case .getCurrentWeather:
            return "weather"
        case .getForecast:
            return "forecast"
        }
    }

    var method: HTTPMethod {
        .get
    }

    var urlParameters: [String: Any]? {
        switch self {
        case .getCurrentWeather(let latitude, let longitude),
             .getForecast(let latitude, let longitude):
            return [
                "lat": latitude,
                "lon": longitude,
                "appid": Constants.apiKey,
                "units": "metric"
            ]
        }
    }

    var headers: [String: String]? {
        nil
    }

    var acceptableStatusCodes: Range<HTTPStatusCode>? {
        nil
    }

    var isAuthorizationRequired: Bool {
        true
    }
}
