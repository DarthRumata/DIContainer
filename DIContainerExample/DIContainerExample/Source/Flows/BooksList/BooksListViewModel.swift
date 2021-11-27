//
//  BooksListViewModel.swift
//  Test2
//
//  Created by Stas Kirichok on 16.11.2021.
//

import Foundation
import Combine

class BooksListViewModel {
    private let repository: BooksRepository
    
    // Input
    lazy var onViewDidLoad = Subscribers.Sink<Void, Never> { _ in
        
    } receiveValue: { [weak self] in
        self?.reloadBooks()
    }
    
    // Output
    var books: AnyPublisher<[Book], Never> {
        return booksSubject.eraseToAnyPublisher()
    }
    
    // State
    private let booksSubject = PassthroughSubject<[Book], Never>()
    
    init(repository: BooksRepository) {
        self.repository = repository
    }
    
    private func reloadBooks() {
        repository.getBookList { [weak self] books in
            DispatchQueue.main.async {
                self?.booksSubject.send(books)
            }
        }
    }
}
