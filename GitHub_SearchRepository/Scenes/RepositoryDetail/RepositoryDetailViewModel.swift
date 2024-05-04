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
    @Published private(set) var isStarred: Bool = false
    private let apiClient: APIClient

    init(repository: Repository, apiClient: APIClient) {
        self.repository = repository
        self.apiClient = apiClient
    }
}

// Inputs
extension RepositoryDetailViewModel {
    func viewDidLoad() {
        Task {
            let val = await apiClient.getStarRepository(.init(fullName: repository.fullName))
            print(val)
            switch val {
            case .success:
                isStarred = true
            case .failure:
                isStarred = false
            }
        }
    }

    func starButtonDidTapped() {
        // call star repository API here
    }
}
