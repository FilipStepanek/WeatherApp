//
//  LocationManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.12.2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    @Published var status: Status = .unknown
    
    enum Status {
        case locationGranted
        case unknown
        case denied
    }
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    // MARK: - Request Location
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    // MARK: - Request Location Permission
    func requestLocationRemission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Handle authorized status
            print("Location authorization granted")
            self.status = .locationGranted
            requestLocation()
        case .denied, .restricted:
            // Handle denied or restricted status
            print("Location authorization denied or restricted")
            self.status = .denied
        case .notDetermined:
            // Handle not determined status
            print("Location authorization not determined")
            self.status = .unknown
            requestLocation()
            
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            print("Location Manager Error: \(clError.errorCode) - \(clError.localizedDescription)")
        } else {
            print("Generic Location Manager Error: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func stopLocationUpdates() {
        manager.stopUpdatingLocation()
    }
}
