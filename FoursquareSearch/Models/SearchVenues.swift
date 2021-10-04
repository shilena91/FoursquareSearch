//
//  SearchVenues.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import Foundation

// API response: https://developer.foursquare.com/docs/api-reference/venues/search/

struct SearchVenues: Decodable {
    let venues: [Venue]
    
    enum CodingKeys: String, CodingKey {
        case response = "response"
        case venues = "venues"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
        venues = try response.decode([Venue].self, forKey: .venues)
    }
}

struct Venue: Decodable {
    let name: String
    let address: [String]
    let distance: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case location = "location"
        case address = "formattedAddress"
        case distance = "distance"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        let location = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        
        address = try location.decode([String].self, forKey: .address)
        distance = try location.decode(Int.self, forKey: .distance)
    }
}
