//
//  TodayViewModel.swift
//  WeatherAppAppleWatch Watch App
//
//  Created by Filip Štěpánek on 12.02.2024.
//

import Combine
import CoreLocation
import Factory

@MainActor
final class TodayViewModel: ObservableObject {
    @Published var isShareSheetPresented = false
    @Published var shouldReloaded = false
    @Published private(set) var state: State = .loading
    @Published var isConnected = true
    
    //MARK: - Injected weatherManager via Factory package manager - Dependency Injection
    @Injected(\.weatherManager) private var weatherManager
    @Injected(\.locationManager) private var locationManager
   
    var weatherManagerExtension = WeatherManagerExtension()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
           setupBinding()
    }
    
    func setupBinding() {
        locationManager
            .location
            .compactMap{$0}
            .sink { [weak self] location in
                self?.getWeather(for: location)
            }
            .store(in: &cancellables)
        
        locationManager
            .authorizationStatus
            .sink { [weak self] status in
                switch status {
                case.locationGaranted:
                    self?.locationManager.requestLocation()
                default:
                    self?.state = .missingLocation
                }
            }
            .store(in: &cancellables)
    }
    
    func getWeather(for location: CLLocationCoordinate2D) {
        state = .loading
        
        Task {
            do {
                let response = try await weatherManager.getCurrentWeather(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
                state = .succes(response)
            } catch {
                if case NetworkError.noInternetConnection = error {
                    return state = .errorNetwork(error.localizedDescription)
                } else {
                    return state = .error(error.localizedDescription)
                }
            }
        }
    }
    
    func onRefresh() {
        locationManager.requestLocation()
    }
}


// MARK: - State
extension TodayViewModel {
    enum State {
        case loading
        case missingLocation
        case succes(CurrentResponse)
        case error(String)
        case errorNetwork(String)
    }
}

