//
//  ForecastViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 08.01.2024.
//

import Combine
import CoreLocation
import Factory

@MainActor
final class ForecastViewModel: ObservableObject {
    @Published var shouldReloaded = false
    @Published private(set) var state: State = .loading
    
    //MARK: - Injected weatherManager via Factory package manager - Dependency Injection
    @Injected(\.weatherManager) private var weatherManager
    
    private(set) var locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    private var loadingTask: Task<Void, Never>?
    
    init() {
        setupBinding()
    }
    
    func initialLoad() {
        guard locationManager.status == .locationGranted else {
            state = .missingLocation
            
            return
        }
    }
    
    func onRefresh() {
        guard locationManager.status == .locationGranted else {
            state = .missingLocation
            
            return
        }
        guard let location = locationManager.location else {
            
            return
        }
        getForecast(for: location)
    }
    
    func setupBinding() {
        locationManager.$location
            .compactMap { $0 }
            .sink { location in
                print(location)
                self.getForecast(for: location)
            }
            .store(in: &cancellables)
    }
    
    func getForecast(for location: CLLocationCoordinate2D) {
        loadingTask = Task {
            do {
                let forecastResponse = try await weatherManager.getForecastWeather(latitude: location.latitude, longitude: location.longitude)
                                
                let currentResponse = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                
                state = .success(forecastResponse, currentResponse)

            } catch {
                if case GHError.noInternetConnection = error {
                    return state = .errorNetwork(error.localizedDescription)
                } else {
                    return state = .error(error.localizedDescription)
                }
            }
        }
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
