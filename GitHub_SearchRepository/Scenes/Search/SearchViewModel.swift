//
//  SearchViewModel.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {

    // Outputs
    @Published var repositories: RepositoryResponse?

    private let apiClient: APIClient
    private var textFieldValuePublisher = PassthroughSubject<String, Never>()
    private var cancellabeles: Set<AnyCancellable> = []

    init(apiClienst: APIClient) {
        self.apiClient = apiClienst

        textFieldValuePublisher
            .debounce(for: .seconds(1.0), scheduler: RunLoop.main)
            .sink { [weak self] in
                if $0.isEmpty {
                    self?.repositories = .init(totalCount: 0, incompleteResults: false, items: [])
                } else {
                    self?.callAPI(word: $0)
                }
            }.store(in: &cancellabeles)
    }
}

// Inputs
extension SearchViewModel {
    func textFiledDidChange(word: String) {
        // To use removeDeplicate, put in PassthroughSubject
        textFieldValuePublisher.send(word)
    }
}

// Private methods
extension SearchViewModel {
    private func callAPI(word: String) {
        Task {
            let result = await APIClient().getRepository(.init(keyword: word))

            switch result {
            case .success(let value):
                self.repositories = value
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
