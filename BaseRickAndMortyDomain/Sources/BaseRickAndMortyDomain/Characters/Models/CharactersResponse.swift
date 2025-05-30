//
//  CharactersResponse.swift
//  BaseRickAndMortyDomain
//
//  Created by Victor Marcel on 27/05/25.
//

public struct CharactersResponse: Decodable, Sendable {
    
    public let results: [Character]
    public let info: Info
    
    public struct Info: Decodable, Sendable {
        
        public let next: String?
    }
}
