//
//  ImageDownloader.swift
//  BaseRickAndMortyService
//
//  Created by Victor Marcel on 28/05/25.
//

import Foundation
import BaseRickAndMortyDomain

public final class ImageDownloader: ImageDownloaderProtocol {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let networkingOperations: NetworkingOperationsProtocol
    
    // MARK: - INITIALIZERS
    
    public init(networkingOperations: NetworkingOperationsProtocol) {
        self.networkingOperations = networkingOperations
    }
    
    // MARK: - INTERNAL METHODS
    
    public func fetchImageBy(url: String) async throws -> Data {
        return try await networkingOperations.fetch(from: url)
    }
}
