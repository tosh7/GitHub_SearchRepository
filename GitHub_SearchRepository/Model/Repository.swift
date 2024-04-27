//
//  Repository.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/27.
//

import Foundation

struct Repository: Hashable {
    var id: Int
    var name: String
    var url: URL
    var ownerLogin: String
    var ownerAvatorUrl: URL
    var stargazersCount: Int
}

extension Repository {
    init(_ response: RepositoryResponse.Repository) {
        self.id = response.id
        self.name = response.name
        self.url = URL(string: response.url)!
        self.ownerLogin = response.owner.login
        self.ownerAvatorUrl = URL(string: response.owner.avatarUrl)!
        self.stargazersCount = response.stargazersCount
    }
}
