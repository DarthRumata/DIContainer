//
//  BookNetworkService.swift
//  Test2
//
//  Created by Stas Kirichok on 16.11.2021.
//

import Foundation

struct BookNetworkService {
    private let path = "volumes"
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getBookList(completion: @escaping ([Book]) -> Void) {
        networkService.get(path: path, parameters: ["q": "search+terms"]) { (response: BookResponse) in
            completion(response.items)
        }
    }
}
