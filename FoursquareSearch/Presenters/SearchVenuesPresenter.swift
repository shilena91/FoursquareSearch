//
//  SearchVenuesPresenter.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import Foundation
import CoreLocation

// presenter link to searchVenues VC needs to confrom to this protocol
protocol SearchVenuesProtocol: LocationServiceDelegate {
    
    init(service: FoursquareServiceProtocol, viewController: SearchVenuesViewController)
    
    func searchVenues(with text: String?, appRunFirstTime: Bool)
    func numberOfItems() -> Int
    func getItem(atPosition position: Int) -> Venue
    func getLocation() -> Location?
    func getSearchText() -> String?
}

final class SearchVenuesPresenter: SearchVenuesProtocol {

    private var venues: [Venue] = []
    
    private var location: Location?
    private var searchText: String?
    weak var searchVenuesViewController: SearchVenuesViewController?

    // Depedencies Injection
    
    private let foursquareService: FoursquareServiceProtocol
    private let locationService = LocationService()

    
    init(service: FoursquareServiceProtocol, viewController: SearchVenuesViewController) {
        foursquareService = service
        searchVenuesViewController = viewController
        locationService.delegate = self
    }
    
    func searchVenues(with text: String?, appRunFirstTime: Bool = false) {
        guard let location = location else {
            return
        }
        
        searchText = text?.trimmingCharacters(in: .whitespaces)
        // Not calling API if search text only contains whitespaces
        if searchText?.count == 0 {
            return
        }
        
        if appRunFirstTime {
            searchVenuesViewController?.showLoadingView()
        }

        let coordinates = "\(location.latitude),\(location.longitude)"
        
        foursquareService.searchVenues(searchText: searchText, coordinates: coordinates) { [weak self] result in
            guard let self = self else { return }
            
            self.searchVenuesViewController?.dismissLoadingView()
            
            switch result {
            case .success(let searchVenues):
                self.venues = searchVenues.venues
                self.searchVenuesViewController?.showingNewSearchs()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfItems() -> Int {
        return venues.count
    }
    
    func getItem(atPosition position: Int) -> Venue {
        return venues[position]
    }
    
    func getLocation() -> Location? {
        return location
    }
    
    func getSearchText() -> String? {
        return searchText
    }
}

// MARK: - extension SearchVenuesPresenter with LocationServiceDelegate

extension SearchVenuesPresenter {
    
    func didUpdateLocation(location: Location) {
        self.location = location
        searchVenues(with: nil, appRunFirstTime: true)
    }
    
    func getAuthorizationStatus(status: CLAuthorizationStatus) {
        if status == .denied {
            searchVenuesViewController?.showAlert(message: "The app can't find your location. Please enable location service in settings")
        } 
    }
}
