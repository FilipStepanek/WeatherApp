//
//  NetworkManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 19.01.2024.
//

//import Foundation
//import Network
//
//class NetworkManager: ObservableObject {
//    let monitor = NWPathMonitor()
//    let queue = DispatchQueue(label: "NetworkManager")
//    @Published var isConnected = true
//    
//    init() {
//        monitor.pathUpdateHandler = { path in
//            DispatchQueue.main.async {
//                self.isConnected = path.status == .satisfied
//            }
//        }
//        
//        monitor.start(queue: queue)
//    }
//}

import Foundation
import Network

class NetworkManager {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func fetchData(with request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        guard isConnected else {
            completion(.failure(NetworkError.noInternetConnection))
            return
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if response.statusCode == 200 {
                // Save data to UserDefaults with App Group identifier
                if let appGroupUserDefaults = UserDefaults(suiteName: "group.stepanek.weatherapp") {
                    appGroupUserDefaults.set(data, forKey: "currentResponseData")
                }
                completion(.success(data))
            } else {
                completion(.failure(NetworkError.statusCode(response.statusCode)))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case noInternetConnection
    case invalidResponse
    case statusCode(Int)
}
