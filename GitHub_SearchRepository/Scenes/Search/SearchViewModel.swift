//
//  SearchViewModel.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {

    enum Router {
        case goDetail(Repository)
    }

    // Outputs
    @Published var repositories: [Repository] = []
    @Published var router: Router?

    private let apiClient: APIClient
    private var textFieldValuePublisher = PassthroughSubject<String, Never>()
    private var cancellabeles: Set<AnyCancellable> = []

    init(apiClienst: APIClient) {
        self.apiClient = apiClienst

        textFieldValuePublisher
            .debounce(for: .seconds(1.0), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] in
                if $0.isEmpty {
                    self?.repositories = []
                } else {
                    self?.callAPI(word: $0)
                }
            }.store(in: &cancellabeles)
    }
}

// Inputs
extension SearchViewModel {
    func textFiledDidChange(word: String) {
        // To use debounce, put in PassthroughSubject
        textFieldValuePublisher.send(word)
    }

    func cellDidTapped(index: Int) {
        router = .goDetail(repositories[index])
    }
}

// Private methods
extension SearchViewModel {
    private func callAPI(word: String) {
        Task {
            let result = await APIClient().getRepository(.init(keyword: word))

            switch result {
            case .success(let value):
                self.repositories = value.items.map { Repository($0) }
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
