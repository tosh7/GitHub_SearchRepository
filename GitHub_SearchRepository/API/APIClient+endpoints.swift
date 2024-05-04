//
//  APIClient+endpoints.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/25.
//

import Foundation

extension APIClient {
    func getRepository(_ request: RepositoryRequest) async -> Result<RepositoryResponse, APIError> {
        await self.call(request: request)
    }
    func getStarRepository(_ request: GetStarRepository) async -> Result<EmptyResponse, APIError> {
        await self.call(request: request)
    }
    func putStarRepositroy(_ request: PutRepository) async -> Result<EmptyResponse, APIError> {
        await self.call(request: request)
    }
}
