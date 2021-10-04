//
//  NetworkService.swift
//  FoursquareSearch
//
//  Created by Hoang Pham on 28.9.2021.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func get<T: RestRequestProtocol>(restRequest: T, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
        let request = buildRequestURL(from: restRequest)
        
        switch request {
        case .success(let request):
            sendRequest(request: request) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func buildRequestURL<T: RestRequestProtocol>(from restRequest: T) -> Result<URLRequest, NetworkErrors> {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = restRequest.host
        urlComponents.path = restRequest.path
        
        let parameters = restRequest.parameters
        
        let queryItems = parameters.map { (key, value) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        print(url)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = restRequest.httpMethod.rawValue
        
        return .success(urlRequest)
    }
    
    private func sendRequest(request: URLRequest, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.unableToComplete(error!)))
            }
            
            if let response = response as? HTTPURLResponse {
                let code = response.statusCode
                if !(200...299 ~= code) {
                    completion(.failure(.httpError(statusCode: code)))
                    return
                }
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
