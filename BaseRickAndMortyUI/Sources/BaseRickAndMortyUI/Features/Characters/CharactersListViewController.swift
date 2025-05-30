//
//  CharactersListViewController.swift
//  BaseRickAndMortyUI
//
//  reated by Victor Marcel on 27/05/25.
//

import BaseRickAndMortyDomain
import UIKit

@MainActor
public protocol CharactersListViewControllerDelegate: AnyObject {
    
    func CharactersListViewController(_ viewController: CharactersListViewController, didTap characterData: CharacterInfoViewData)
}

public class CharactersListViewController: UIViewController {
    
    // MARK: - CONSTANTS
    
    private enum Constants {
        
        static let delayTimeToFetchNextPage: Int = 1
        static let navigationTitle = "Characters"
        
        enum TableView {
            static let rowHeight: CGFloat = 90
        }
        
        enum ActivityIndicatorView {
            static let height: CGFloat = 40
        }
    }
    
    // MARK: - PRIVATE PROPERTIES
    
    private let viewModel: CharactersListViewModel
    
    // MARK: - PUBLIC PROPERTIES
    
    public weak var delegate: CharactersListViewControllerDelegate?
    
    // MARK: - INITIALIZERS
    
    public init(viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
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
        fetchCharacters()
    }
    
    // MARK: - UI
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tableView, activityIndicatorContainerView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = Constants.TableView.rowHeight
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.description())
        return tableView
    }()
    
    private lazy var activityIndicatorContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // MARK: - PRIVATE METHODS
    
    private func setupLayout() {
        navigationItem.title = Constants.navigationTitle
        view.backgroundColor = .white
    }
    
    private func setupLayoutConstraints() {
        view.addSubview(contentStackView)
        activityIndicatorContainerView.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicatorContainerView.heightAnchor.constraint(equalToConstant: Constants.ActivityIndicatorView.height),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: activityIndicatorContainerView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: activityIndicatorContainerView.centerYAnchor)
        ])
    }
    
    private func fetchCharacters() {
        Task {
            await viewModel.fetchCharacters()
        }
    }
    
    private func showActivityIndicatorIfNeeded() {
        if !viewModel.characters.isEmpty {
            setActivityIndicatorVisibility(isHidden: false)
        }
    }
    
    private func setActivityIndicatorVisibility(isHidden: Bool) {
        activityIndicatorContainerView.isHidden = isHidden
    }
    
    private func setupCharacterCell(_ cellView: CharacterTableViewCell, data: Character) {
        cellView.name = data.name
        
        Task { @MainActor in
            guard let imageData = await viewModel.imageBy(character: data) else {
                return
            }
            cellView.image = UIImage(data: imageData)
        }
    }
}

// MARK: - CHARACTERS LIST DELEGATE

extension CharactersListViewController: CharactersListViewModelDelegate {
    
    public func charactersFirstPageFetchingDidSuccess() {
        Task { @MainActor in
            tableView.reloadData()
        }
    }
    
    public nonisolated func charactersNextPageFetchingDidSuccess(indexPaths: [IndexPath]) {
        Task { @MainActor in
            setActivityIndicatorVisibility(isHidden: true)
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}

// MARK: - TABLE VIEW DELEGATE

extension CharactersListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Task { @MainActor in
            guard let characterData = viewModel.characterBy(indexPath: indexPath),
                let imageData = await viewModel.imageBy(character: characterData) else {
                return
            }
            
            let image = UIImage(data: imageData) ?? UIImage()
            delegate?.CharactersListViewController(self, didTap: .init(character: characterData, image: image))
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == viewModel.charactersLastIndex else {
            return
        }
        
        showActivityIndicatorIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Constants.delayTimeToFetchNextPage)) { [weak self] in
            self?.fetchCharacters()
        }
    }
}

// MARK: - TABLE VIEW DATA SOURCE

extension CharactersListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.description()) as? CharacterTableViewCell,
              let characterData = viewModel.characterBy(indexPath: indexPath) else {
            return UITableViewCell()
        }
    
        setupCharacterCell(cell, data: characterData)
        return cell
    }
}
