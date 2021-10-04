//
//  FoursquareServiceProtocol.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 2.10.2021.
//

import Foundation

// Network service class needs to confront to this protocol
protocol FoursquareServiceProtocol {
    func searchVenues(searchText: String?, coordinates: String, completion: @escaping (Result<SearchVenues, NetworkErrors>) -> Void)
}
