//
//  BaseRickAndMortyTests.swift
//  BaseRickAndMortyTests
//
//  Created by Victor Marcel on 27/05/25.
//

import XCTest
import BaseRickAndMortyDomain
@testable import BaseRickAndMorty

final class BaseRickAndMortyTests: XCTestCase {
    
    // MARK: - LIFE CICLE
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    // MARK: - INTERNAL METHODS
    
    func testCharacterResponseDeserialization() throws {
        guard let url = Bundle(for: type(of: self)).url(forResource: "ApiResponseMock", withExtension: "json") else {
            XCTFail("Missing file: ApiResponseMock.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            XCTAssertNoThrow(
                try JSONDecoder().decode(CharactersResponse.self, from: data),
                "Decoding should succeed for valid JSON"
            )
        } catch {
            XCTFail("Decoding error: \(error)")
            return
        }
    }
}
