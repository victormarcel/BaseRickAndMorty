//
//  FlowViewController.swift
//  BaseRickAndMortyUI
//
//  Created by Victor Marcel on 29/05/25.
//

import BaseRickAndMortyDomain
import BaseRickAndMortyUI
import Foundation
import UIKit

final class FlowViewController: UINavigationController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let factory: Factory
    
    // MARK: - INITIALIZERS
    
    init(factory: Factory) {
        self.factory = factory
        let entryPointViewController = factory.makeCharactersViewController()
        
        super.init(rootViewController: entryPointViewController)
        
        entryPointViewController.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - INTERNAL METHODS
    
    func navigateToCharacterInfo(viewData: CharacterInfoViewData) {
        let viewController = factory.makeCharacterInfoViewController(viewData: viewData)
        pushViewController(viewController, animated: true)
    }
}
