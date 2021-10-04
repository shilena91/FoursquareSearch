//
//  SearchVenuesVC+Tests.swift
//  FoursquareSearchTests
//
//  Created by Hoang Pham on 3.10.2021.
//

import XCTest
@testable import FoursquareSearch

class SearchVenuesVC_Tests: XCTestCase {
    
    private var searchVenuesVC: SearchVenuesViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let service = FoursquareService()
        searchVenuesVC = SearchVenuesViewController(service: service)
        
        let locationManager = MockLocationManager()
        let location = Location(latitude: Double(locationManager.location!.coordinate.latitude), longitude: Double(locationManager.location!.coordinate.longitude))
        
        searchVenuesVC.searchVenuesPresenter?.didUpdateLocation(location: location)
        
        let searchController = UISearchController()
        
        searchController.searchBar.delegate = searchVenuesVC
        searchVenuesVC.navigationItem.searchController = searchController
    }

    override func tearDownWithError() throws {
        searchVenuesVC = nil
        
        try super.tearDownWithError()
    }
    
    func testSearchBarDelegateNotNil() {
        XCTAssertNotNil(searchVenuesVC.navigationItem.searchController?.searchBar.delegate)
    }

    func testSearchTextWithWhitespaces() {
        let searchBar = searchVenuesVC?.navigationItem.searchController?.searchBar
        searchBar?.text = "  Burger King   "

        searchVenuesVC.searchBar(searchBar!, textDidChange: searchBar!.text!)
        
        XCTAssertEqual(searchVenuesVC.searchVenuesPresenter?.getSearchText(), searchBar?.text!.trimmingCharacters(in: .whitespaces))
    }
    
    func testSearchTextWithOnlyWhitespaces() {
        let searchBar = searchVenuesVC?.navigationItem.searchController?.searchBar
        searchBar?.text = "     "

        searchVenuesVC.searchBar(searchBar!, textDidChange: searchBar!.text!)
        
        XCTAssertEqual(searchVenuesVC.searchVenuesPresenter?.getSearchText()?.count, 0)
    }
}
