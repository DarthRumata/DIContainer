//
//  BooksListCoordinator.swift
//  Test2
//
//  Created by Stas Kirichok on 16.11.2021.
//

import Foundation
import UIKit
import DIContainer

struct BookListModule {
    private let container: DependencyContainer
    
    init(parentContainer: DependencyContainer) {
        container = DependencyContainer(parent: parentContainer)
        container.register(BookNetworkService.self) { resolver in
            return BookNetworkService(networkService: resolver.resolve(NetworkService.self))
        }
        container.register(BooksRepository.self) { resolver in
            return BooksRepository(booksNetworkService: resolver.resolve(BookNetworkService.self))
        }
        container.register(BooksListViewModel.self, in: .transient) { resolver in
            return BooksListViewModel(repository: resolver.resolve(BooksRepository.self))
        }
    }
    
    func make() -> UIViewController {
        let storyboard = UIStoryboard(name: "BooksList", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! BooksListViewController
        controller.viewModel = container.resolve(BooksListViewModel.self)
        return controller
    }
}

class BooksListCoordinator {
    private let module: BookListModule
    
    init(parentContainer: DependencyContainer) {
       module = BookListModule(parentContainer: parentContainer)
    }
    
    func makeBooksListFlow() -> UIViewController {
        return module.make()
    }
}
