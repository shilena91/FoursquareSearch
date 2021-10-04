//
//  FoursquareService.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import Foundation

final class FoursquareService: FoursquareServiceProtocol {
    
    func searchVenues(searchText: String?, coordinates: String, completion: @escaping (Result<SearchVenues, NetworkErrors>) -> Void) {
        let parameters: [String: String] = FoursquareAPIParameters.dictionaryFor(
            [
                .clientId,
                .clientSecret,
                .version,
                .coordinates(coordinates),
                .query(searchText)
            ]
        )
        
        let restRequest = FoursquareRestRequest(host: FoursquareAPIConstants.host, path: FoursquareAPIConstants.path, parameters: parameters)
        
        NetworkService.shared.get(restRequest: restRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let searchVenues = try FoursquareAPIMethod.searchVenues.parseJSON(data: data)
                    DispatchQueue.main.async {
                        completion(.success(searchVenues))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.parseJsonFailed(error)))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
