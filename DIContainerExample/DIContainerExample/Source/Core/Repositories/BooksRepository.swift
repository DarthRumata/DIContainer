//
//  BooksRepository.swift
//  Test2
//
//  Created by Stas Kirichok on 16.11.2021.
//

import Foundation

class BooksRepository {
    private let booksNetworkService: BookNetworkService
    
    init(booksNetworkService: BookNetworkService) {
        self.booksNetworkService = booksNetworkService
    }
    
    func getBookList(completion: @escaping ([Book]) -> Void) {
        return booksNetworkService.getBookList(completion: completion)
    }
}
