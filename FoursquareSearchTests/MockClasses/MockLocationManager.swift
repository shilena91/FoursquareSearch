//
//  MockLocationManager.swift
//  FoursquareSearchTests
//
//  Created by Hoang Pham on 4.10.2021.
//

import CoreLocation
@testable import FoursquareSearch

final class MockLocationManager: LocationManager {
        
    var delegate: CLLocationManagerDelegate?
    var location: CLLocation? = CLLocation(latitude: 60.192059, longitude: 24.945831) // Helsinki's coordinate
    
    func requestWhenInUseAuthorization() {}
    
    func requestAlwaysAuthorization() {}
        
    func startUpdatingLocation() {}
    
    func stopUpdatingLocation() {}
    
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return .authorizedWhenInUse
    }
    
    func getUpdatedLocationString() -> String {
        let updatedLocation = Location(latitude: Double(location!.coordinate.latitude), longitude: Double(location!.coordinate.longitude))
        
        let coordinates = "\(updatedLocation.latitude),\(updatedLocation.longitude)"
        
        return coordinates
    }
}
