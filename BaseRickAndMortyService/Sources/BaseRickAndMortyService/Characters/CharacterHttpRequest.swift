//
//  CharacterHttpRequest.swift
//  BaseRickAndMortyService
//
//  Created by Victor Marcel on 27/05/25.
//

struct CharacterHttpRequest: HttpRequestsProtocol {
    
    // MARK: - INTERNAL PROPERTIES
    
    let page: Int
    let parameters: [String: Any] = [:]
    let headers: [String: Any] = [:]
    
    var url: String {
        return "https://rickandmortyapi.com/api/character/?page=\(page)"
    }
    
    // MARK: - INITIALIZERS
    
    init(page: Int) {
        self.page = page
    }
}
