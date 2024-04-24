//
//  RequestType.swift
//  GitHub_SearchRepository
//
//  Created by satoshi on 2024/04/25.
//

import Foundation

protocol RequestType {
    var path: String { get }
    var method: HTTPMethodType { get }
}
