//
//  SearchViewController.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import UIKit
import Combine

final class SearchViewController: UIViewController {

    enum Section {
        case main
    }

    private let viewModel: SearchViewModel = .init(apiClienst: APIClient())
    private lazy var collectionView: UICollectionView = {
        let c = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout())
        c.delegate = self
        return c
    }()
    lazy var dataSource: UICollectionViewDiffableDataSource<Section, String> = createDataSource()
    private var cancellables: Set<AnyCancellable> = []

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white
        navigationItem.searchController = searchController

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        viewModel.$repositories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] repository in
            guard let self,
                  let repository else { return }
            self.updateUI(names: repository.items.map { $0.url })
        }.store(in: &cancellables)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private lazy var searchController = {
        let search = UISearchController()
        search.searchBar.delegate = self
        return search
    }()

    private func collectionViewLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textFiledDidChange(word: searchText)
    }
}

extension SearchViewController: UICollectionViewDelegate {

}

extension SearchViewController {
    private func createDataSource() -> UICollectionViewDiffableDataSource<Section, String> {
        let celRRegistration = UICollectionView.CellRegistration<SearchResultCell, String> { (cell, indexPath, item) in
            cell.setup(name: item)
        }

        return UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: celRRegistration, for: indexPath, item: identifier)
        }
    }

    func updateUI(names: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(names)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

#Preview {
    SearchViewController()
}
