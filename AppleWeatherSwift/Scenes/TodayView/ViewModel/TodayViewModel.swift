//
//  TodayView-ViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 23.12.2023.
//

//import Combine
//import CoreLocation
//import Factory
//import OSLog
//
//@MainActor
//final class TodayViewModel: ObservableObject {
//    @Published var isShareSheetPresented = false
//    @Published var shouldReloaded = false
//    @Published var isConnected = true
//    @Published var isPresented: Bool = false
//    @Published private(set) var state: State = .loading
//    
//    // MARK: - Injected weatherManager via Factory package manager - Dependency Injection
//    @Injected(\.weatherManager) private var weatherManager
//    @Injected(\.locationManager) private var locationManager
//    
//    var weatherManagerExtension = WeatherManagerExtension()
//    private var cancellables = Set<AnyCancellable>()
//    
//    init() {
//        Logger.networking.debug("TodayViewModel initialized")
//        setupBinding()
//    }
//    
//    func setupBinding() {
//        locationManager
//            .location
//            .compactMap { $0 }
//            .sink { [weak self] location in
//                self?.getWeather(for: location)
//            }
//            .store(in: &cancellables)
//        
//        locationManager
//            .authorizationStatus
//            .sink { [weak self] status in
//                switch status {
//                case .locationGranted:
//                    self?.locationManager.requestLocation()
//                default:
//                    self?.state = .missingLocation
//                }
//            }
//            .store(in: &cancellables)
//    }
//    
//    func getWeather(for location: CLLocationCoordinate2D, setLoadingState: Bool = true) {
//        if setLoadingState {
//            state = .loading
//        }
//        
//        Task {
//            do {
//                Logger.networking.debug("Calling getCurrentWeather for location: \(location.latitude), \(location.longitude)")
//                let response = try await weatherManager.getCurrentWeather(
//                    latitude: location.latitude,
//                    longitude: location.longitude
//                )
//                state = .success(response)
//                Logger.networking.debug("Successfully fetched weather data")
//            } catch {
//                if case NetworkError.noInternetConnection = error {
//                    Logger.networking.error("Network error: \(error.localizedDescription)")
//                    state = .errorNetwork(error.localizedDescription)
//                } else {
//                    Logger.networking.error("Error fetching weather: \(error.localizedDescription)")
//                    state = .error(error.localizedDescription)
//                }
//            }
//        }
//    }
//    
//    func onRefresh() {
//        Logger.networking.info("onRefresh called for Today")
//        
//        // Add a delay before requesting location and fetching weather data
//        Task {
//            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
//            
//            // Request new location
//            locationManager.requestLocation()
//            
//            // Immediately fetch weather with the last known location if available, without setting loading state
//            if let lastLocation = locationManager.lastLocation?.coordinate {
//                Logger.networking.info("onResfersh - location is same for Today")
//                getWeather(for: lastLocation, setLoadingState: false)
//            }
//        }
//    }
//}
//
//// MARK: - State
//extension TodayViewModel {
//    enum State {
//        case loading
//        case missingLocation
//        case success(CurrentResponse)
//        case error(String)
//        case errorNetwork(String)
//    }
//}
//

import Combine
import CoreLocation
import Factory
import OSLog

@MainActor
final class TodayViewModel: ObservableObject {
    @Published var isShareSheetPresented = false
    @Published var shouldReloaded = false
    @Published var isConnected = true
    @Published var isPresented: Bool = false
    @Published private(set) var state: State = .loading
    
    // MARK: - Injected weatherManager via Factory package manager - Dependency Injection
    @Injected(\.weatherManager) private var weatherManager
    @Injected(\.locationManager) private var locationManager
    
    var weatherManagerExtension = WeatherManagerExtension()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Logger.networking.debug("TodayViewModel initialized")
        setupBinding()
    }
    
    func setupBinding() {
        locationManager
            .location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.getWeather(for: location)
            }
            .store(in: &cancellables)
        
        locationManager
            .authorizationStatus
            .sink { [weak self] status in
                switch status {
                case .locationGranted:
                    self?.locationManager.requestLocation()
                default:
                    self?.state = .missingLocation
                }
            }
            .store(in: &cancellables)
    }
    
    func getWeather(for location: CLLocationCoordinate2D, setLoadingState: Bool = true) {
        if setLoadingState {
            state = .loading
        }
        
        Task {
            do {
                Logger.networking.debug("Calling getCurrentWeather for location: \(location.latitude), \(location.longitude)")
                let response = try await weatherManager.getCurrentWeather(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
                state = .success(response)
                Logger.networking.debug("Successfully fetched weather data")
            } catch {
                if case NetworkError.noInternetConnection = error {
                    Logger.networking.error("Network error: \(error.localizedDescription)")
                    state = .errorNetwork(error.localizedDescription)
                } else {
                    Logger.networking.error("Error fetching weather: \(error.localizedDescription)")
                    state = .error(error.localizedDescription)
                }
            }
        }
    }
    
    func onRefresh() {
        Logger.networking.info("onRefresh called for Today")
        
        // Add a delay before requesting location and fetching weather data
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
            
            // Request new location
            locationManager.requestLocation()
            
            // Immediately fetch weather with the last known location if available, without setting loading state
            if let lastLocation = locationManager.lastLocation?.coordinate {
                Logger.networking.info("onResfersh - location is same for Today")
                getWeather(for: lastLocation, setLoadingState: false)
            }
        }
    }
}

// MARK: - State
extension TodayViewModel {
    enum State {
        case loading
        case missingLocation
        case success(CurrentResponse)
        case error(String)
        case errorNetwork(String)
    }
}
