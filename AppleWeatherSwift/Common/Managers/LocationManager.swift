//
//  LocationManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.12.2023.
//

import Foundation
import CoreLocation
import OSLog
import Combine

enum Status {
    case locationGaranted
    case unknown
    case denied
    case notDetermined
}

protocol LocationManaging {
    var location: PassthroughSubject<CLLocationCoordinate2D?, Never> { get }
    var authorizationStatus: PassthroughSubject<Status, Never> { get }
    
    func requestLocation()
    func requestLocationRemission()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
}

class LocationManager: NSObject, LocationManaging, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    var location: PassthroughSubject<CLLocationCoordinate2D?, Never> = .init()
    var authorizationStatus: PassthroughSubject<Status, Never> = .init()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        handleStatus(status: manager.authorizationStatus)
    }
    
    // MARK: - Request Location
    func requestLocation() {
        manager.requestLocation()
    }
    // MARK: - Request Location Permission
    func requestLocationRemission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location.send(locations.first?.coordinate)
    }
    
    func handleStatus(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Handle authorized status
            Logger.networking.info("Location authorization granted")
            authorizationStatus.send(.locationGaranted)
        case .denied, .restricted:
            // Handle denied or restricted status
            Logger.networking.info("Location authorization denied or restricted")
            authorizationStatus.send(.denied)
        case .notDetermined:
            // Handle not determined status
            Logger.networking.info("Location authorization not determined")
            authorizationStatus.send(.unknown)
            
        @unknown default:
            authorizationStatus.send(.unknown)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleStatus(status: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            Logger.networking.info("Location Manager Error: \(clError.errorCode) - \(clError.localizedDescription)")
        } else {
            Logger.networking.info("Generic Location Manager Error: \(error.localizedDescription)")
        }
    }
}
