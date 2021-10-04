//
//  FoursquareRestRequest.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import Foundation

struct FoursquareRestRequest: RestRequestProtocol {
    let host: String
    let path: String
    let httpMethod: HTTPMethod
    let parameters: [String : String]
    
    init(host: String, path: String, httpMethod: HTTPMethod = .get, parameters: [String : String]) {
        self.host = host
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
    }
}

enum FoursquareAPIParameters {
    case clientId
    case clientSecret
    case version
    case coordinates(String)
    case query(String?)
    
    static func dictionaryFor(_ requestParameters: [FoursquareAPIParameters]) -> [String: String] {
        var parameters: [String: String] = [:]
        
        for param in requestParameters {
            switch param {
            case .clientId:
                parameters[FoursquareAPIParametersKey.clientID] = FoursquareAPIConstants.clientID
            case .clientSecret:
                parameters[FoursquareAPIParametersKey.clientSecret] = FoursquareAPIConstants.clientSecret
            case .version:
                parameters[FoursquareAPIParametersKey.version] = FoursquareAPIConstants.version
            case .coordinates(let coordinates):
                parameters[FoursquareAPIParametersKey.coordinate] = coordinates
            case .query(let query):
                parameters[FoursquareAPIParametersKey.query] = (query != nil) ? query : ""
            }
        }
        
        return parameters
    }
}
