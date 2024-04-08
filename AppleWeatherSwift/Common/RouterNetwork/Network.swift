//
//  Network.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 03.04.2024.
//

import Foundation
import Network

class Network {
    static let shared = Network()
    
    private let config: URLSessionConfiguration
    private let session: URLSession
    lazy var decoder: JSONDecoder = {return JSONDecoder()}()
    
    private init() {
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func request<T: Decodable>(router: Router) async throws -> T {

        let (data, response) = try await session.data(for: router.asRequest())
            
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
