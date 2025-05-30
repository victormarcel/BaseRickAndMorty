//
//  CharacterInfoViewController.swift
//  BaseRickAndMortyUI
//
//  Created by Victor Marcel on 29/05/25.
//

import BaseRickAndMortyDomain
import Foundation
import UIKit

public class CharacterInfoViewController: UIViewController {
    
    // MARK: - CONSTANTS
    
    private enum Constants {
        
        static let delayTimeToFetchNextPage: Int = 1
        
        enum ContentView {
            static let topConstant: CGFloat = 32
            static let sideConstant: CGFloat = 32
            static let spacing: CGFloat = 16
        }
        
        enum IconImageView {
            static let size: CGFloat = 100
            static let cornerRadius: CGFloat = Constants.IconImageView.size/2
            static let backgroundAlpha: CGFloat = 0.2
            static let bottomSpace: CGFloat = 32
        }
        
        enum InfoView {
            static let spacing: CGFloat = 4
            static let status = "Status"
            static let species = "Species"
            static let gender = "Gender"
        }
        
        enum TitleLabel {
            static let fontSize: CGFloat = 14
        }
        
        enum DescriptionLabel {
            static let fontSize: CGFloat = 14
            static let alpha: CGFloat = 0.5
        }
    }
    
    // MARK: - PRIVATE PROPERTIES
    
    private let viewData: CharacterInfoViewData
    private var character: Character {
        viewData.character
    }
    
    private var characterInfo: [(title: String, description: String)] {
        [
            (title: Constants.InfoView.gender, description: character.gender),
            (title: Constants.InfoView.species, description: character.species),
            (title: Constants.InfoView.status, description: character.status)
        ]
    }
    
    // MARK: - INITIALIZERS
    
    public init(viewData: CharacterInfoViewData) {
        self.viewData = viewData
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupLayoutConstraints()
    }
    
    // MARK: - UI
    
    private lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [iconImageContainerView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Constants.ContentView.spacing
        stackView.setCustomSpacing(Constants.IconImageView.bottomSpace, after: iconImageContainerView)
        return stackView
    }()
    
    private lazy var iconImageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray.withAlphaComponent(Constants.IconImageView.backgroundAlpha)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = viewData.image
        imageView.layer.cornerRadius = Constants.IconImageView.cornerRadius
        return imageView
    }()
    
    // MARK: - PRIVATE METHODS
    
    private func setupLayout() {
        navigationItem.title = character.name
        view.backgroundColor = .white
        
        setupCharacterInfoLayout()
    }
    
    private func setupLayoutConstraints() {
        view.addSubview(contentStackView)
        iconImageContainerView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.ContentView.topConstant),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.ContentView.sideConstant),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.ContentView.sideConstant),
            
            iconImageContainerView.heightAnchor.constraint(equalTo: iconImageView.heightAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.IconImageView.size),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.IconImageView.size),
            iconImageView.centerXAnchor.constraint(equalTo: iconImageContainerView.centerXAnchor)
        ])
    }
    
    private func setupCharacterInfoLayout() {
        let items = characterInfo.map {
            buildInfoView(title: $0.title, description: $0.description)
        }
        let row = buildInfoRow(infoViews: items)
        contentStackView.addArrangedSubview(row)

        addBottomSpacer()
    }
    
    private func addBottomSpacer() {
        let spacer = UIView()
        contentStackView.addArrangedSubview(spacer)
    }
    
    private func buildInfoView(title: String, description: String) -> UIView {
        let titleLabel = buildLabel(
            font: .boldSystemFont(ofSize: Constants.TitleLabel.fontSize),
            textColor: .black,
            priority: .defaultHigh
        )
        titleLabel.text = title
        
        let descriptionLabel = buildLabel(
            font: .boldSystemFont(ofSize: Constants.DescriptionLabel.fontSize),
            textColor: .gray.withAlphaComponent(Constants.DescriptionLabel.alpha),
            priority: .defaultLow
        )
        descriptionLabel.text = title
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.InfoView.spacing
        stackView.axis = .vertical
        
        return stackView
    }
    
    private func buildLabel(font: UIFont, textColor: UIColor, priority: UILayoutPriority) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(priority, for: .vertical)
        label.font = font
        label.textColor = textColor
        return label
    }
    
    private func buildInfoRow(infoViews: [UIView]) -> UIView {
        let stackView = UIStackView(arrangedSubviews: infoViews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.InfoView.spacing
        stackView.distribution = .equalCentering
        return stackView
    }
}
