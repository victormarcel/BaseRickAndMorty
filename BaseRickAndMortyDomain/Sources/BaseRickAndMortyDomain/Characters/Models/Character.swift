//
//  Character.swift
//  BaseRickAndMortyDomain
//
//  Created by Victor Marcel on 27/05/25.
//

import UIKit

public struct Character: Decodable, Sendable {
    
    // MARK: - PUBLIC PROPERTIES
    
    public let id: Int
    public let name: String
    public let image: String
    public let status: String
    public let species: String
    public let gender: String
}
