//
//  LocationService.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(location: Location)
    func getAuthorizationStatus(status: CLAuthorizationStatus)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    
    private var locationManager: LocationManager!
    weak var delegate: LocationServiceDelegate?
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if location.horizontalAccuracy > 0 {
                locationManager.stopUpdatingLocation()
                let updatedLocation = Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                delegate?.didUpdateLocation(location: updatedLocation)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .notDetermined {
            delegate?.getAuthorizationStatus(status: status)
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
