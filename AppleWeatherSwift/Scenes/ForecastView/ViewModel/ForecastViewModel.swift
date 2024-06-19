//
//  ForecastViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 08.01.2024.
//

import Combine
import CoreLocation
import Factory
import OSLog
import Shared 

@MainActor
final class ForecastViewModel: ObservableObject {
    @Published var shouldReloaded = false
    @Published private(set) var state: State = .loading
    
    // Publisher for signaling data fetching completion
    private let dataFetchCompletion = PassthroughSubject<Void, Never>()
    
    //MARK: - Injected weatherManager via Factory package manager - Dependency Injection
    @Injected(\.weatherManager) private var weatherManager
    @Injected(\.locationManager) private var locationManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Logger.networking.debug("ForecastViewModel initialized")
        setupBinding()
    }
    
    func setupBinding() {
        locationManager
            .location
            .compactMap{$0}
            .sink { [weak self] location in
                self?.getForecast(for: location)
            }
            .store(in: &cancellables)
        
        locationManager
            .authorizationStatus
            .sink { [weak self] status in
                switch status {
                case.locationGranted:
                    self?.locationManager.requestLocation()
                default:
                    self?.state = .missingLocation
                }
            }
            .store(in: &cancellables)
    }
    
    func getForecast(for location: CLLocationCoordinate2D, setLoadingState: Bool = true) {
        if setLoadingState {
            state = .loading
        }
        
        Task {
            do {
                let forecastResponse = try await weatherManager.getForecastWeather(
                    latitude: location.latitude,
                    longitude: location.longitude)
                
                let currentResponse = try await weatherManager.getCurrentWeather(
                    latitude: location.latitude,
                    longitude: location.longitude)
                
                state = .success(forecastResponse, currentResponse)
            } catch {
                if case NetworkError.noInternetConnection = error {
                    state = .errorNetwork(error.localizedDescription)
                } else {
                    state = .error(error.localizedDescription)
                }
            }
            
            // Signal data fetching completion
            dataFetchCompletion.send(())
        }
    }
    
    func onRefresh() {
        Logger.networking.info("onRefresh called for Forecast")
        
        // Add a delay before requesting location and fetching weather data
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
            
            // Request new location
            locationManager.requestLocation()
            
            // Immediately fetch weather with the last known location if available, without setting loading state
            if let lastLocation = locationManager.lastLocation?.coordinate {
                Logger.networking.info("onResfersh - location is same for Forecast")
                getForecast(for: lastLocation, setLoadingState: false)
            }
        }
    }
    
    // Publisher to signal data fetching completion
    func dataFetchCompletionPublisher() -> AnyPublisher<Void, Never> {
        dataFetchCompletion.eraseToAnyPublisher()
    }
}

// MARK: - State
extension ForecastViewModel {
    enum State {
        case loading
        case missingLocation
        case success(ForecastResponse, CurrentResponse)
        case error(String)
        case errorNetwork(String)
    }
}
