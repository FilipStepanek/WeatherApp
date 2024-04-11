//
//  TodayView-ViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 23.12.2023.
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
    @Published var isPresented: Bool = false
    
    //MARK: - Injected weatherManager via Factory package manager - Dependency Injection
    @Injected(\.weatherManager) private var weatherManager

    var weatherManagerExtension = WeatherManagerExtension()
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
        
        getWeather(for: location)
    }
    
    func setupBinding() {
        locationManager.$location
            .compactMap { $0 }
            .sink { location in
                print(location)
                self.getWeather(for: location)
            }
            .store(in: &cancellables)
    }
    
    func getWeather(for location: CLLocationCoordinate2D) {
        state = .loading
        loadingTask = Task {
            do {
                let response = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
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
