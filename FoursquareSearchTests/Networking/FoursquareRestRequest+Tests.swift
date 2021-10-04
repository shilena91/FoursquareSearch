//
//  FoursquareRestRequest+Tests.swift
//  FoursquareSearchTests
//
//  Created by Hoang Pham on 4.10.2021.
//

import XCTest
@testable import FoursquareSearch

class FoursquareRestRequest_Tests: XCTestCase {

    func testParameters() {
        let locationManager = MockLocationManager()
        let coordinates = locationManager.getUpdatedLocationString()
        
        let parameters: [String: String] = FoursquareAPIParameters.dictionaryFor(
            [
                .clientId,
                .clientSecret,
                .coordinates(coordinates),
                .query("Burger"),
                .version
            ]
        )
        
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters[FoursquareAPIParametersKey.clientID], FoursquareAPIConstants.clientID)
        XCTAssertEqual(parameters[FoursquareAPIParametersKey.query], "Burger")
    }

}
