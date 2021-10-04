//
//  FoursquareAPIMethod.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import Foundation

enum FoursquareAPIMethod {
    case searchVenues
    
    func parseJSON(data: Data) throws -> SearchVenues {
        switch self {
        case .searchVenues:
            return try JSONDecoder().decode(SearchVenues.self, from: data)
        }
    }
}
