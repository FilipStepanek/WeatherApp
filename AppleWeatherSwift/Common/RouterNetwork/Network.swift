//
//  Network.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 03.04.2024.
//

import Foundation
import Network
import OSLog

class Network {
    static let shared = Network()
    
    private let config: URLSessionConfiguration
    private let session: URLSession
    lazy var decoder: JSONDecoder = {return JSONDecoder()}()
    
    private init() {
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func handleNetworkError(_ error: Error) -> Error {
        if let urlError = error as? URLError {
            if urlError.code == .notConnectedToInternet {
                Logger.networking.error("No internet connection")
                return NetworkError.noInternetConnection
            }
        }
        return NetworkError.defaultError
    }
    
    func request<T: Decodable>(router: Router) async throws -> T {
        Logger.networking.debug("---\(String(describing: try? router.asRequest()))")
        
        let (data, response) = try await session.data(for: router.asRequest())
        
        guard let httpResponse = response as? HTTPURLResponse,
              let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode),
              router.acceptableStatusCodes?.contains(statusCode) ?? (HTTPStatusCode.ok == statusCode) else {
            
            // TODO: lognout status code jako error
            throw NetworkError.invalidResponse
        }
        return try decoder.decode(T.self, from: data)
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
