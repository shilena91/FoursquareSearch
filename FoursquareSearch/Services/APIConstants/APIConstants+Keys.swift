//
//  APIConstants+Keys.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import Foundation

// please put your own clientID and clientSecret before running the app

enum FoursquareAPIConstants {
    static let clientID = ""
    static let clientSecret = ""
    // Version is "YYYYMMDD" form, should be increased frequently
    static let version = "20210829"
    static let host = "api.foursquare.com"
    static let path = "/v2/venues/search"
    static let invalidHostForTesting = "api.bad.com"
    static let invalidPathForTesting = "bad"
}

enum FoursquareAPIParametersKey {
    static let clientID = "client_id"
    static let clientSecret = "client_secret"
    static let version = "v"
    static let coordinate = "ll"
    static let query = "query"
}
