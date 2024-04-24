//
//  APIClient.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import Foundation

actor APIClient {

    let baseURLString: String = "https://api.github.com/"

    init() {}

    func makeGetRequest<Request, Response>(request: Request) async -> Result<Response, Error> where Request: RequestType, Response: Decodable {
        let url = URL(string: baseURLString + request.path)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = [
            "Accept": "application/vnd.github+json",
            // TODO: add Bearer Token
//            "Authorization": "Bearer <YOUR-TOKEN>",
            "X-GitHub-Api-Version": "2022-11-28"
        ]
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            // should call if response.statusCode is 200 ..< 300
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try jsonDecoder.decode(Response.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
}


