//
//  WeatherProvider.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.04.2024.
//


import WidgetKit
import SwiftUI
import Combine
import Factory
import CoreLocation
import Foundation

struct WeatherProvider: TimelineProvider {
    
    //MARK: - Injected weatherManager via Factory package manager - Dependency Injection
    @Injected(\.weatherManager) private var weatherManager
    @Injected(\.locationManager) private var locationManager
    
    var cancellables = Set<AnyCancellable>()
    var weatherManagerExtensionWidget = WeatherManagerExtensionWidget()
    var location: CLLocationCoordinate2D?
    
    // Placeholder, return a placeholder entry
    func placeholder(in context: Context) -> SimpleEntry {
        .placeholder
    }
    
    // Get a snapshot, return a getSnapshot entry
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        completion(SimpleEntry.getSnapshot)
    }
    
    init() {
        setupBinding()
    }
    
    mutating func setupBinding() {
        locationManager
            .location 
            .compactMap { $0 }
            .sink { location in
                UserDefaults.standard.set("\(location.latitude),\(location.longitude)", forKey: "widgetLocation")
            }
            .store(in: &cancellables)
        
        locationManager
            .authorizationStatus
            .sink { [self] status in
                switch status {
                case .locationGranted:
                    locationManager.requestLocation()
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        // Implement the getTimeline function using the provided context
        guard let location = location else {
            let entry = SimpleEntry(date: Date(), temperature: 0, icon: Image(systemName: "photo.circle.fill"), location: "Unknown")
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
            return
        }
        
        let currentDate = Date()
        
        Task {
            var entries: [SimpleEntry] = []
            
            do {
                let response = try await weatherManager.getCurrentWeather(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
                let icon = Image(systemName: response.weather.first?.icon ?? "photo.circle.fill")
                let entry = SimpleEntry(date: currentDate, temperature: response.main.temp, icon: icon, location: response.name)
                entries.append(entry)
                
                // Consider setting next update based on weather data refresh rate
                let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
                let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
                completion(timeline)
            } catch {
                let icon = Image(systemName: "photo.circle.fill")
                let entry = SimpleEntry(date: currentDate, temperature: 0, icon: icon, location: "Unknown")
                let timeline = Timeline(entries: [entry], policy: .atEnd)
                completion(timeline)
            }
        }
    }
}



