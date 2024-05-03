//
//  RepositoryViewModel.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import Foundation
import Combine

final class RepositoryDetailViewModel {

    @Published private(set) var repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }
}

// Inputs
extension RepositoryDetailViewModel {
    func starButtonDidTapped() {
        // call star repository API here
    }
}
