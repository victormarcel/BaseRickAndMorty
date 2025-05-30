//
//  File.swift
//  BaseRickAndMortyService
//
//  Created by Victor Marcel on 27/05/25.
//

public protocol HttpRequestsProtocol {
    
    var url: String { get }
    var parameters: [String: Any] { get }
    var headers: [String: Any] { get }
}
