//
//  RepositoryInfo.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import Foundation

struct RepositoryRequest: RequestType, Codable {

    static let path: String = "search/repositories"
    static let method: HTTPMethodType = .get

    var q: String
    var per_page: Int = 10

    init(keyword: String) {
        self.q = keyword
    }
}

struct RepositoryResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]

    struct Repository: Codable {
        let id: Int
        let nodeId: String
        let name: String
        let fullName: String
        let owner: Owner
        let isPrivate: Bool?
        let htmlUrl: String
        let description: String?
        let fork: Bool
        let url: String
        let createdAt: String
        let updatedAt: String
        let pushedAt: String
        let homepage: String?
        let size: Int
        let stargazersCount: Int
        let watchersCount: Int
        let language: String?
        let forksCount: Int
        let openIssuesCount: Int
        let masterBranch: String?
        let defaultBranch: String
        let score: Double
        let license: License?

        struct Owner: Codable {
            let login: String
            let id: Int
            let nodeId: String
            let avatarUrl: String
            let url: String
            let type: String
            let siteAdmin: Bool
        }

        struct License: Codable {
            let key: String
            let name: String
            let url: String?
            let spdxId: String
            let nodeId: String
        }
    }
}
