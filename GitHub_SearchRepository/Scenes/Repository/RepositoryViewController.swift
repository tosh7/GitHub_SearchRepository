//
//  RepositoryViewController.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import UIKit

final class RepositoryViewController: UIViewController {

    private let viewModel: RepositoryViewModel

    init(repository: Repository) {
        self.viewModel = RepositoryViewModel(repository: repository)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}
