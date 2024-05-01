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
    lazy var dataSource: UICollectionViewDiffableDataSource<Section, Repository> = createDataSource()
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
                guard let self else { return }
                self.updateUI(repositories: repository)
        }.store(in: &cancellables)

        viewModel.$router
            .receive(on: DispatchQueue.main)
            .sink { [weak self] route in
                guard let self, let route else { return }
                switch route {
                case .goDetail(let repo):
                    let vc = RepositoryDetailViewController(repository: repo)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            .store(in: &cancellables)
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.cellDidTapped(index: indexPath.row)
    }
}

extension SearchViewController {
    private func createDataSource() -> UICollectionViewDiffableDataSource<Section, Repository> {
        let celRRegistration = UICollectionView.CellRegistration<SearchResultCell, Repository> { (cell, indexPath, item) in
            cell.setup(repository: item)
        }

        return UICollectionViewDiffableDataSource<Section, Repository>(collectionView: collectionView) { (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: celRRegistration, for: indexPath, item: identifier)
        }
    }

    func updateUI(repositories: [Repository]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Repository>()
        snapshot.appendSections([.main])
        snapshot.appendItems(repositories)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

//#Preview {
//    SearchViewController()
//}
