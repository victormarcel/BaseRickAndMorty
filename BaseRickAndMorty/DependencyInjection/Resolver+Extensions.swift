//
//  Resolver+Extensions.swift
//  BaseRickAndMorty
//
//  Created by Victor Marcel on 29/05/25.
//

import Foundation
import Swinject

extension Resolver {
    
    func resolveInstance<T>(_ serviceType: T.Type) -> T {
        resolve(serviceType)!
    }
}
