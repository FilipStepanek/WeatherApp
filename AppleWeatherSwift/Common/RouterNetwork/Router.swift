//
//  Router.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 03.04.2024.
//

import Foundation

// Define HTTPStatusCode enum
enum HTTPStatusCode: Int, Comparable {
    // Informational
    case `continue` = 100
    case switchingProtocols = 101
    case processing = 102
    
    // Success
    case ok = 200
    case created = 201
    case accepted = 202
    // Add more success codes as needed
    
    // Redirection
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    // Add more redirection codes as needed
    
    // Client Error
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    // Add more client error codes as needed
    
    // Server Error
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    // Add more server error codes as needed
    
    static func < (lhs: HTTPStatusCode, rhs: HTTPStatusCode) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

// Define HTTPMethod enum
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    // Add more HTTP methods as needed
}

// Define HTTPHeader enum
enum HTTPHeader {
    enum ContentType: String {
        case json = "application/json"
        // Add more content types as needed
    }
    
    enum HeaderField: String {
        case contentType = "Content-Type"
        // Add more header fields as needed
    }
}

// Define Router protocol
protocol Router {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var urlParameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var acceptableStatusCodes: Range<HTTPStatusCode>? { get }
    var isAuthorizationRequired: Bool { get }

    func asRequest() throws -> URLRequest
}

extension Router {
    func asRequest() throws -> URLRequest {
        let urlPath = baseURL.appendingPathComponent(path)

        guard var urlComponents = URLComponents(url: urlPath, resolvingAgainstBaseURL: true) else {
            throw APIError.parseUrlFail
        }

        if let urlParameters = urlParameters {
            urlComponents.queryItems = urlParameters.map {
                URLQueryItem(name: $0, value: String(describing: $1))
            }
        }

        guard let url = urlComponents.url else {
            throw APIError.parseUrlFail
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        request.setValue(
            HTTPHeader.ContentType.json.rawValue,
            forHTTPHeaderField: HTTPHeader.HeaderField.contentType.rawValue
        )

        return request
    }
}
