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
    var fullName: String
    var description: String
    var url: String
    var ownerLogin: String
    var ownerAvatorUrl: String
    var stargazersCount: Int
}

extension Repository {
    init(_ response: RepositoryResponse.Repository) {
        self.id = response.id
        self.name = response.name
        self.fullName = response.fullName
        self.description = response.description ?? ""
        self.url = response.url
        self.ownerLogin = response.owner.login
        self.ownerAvatorUrl = response.owner.avatarUrl
        self.stargazersCount = response.stargazersCount
    }
}
