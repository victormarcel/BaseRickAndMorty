//
//  Factory.swift
//  BaseRickAndMortyUI
//
//  Created by Victor Marcel on 29/05/25.
//

import Foundation
import BaseRickAndMortyDomain
import BaseRickAndMortyUI

final class Factory {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let container = DIContainer.shared.container
    
    // MARK: - INTERNAL METHODS
    
    @MainActor
    func makeCharactersViewController() -> CharactersListViewController {
        let characterService = container.resolveInstance(CharactersServiceProtocol.self)
        let imageDownloader = container.resolveInstance(ImageDownloaderProtocol.self)
        let viewModel = CharactersListViewModel(characterService: characterService, imageDownloader: imageDownloader)
        let viewController = CharactersListViewController(viewModel: viewModel)
        
        viewModel.delegate = viewController
        
        return viewController
    }
    
    @MainActor
    func makeCharacterInfoViewController(viewData: CharacterInfoViewData) -> CharacterInfoViewController {
        return .init(viewData: viewData)
    }
}
