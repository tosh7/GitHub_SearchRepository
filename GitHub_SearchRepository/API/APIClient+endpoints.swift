//
//  APIClient+endpoints.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/25.
//

import Foundation

extension APIClient {
    func getRepository(_ request: RepositoryRequest) async -> Result<RepositoryResponse, Error> {
        await self.makeGetRequest(request: request)
    }
}
