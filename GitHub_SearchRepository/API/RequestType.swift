//
//  RequestType.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/25.
//

import Foundation

protocol RequestType {
    static var path: String { get }
    static var method: HTTPMethodType { get }
}
