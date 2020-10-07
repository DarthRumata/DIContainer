//
//  Container.swift
//  DIContainer
//
//  Created by Stas Kirichok on 15.09.2020.
//  Copyright © 2020 Stas Kirichok. All rights reserved.
//

import Foundation

public enum ContainerObjectScope {
    case transient
    case container
}

public protocol Resolver {
    func resolve<Dependency>(_ type: Dependency.Type) -> Dependency
}

public final class DependencyContainer: Resolver {
    private var parent: DependencyContainer?
    private lazy var dependencyEntries: [DependencyKey: DependencyEntryProtocol] = [:]
    private let lock: NSRecursiveLock
    
    public init(parent: DependencyContainer? = nil) {
        self.parent = parent
        lock = parent.map { $0.lock } ?? NSRecursiveLock()
    }
    
    public func register<Dependency>(_ type: Dependency.Type, in scope: ContainerObjectScope = .container, factory: @escaping ((Resolver) -> Dependency)) {
        lock.lock()
        
        let key = DependencyKey(type: type)
        dependencyEntries[key] = DependencyEntry(factory: factory, scope: scope)
        
        lock.unlock()
    }
    
    public func resolve<Dependency>(_ type: Dependency.Type) -> Dependency {
        lock.lock()
        
        defer {
            lock.unlock()
        }
        
        let key = DependencyKey(type: type)
        
        guard let entry = getEntry(for: key), let service: Dependency = entry.getInstance(using: self) else {
            fatalError("Impossible to resolve service with type: \(key)")
        }
        
        return service
    }
    
    private func getEntry(for key: DependencyKey) -> DependencyEntryProtocol? {
        if let entry = dependencyEntries[key] {
            return entry
        } else {
            return parent?.getEntry(for: key)
        }
    }
}
