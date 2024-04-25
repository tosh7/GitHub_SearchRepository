//
//  APIError.swift
//  GitHub_SearchRepository
//
//  Created by Satoshi Komatsu on 2024/04/25.
//

import Foundation

enum APIError: Error {
    case encodeError
    case decodeError
    case unknown
    case error(statusCode: Int)
}
