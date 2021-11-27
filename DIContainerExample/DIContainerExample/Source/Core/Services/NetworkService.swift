//
//  NetworkService.swift
//  DIContainerExample
//
//  Created by Stas Kirichok on 27.11.2021.
//

import Foundation

class NetworkService {
    private let baseURL: URL
    private let session: URLSession
    
    init(baseURL: URL) {
        self.baseURL = baseURL
        
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func get<ResponseObject: Decodable>(path: String, parameters: [String: String], completion: @escaping (ResponseObject) -> Void) {
        DispatchQueue.global().async {
            let queryItems = parameters.map({ URLQueryItem(name: $0, value: $1) })
            let endpointURL = self.baseURL.appendingPathComponent(path)
            var urlComponents = URLComponents(string: endpointURL.absoluteString)
            urlComponents?.queryItems = queryItems
            
            guard let url = urlComponents?.url else {
                print(endpointURL.absoluteString)
                return
            }
            
            let task = self.session.dataTask(with: url) { data, _, _ in
                guard let data = data else {
                    return
                }
                do {
                    let response = try JSONDecoder().decode(ResponseObject.self, from: data)
                    completion(response)
                } catch let error {
                    print(error)
                }
            }
            task.resume()
        }
    }
}
