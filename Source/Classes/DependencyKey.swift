//
//  DependencyKey.swift
//  DIContainer
//
//  Created by Stas Kirichok on 17.09.2020.
//  Copyright © 2020 Stas Kirichok. All rights reserved.
//

import Foundation

private protocol OptionalProtocol {
    static var wrappedType: Any.Type { get }
}

extension Optional: OptionalProtocol {
    static var wrappedType: Any.Type { return Wrapped.self }
}


struct DependencyKey: Hashable {
    private let storageKey: String
    
    init(type: Any.Type) {
        if let type = type as? OptionalProtocol.Type {
            storageKey = String(describing: type.wrappedType)
        } else {
            storageKey = String(describing: type)
        }
    }
}
