//
//  NetworkingOperationsProtocol.swift
//  BaseRickAndMortyService
//
//  Created by Victor Marcel on 28/05/25.
//

import Foundation

public protocol NetworkingOperationsProtocol: Sendable {
    
    func fetch(from url: String) async throws -> Data
    func fetch<T: Decodable>(request: HttpRequestsProtocol) async throws -> T
}
