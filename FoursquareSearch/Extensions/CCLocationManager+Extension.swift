//
//  CCLocationManager+Extension.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 3.10.2021.
//

import CoreLocation

protocol LocationManager {
    var location: CLLocation? { get }
    var delegate: CLLocationManagerDelegate? { get set }
    
    func requestWhenInUseAuthorization()
    func requestAlwaysAuthorization()
    
    func startUpdatingLocation()
    func stopUpdatingLocation()
        
    func getAuthorizationStatus() -> CLAuthorizationStatus
}

extension CLLocationManager: LocationManager {
    
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
}
