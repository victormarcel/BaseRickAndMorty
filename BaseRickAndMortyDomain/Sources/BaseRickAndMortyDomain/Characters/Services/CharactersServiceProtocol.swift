//
//  CharactersServiceProtocol.swift
//  BaseRickAndMortyDomain
//
//  Created by Victor Marcel on 27/05/25.
//

public protocol CharactersServiceProtocol: Sendable {
    
    func fetchCharacters(page: Int) async -> Result<CharactersResponse, Error>
}
