//
//  Router.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 03.04.2024.
//

import Foundation

// Define HTTPStatusCode enum
public enum HTTPStatusCode: Int, Comparable {
    case ok = 200
    
    public static func < (lhs: HTTPStatusCode, rhs: HTTPStatusCode) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

// Define HTTPMethod enum
public enum HTTPMethod: String {
    case get = "GET"
}

// Define HTTPHeader enum
public enum HTTPHeader {
    enum ContentType: String {
        case json = "application/json"
    }
    
    enum HeaderField: String {
        case contentType = "Content-Type"
    }
}

// Define Router protocol
public protocol Router {
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
            throw NetworkError.parseUrlFail
        }

        if let urlParameters = urlParameters {
            urlComponents.queryItems = urlParameters.map {
                URLQueryItem(name: $0, value: String(describing: $1))
            }
        }

        guard let url = urlComponents.url else {
            throw NetworkError.parseUrlFail
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
