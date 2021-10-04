//
//  FoursquareService+Tests.swift
//  FoursquareSearchTests
//
//  Created by Hoang Pham on 4.10.2021.
//

import XCTest
@testable import FoursquareSearch

class FoursquareService_Tests: XCTestCase {

    func testBuildGetInvalidRequestURL() {
        let restRequest = FoursquareRestRequest(host: FoursquareAPIConstants.invalidHostForTesting, path: FoursquareAPIConstants.invalidPathForTesting, parameters: [:])
        
        let invalidRequest = NetworkService.shared.buildRequestURL(from: restRequest)
        
        switch invalidRequest {
        case .success(_):
            XCTAssertThrowsError("Building URL request should have failed")
        case .failure(let error):
            let debugMsg = NetworkErrors.invalidURL.debugDescription
            XCTAssertEqual(error.debugDescription, debugMsg)
        }
    }
    
    func testBuildVenuesSearchRequestURL() {
        let locationManager = MockLocationManager()
        let location = Location(latitude: Double(locationManager.location!.coordinate.latitude), longitude: Double(locationManager.location!.coordinate.longitude))
        let coordinates = "\(location.latitude),\(location.longitude)"
        
        let parameters: [String: String] = FoursquareAPIParameters.dictionaryFor(
            [
                .clientId,
                .clientSecret,
                .coordinates(coordinates),
                .version
            ]
        )
        
        let restRequest = FoursquareRestRequest(host: FoursquareAPIConstants.host, path: FoursquareAPIConstants.path, parameters: parameters)
        
        let validRequest = NetworkService.shared.buildRequestURL(from: restRequest)
        
        switch validRequest {
        case .success(let request):
            XCTAssertEqual(request.httpMethod, "GET")
            XCTAssertNotNil(request.url)
        case .failure(_):
            XCTAssertThrowsError("Building URL request should have passed")
        }
    }

    func testDecodeVenuesModel() {
        let file = Bundle(for: FoursquareService_Tests.self).url(forResource: "mockVenuesModel", withExtension: "json")
        
        let data = try! Data(contentsOf: file!)
        
        do {
            let decoded = try FoursquareAPIMethod.searchVenues.parseJSON(data: data)
            XCTAssertEqual(decoded.venues.count, 6)
            XCTAssertEqual((decoded.venues.first! as Venue).name, "Maltainen Riekko")
        } catch {
            print(error)
            XCTAssertThrowsError("Decoding should have passed")
        }
    }

}
