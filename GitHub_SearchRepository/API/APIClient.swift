//
//  APIClient.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/24.
//

import Foundation

actor APIClient {

    let baseURLString: String = "https://api.github.com/"
    let token: String = APIKey.token

    init() {}

    func call<Request, Response>(request: Request) async -> Result<Response, APIError> where Request: RequestType & Codable, Response: Decodable {
        do {
            let urlRequest = try makeURLRequest(request: request)
            return await call(urlRequest: urlRequest)
        } catch {
            return .failure(error as! APIError)
        }
    }

    func call<Request, Response>(request: Request) async -> Result<Response, APIError> where Request: RequestType & PathEncodable, Response: Decodable {
        do {
            let urlRequest = try makeURLRequest(request: request)
            return await call(urlRequest: urlRequest)
        } catch {
            return .failure(error as! APIError)
        }
    }

    private func call<Response>(urlRequest: URLRequest) async -> Result<Response, APIError> where Response: Decodable {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else { return .failure(.unknown)}
            guard 200..<300 ~= httpResponse.statusCode else { return .failure(.error(statusCode: httpResponse.statusCode ))}
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try jsonDecoder.decode(Response.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error as! APIError)
        }
    }

    private func makeURLRequest<Request>(request: Request) throws -> URLRequest where Request: RequestType & Codable {
        do {
            let url = URL(string: baseURLString + type(of: request).path)!

            var urlRequest: URLRequest
            switch type(of: request).method {
            case .post, .put, .delete:
                let queryData = try! JSONEncoder().encode(request)
                urlRequest = URLRequest(url: url)
                urlRequest.httpBody = queryData
            case .get:
                var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
                let queryItems = [URLQueryItem](request)
                components.queryItems = queryItems
                urlRequest = URLRequest(url: components.url!)
            }

            urlRequest.allHTTPHeaderFields = [
                "Content-Type": "application/json",
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(token)",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
            urlRequest.httpMethod = type(of: request).method.rawValue

            return urlRequest
        }
    }

    private func makeURLRequest<Request>(request: Request) throws -> URLRequest where Request: RequestType & PathEncodable {
        do {
            let url = URL(string: baseURLString + type(of: request).path + request.addtionalPath)!

            var urlRequest = URLRequest(url: url)

            urlRequest.allHTTPHeaderFields = [
                "Content-Type": "application/json",
                "Accept": "application/vnd.github+json",
                "Authorization": "Bearer \(token)",
                "X-GitHub-Api-Version": "2022-11-28"
            ]
            urlRequest.httpMethod = type(of: request).method.rawValue

            return urlRequest
        }
    }
}

extension Array where Element == URLQueryItem {
    init?<Request>(_ request: Request) where Request: RequestType & Codable {
        guard let json = ((try? JSONEncoder().encode(request))
            .flatMap {try? JSONSerialization.jsonObject(with: $0, options: []) as? [String: Any]}) else { return nil }
        self = json.map {URLQueryItem(name: $0.key, value: "\($0.value)")}
    }
}
