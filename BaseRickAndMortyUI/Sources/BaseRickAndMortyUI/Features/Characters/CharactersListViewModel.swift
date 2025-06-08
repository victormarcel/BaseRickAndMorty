//
//  CharactersListViewModel.swift
//  BaseRickAndMortyUI
//
//  reated by Victor Marcel on 27/05/25.
//

import Combine
import BaseRickAndMortyDomain
import UIKit

// MARK: - DELEGATE

@MainActor
public protocol CharactersListViewModelDelegate: AnyObject {
    
    func charactersFirstPageFetchingDidSuccess()
    func charactersNextPageFetchingDidSuccess(indexPaths: [IndexPath])
}

@MainActor
public final class CharactersListViewModel {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let characterService: CharactersServiceProtocol
    private let imageDownloader: ImageDownloaderProtocol
    private var nextCharactersPage: Int? = 1
    
    // MARK: - INTERNAL PROPERTIES
    
    var characters: [Character] = []
    var charactersLastIndex: Int {
        characters.count - 1
    }
    var charactersImageCache: [Int: Data] = [:]
    var isLoadingNextPage = false
    
    // MARK: - PUBLIC PROPERTIES
    
    public weak var delegate: CharactersListViewModelDelegate?
    
    // MARK: - INITIALIZERS
    
    public init(characterService: CharactersServiceProtocol, imageDownloader: ImageDownloaderProtocol) {
        self.characterService = characterService
        self.imageDownloader = imageDownloader
    }
    
    // MARK: - INTERNAL METHODS
    
    func fetchCharacters() async {
        guard let nextCharactersPage, !isLoadingNextPage else { return }
        isLoadingNextPage = true
        
        do {
            let charactersResponse = try await characterService.fetchCharacters(page: nextCharactersPage)
            handleCharactersResponse(response: charactersResponse)
        } catch {
            // TODO: Handle Error
        }
        
        isLoadingNextPage = false
    }
    
    func imageBy(character: Character) async -> Data? {
        guard let cachedImage = charactersImageCache[character.id] else {
            return await fecthCharacterImage(character)
        }
        
        return cachedImage
    }
    
    func characterBy(indexPath: IndexPath) -> Character? {
        guard isValidIndexPath(indexPath) else {
            return nil
        }
        
        return characters[indexPath.row]
    }
    
    // MARK: - PRIVATE METHODS
    
    private func handleNextCharactersPage(characterResponseInfo: CharactersResponse.Info) {
        guard characterResponseInfo.next != nil, let nextCharactersPage else {
            nextCharactersPage = nil
            return
        }
        
        self.nextCharactersPage = nextCharactersPage + 1
    }
    
    private func fecthCharacterImage(_ character: Character) async -> Data? {
        
        
        do {
            let data = try await imageDownloader.fetchImageBy(url: character.image)
            cacheCharacterImage(character: character, imageData: data)
            return data
        } catch {
            return nil
        }
    }
    
    private func cacheCharacterImage(character: Character, imageData: Data) {
        charactersImageCache[character.id] = imageData
    }
    
    
    private func handleCharactersResponse(response: CharactersResponse) {
        if characters.isEmpty {
            characters = response.results
            delegate?.charactersFirstPageFetchingDidSuccess()
        } else {
            characters += response.results
            let newCharactersIndexPaths = buildNewCharactersIndexPaths(responseLength: response.results.count)
            delegate?.charactersNextPageFetchingDidSuccess(indexPaths: newCharactersIndexPaths)
        }
        
        handleNextCharactersPage(characterResponseInfo: response.info)
    }
    
    private func buildNewCharactersIndexPaths(responseLength: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        let startIndex = (charactersLastIndex - responseLength) + 1
        let finalIndex = charactersLastIndex
              
        for i in startIndex...finalIndex {
            indexPaths.append(.init(row: i, section: .zero))
        }
        
        return indexPaths
    }
    
    private func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        let validRange = .zero...charactersLastIndex
        let currentRowIndex = indexPath.row
        
        return validRange ~= currentRowIndex
    }
}
