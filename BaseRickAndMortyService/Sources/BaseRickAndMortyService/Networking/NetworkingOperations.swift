//
//  NetworkingOperations.swift
//  BaseRickAndMortyService
//
//  Created by Victor Marcel on 27/05/25.
//

import Foundation

public final class NetworkingOperations: NetworkingOperationsProtocol {
    
    // MARK: - INITIALIZERS
    
    public init() {}
    
    // MARK: - INTERNAL METHODS
    
    public func fetch(from url: String) async throws -> Data {
        do {
            let url = try buildUrlFrom(string: url)
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch let error {
            throw error
        }
    }
    
    public func fetch<T: Decodable>(request: HttpRequestsProtocol) async throws -> T {
        do {
            let data = try await fetch(from: request.url)
            let decodedData: T = try decode(data: data)
            return decodedData
        } catch let error {
            throw error
        }
    }
    
    // MARK: - PRIVATE METHOD
    
    private func buildUrlFrom(string: String) throws -> URL {
        guard let url = URL(string: string) else {
            throw NetworkingOperationsError.invalidUrl
        }
        
        return url
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw NetworkingOperationsError.parseError
        }
    }
}
