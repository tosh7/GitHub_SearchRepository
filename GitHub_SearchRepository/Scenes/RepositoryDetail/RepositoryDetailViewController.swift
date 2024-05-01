//
//  RepositoryViewController.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import UIKit

final class RepositoryDetailViewController: UIViewController {

    private let viewModel: RepositoryDetailViewModel

    init(repository: Repository) {
        self.viewModel = RepositoryDetailViewModel(repository: repository)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}
