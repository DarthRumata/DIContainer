//
//  DependencyEntry.swift
//  DIContainer
//
//  Created by Stas Kirichok on 17.09.2020.
//  Copyright © 2020 Stas Kirichok. All rights reserved.
//

import Foundation

protocol DependencyEntryProtocol: AnyObject {
    func getInstance<StoredDependency>(using resolver: Resolver) -> StoredDependency?
    func resetCache()
}

class DependencyEntry<Dependency>: DependencyEntryProtocol {
    private var instance: Dependency?
    private let factory: (Resolver) -> Dependency
    private let scope: ContainerObjectScope

    init(factory: @escaping (Resolver) -> Dependency, scope: ContainerObjectScope) {
        self.factory = factory
        self.scope = scope
    }

    func getInstance<Dependency>(using resolver: Resolver) -> Dependency? {
        if scope == .transient {
            return factory(resolver) as? Dependency
        }
        
        guard let instance = instance as? Dependency else {
            let service = factory(resolver)
            self.instance = service
            
            return service as? Dependency
        }

        return instance
    }

    func resetCache() {
        instance = nil
    }
}
