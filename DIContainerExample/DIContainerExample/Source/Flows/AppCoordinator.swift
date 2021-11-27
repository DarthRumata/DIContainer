//
//  AppCoordinator.swift
//  DIContainerExample
//
//  Created by Stas Kirichok on 27.11.2021.
//

import Foundation
import DIContainer

class AppCoordinator {
    private let appContainer = DependencyContainer()
    private let basePath = "https://www.googleapis.com/books/v1"
    
    private unowned var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
        configureDependecies()
    }
    
    func start() {
        let coordinator = BooksListCoordinator(parentContainer: appContainer)
        let controller = coordinator.makeBooksListFlow()
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}

private extension AppCoordinator {
    private func configureDependecies() {
        appContainer.register(NetworkService.self, in: .container) { [basePath] _ in
            guard let url = URL(string: basePath) else {
                fatalError()
            }
            return NetworkService(baseURL: url)
        }
    }
}
