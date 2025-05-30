//
//  ImageDownloaderProtocol.swift
//  BaseRickAndMortyDomain
//
//  Created by Victor Marcel on 28/05/25.
//

import Foundation

public protocol ImageDownloaderProtocol: Sendable {
    
    func fetchImageBy(url: String) async -> Result<Data, Error>
}
