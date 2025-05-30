//
//  FlowViewController+Characters.swift
//  BaseRickAndMortyUI
//
//  Created by Victor Marcel on 29/05/25.
//

import BaseRickAndMortyDomain
import BaseRickAndMortyUI
import Foundation

extension FlowViewController: CharactersListViewControllerDelegate {
    
    func CharactersListViewController(_ viewController: CharactersListViewController, didTap characterData: CharacterInfoViewData) {
        navigateToCharacterInfo(viewData: characterData)
    }
}
