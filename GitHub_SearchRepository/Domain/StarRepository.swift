//
//  StarRepository.swift
//  GitHub_SearchRepository
//
//  Created by Satoshi Komatsu on 2024/05/04.
//

import Foundation

struct GetStarRepository: RequestType, PathEncodable {
    static let path: String = "starred"
    static let method: HTTPMethodType = .get

    var addtionalPath: String

    init(owner: String, repo: String) {
        self.addtionalPath = "/\(owner)/\(repo)"
    }
}

struct PutRepository: RequestType, PathEncodable {
    static let path: String = "starred"
    static let method: HTTPMethodType = .put

    var addtionalPath: String

    init(owner: String, repo: String) {
        self.addtionalPath = "/\(owner)/\(repo)"
    }
}
