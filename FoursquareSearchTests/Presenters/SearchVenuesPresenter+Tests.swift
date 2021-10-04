//
//  SearchVenuesPresenter+Tests.swift
//  FoursquareSearchTests
//
//  Created by Hoang Pham on 3.10.2021.
//

import XCTest
import CoreLocation
@testable import FoursquareSearch

class SearchVenuesPresenter_Tests: XCTestCase {

    private var searchVenuesPresenter: SearchVenuesProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let service = FoursquareService()
        
        let viewController = SearchVenuesViewController(service: service)
        
        searchVenuesPresenter = SearchVenuesPresenter(service: service, viewController: viewController)
    }

    override func tearDownWithError() throws {
        searchVenuesPresenter = nil
        try super.tearDownWithError()
    }
    
    func testUpdatedLocation() {
        let locationManager = MockLocationManager()
        let updatedLocation = Location(latitude: Double(locationManager.location!.coordinate.latitude), longitude: Double(locationManager.location!.coordinate.longitude))
        
        searchVenuesPresenter.didUpdateLocation(location: updatedLocation)
        
        XCTAssertEqual(searchVenuesPresenter.getLocation(), updatedLocation)
    }
    
    func testSearchVenuesWhenAppOpen() {
        let locationManager = MockLocationManager()
        let updatedLocation = Location(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
        
        searchVenuesPresenter.didUpdateLocation(location: updatedLocation)
        searchVenuesPresenter.searchVenues(with: nil, appRunFirstTime: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertTrue(self.searchVenuesPresenter.numberOfItems() > 0)
        }
    }
    
    func testDumbSearchText() {
        let locationManager = MockLocationManager()
        let updatedLocation = Location(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude)
        
        searchVenuesPresenter.didUpdateLocation(location: updatedLocation)
        searchVenuesPresenter.searchVenues(with: "$*%/%?%?", appRunFirstTime: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            XCTAssertTrue(self.searchVenuesPresenter.numberOfItems() == 0)
        }
    }
}
