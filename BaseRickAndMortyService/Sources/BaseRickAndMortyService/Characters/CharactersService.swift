//
//  CharactersService.swift
//  BaseRickAndMortyService
//
//  Created by Victor Marcel on 27/05/25.
//

import BaseRickAndMortyDomain

public final class CharactersService: CharactersServiceProtocol {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let networkingOperations: NetworkingOperationsProtocol
    
    // MARK: - INITIALIZERS
    
    public init(networkingOperations: NetworkingOperationsProtocol) {
        self.networkingOperations = networkingOperations
    }
    
    // MARK: - INTERNAL METHODS
    
    public func fetchCharacters(page: Int) async throws -> CharactersResponse {
        let httpRequest = CharacterHttpRequest(page: page)
        return try await networkingOperations.fetch(request: httpRequest)
    }
}
