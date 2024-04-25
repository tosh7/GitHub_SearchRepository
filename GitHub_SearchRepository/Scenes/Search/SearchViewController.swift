//
//  SearchViewController.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import UIKit

final class SearchViewController: UIViewController {

    private let viewModel: SearchViewModel = .init(apiClienst: APIClient())

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private lazy var searchController = {
        let search = UISearchController()
        search.searchBar.delegate = self
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textFiledDidChange(word: searchText)
    }
}

#Preview {
    SearchViewController()
}
