//
//  RestRequestProtocol.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import Foundation

// RestRequest Model has to confrom to this protocol
protocol RestRequestProtocol {
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: String] { get }
}
