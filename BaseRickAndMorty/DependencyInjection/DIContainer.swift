//
//  DIContainer.swift
//  BaseRickAndMorty
//
//  Created by Victor Marcel on 29/05/25.
//

import Foundation
import Swinject
import BaseRickAndMortyDomain
import BaseRickAndMortyService

final class DIContainer {
    
    // MARK: - STATIC PROPERTIES
    
    static let shared = DIContainer()
    
    // MARK: - INTERNAL PROPERTIES
    
    let container = Container()
    
    // MARK: - INITIALIZERS
    
    init() {
        registerServices()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func registerServices() {
        container.register(NetworkingOperationsProtocol.self) { _ in
            NetworkingOperations()
        }
        
        container.register(CharactersServiceProtocol.self) { r in
            let networkingOperations = r.resolveInstance(NetworkingOperationsProtocol.self)
            return CharactersService(networkingOperations: networkingOperations)
        }
        
        container.register(ImageDownloaderProtocol.self) { r in
            let networkingOperations = r.resolveInstance(NetworkingOperationsProtocol.self)
            return ImageDownloader(networkingOperations: networkingOperations)
        }
    }
}
