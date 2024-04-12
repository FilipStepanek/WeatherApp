//
//  TodayView-ViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 23.12.2023.
//

import Combine
import CoreLocation
import Factory
import SwiftUI

@MainActor
final class TodayViewModel: ObservableObject {
    @Published var isShareSheetPresented = false
    @Published var shouldReloaded = false
    @Published private(set) var state: State = .loading
    @Published var isConnected = true
    @Published var isPresented: Bool = false
    
    //MARK: - Injected weatherManager via Factory package manager - Dependency Injection
    @Injected(\.weatherManager) private var weatherManager
    @Injected(\.locationManager) private var locationManager
    
    var weatherManagerExtension = WeatherManagerExtension()
//    private(set) var locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    private var loadingTask: Task<Void, Never>?
    
    init() {
           setupBinding()
       }
    
    func setupBinding() {
        locationManager
            .location
            .compactMap{$0}
            .flatMap {
                self.getWeather(for: $0)
            }
            .sink { [weak self] location in
                self?.getWeather(for: location)
            }
            .store(in: &cancellables)
        
        locationManager
            .authorizationStatus
            .sink { [weak self] status in
                switch status {
                case .unknown:
                    break
                case .notDetermined:
                    self?.state = .missingLocation
                case .denied:
                    self?.state = .missingLocation
                case.locationGranted:
                    state = .succes(weatherManager.currentResponse)
                }
            }
    }
    
    func initialLoad() {
        guard locationManager.authorizationStatus == .locationGranted else {
            state = .missingLocation
            
            return
        }
    }
    
    func getWeather(for location: CLLocationCoordinate2D) -> some Publisher<CurrentResponse, any Error> {
        let publisher = PassthroughSubject<CurrentResponse, any Error>()
        Task {
            do {
                let response = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                publisher.send(response)
            } catch {
                publisher.send(completion: .failure(error))
            }
        }
        return publisher
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
