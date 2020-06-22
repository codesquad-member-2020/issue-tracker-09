//
//  Endpoint.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

protocol RequestPorviding {
    var url: URL? { get }
    
    func request(_ method: String?, data: Data?, headers: [String: String]) throws -> URLRequest
}

struct Endpoint: RequestPorviding {
    
    enum Path: CustomStringConvertible {
        case labels
        case appleLogin
        
        var description: String {
            switch self {
            case .labels:
                return "/api/labels"
            case .appleLogin:
                return "/api/applelogin"
            }
        }
    }
    
    // MARK: - Properties
    var url: URL? {
        var components = URLComponents()
        components.host = baseUrl
        components.scheme = scheme
        components.path = path.description
        
        return components.url
    }
    static let githubLogin: URL? = URL(string: "https://github.com/login/oauth/authorize?client_id=1aad2658e941ef024da5&scope=user%20public_repo")
    private let baseUrl: String = "13.209.115.251"
    private let scheme: String = "http"
    let path: Path
    
    // MARK: - Properties
    func request(_ method: String? = "GET", data: Data?, headers: [String: String]) throws -> URLRequest {
        guard let url = url else { throw IssueTrackerNetworkError.urlError }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = data
        request.addValue("Bearer " + KeychainItem.currentUserIdentifier, forHTTPHeaderField: "Authorization")
        headers.forEach { key, field in
            request.addValue(key, forHTTPHeaderField: field)
        }
        
        return request
    }
}
