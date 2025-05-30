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
    
    public func fetch(from url: String) async -> Result<Data, Error> {
        do {
            let url = try buildUrlFrom(string: url)
            let (data, _) = try await URLSession.shared.data(from: url)
            return .success(data)
        } catch let error {
            return .failure(error)
        }
    }
    
    public func fetch<T: Decodable>(request: HttpRequestsProtocol) async -> Result<T, Error> {
        do {
            let url = try buildUrlFrom(string: request.url)
            let (data, _) = try await URLSession.shared.data(from: url)
            let response: T = try decode(data: data)
            return .success(response)
        } catch let error {
            return .failure(error)
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
