//
//  CharacterTableViewCell.swift
//  BaseRickAndMortyUI
//
//  Created by Victor Marcel on 27/05/25.
//

import BaseRickAndMortyDomain
import Foundation
import UIKit

final class CharacterTableViewCell: UITableViewCell {
    
    // MARK: - CONSTANTS
    
    private enum Constants {
        
        enum ContentStackView {
            static let spacing: CGFloat = 16
            static let leadingConstant: CGFloat = 16
        }
        
        enum IconImageView {
            static let size: CGFloat = 70
            static let cornerRadius: CGFloat = Constants.IconImageView.size/2
            static let backgroundAlpha: CGFloat = 0.2
        }
        
        enum NameLabel {
            static let fontSize: CGFloat = 14
        }
    }
    
    // MARK: - INTERNAL PROPERTIES
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var image: UIImage? {
        didSet {
            iconImageView.image = image
        }
    }
    
    // MARK: - INITIALIZERS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayoutConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, nameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Constants.ContentStackView.spacing
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray.withAlphaComponent(Constants.IconImageView.backgroundAlpha)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.IconImageView.cornerRadius
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Constants.NameLabel.fontSize)
        return label
    }()
    
    // MARK: - LIFE CYCLE
    
    override func prepareForReuse() {
        iconImageView.image = nil
    }

    
    // MARK: - PRIVATE METHODS
    
    private func setupLayoutConstraints() {
        contentView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.ContentStackView.leadingConstant),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.IconImageView.size),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.IconImageView.size)
        ])
    }
}
