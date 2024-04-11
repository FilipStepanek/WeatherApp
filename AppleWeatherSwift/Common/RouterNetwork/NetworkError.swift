//
//  APIError.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 03.04.2024.
//

import Foundation
import OSLog

enum NetworkError: LocalizedError {
    case parseUrlFail
    case notFound
    case validationError
    // TODO: add server error
    case serverError
    case defaultError
    case noInternetConnection
    case invalidResponse
    
    var errorDescription: String {
        switch self {
        case .parseUrlFail:
            return "Cannot initial URL object."
        case .notFound:
            return "Not Found"
        case .validationError:
            return "Validation Errors"
        case .serverError:
            return "Internal Server Error"
        case .defaultError:
            return "Something went wrong."
        case .noInternetConnection:
            return "No internet connection."
        case .invalidResponse:
            return "Invalid response."
        }
    }
}
