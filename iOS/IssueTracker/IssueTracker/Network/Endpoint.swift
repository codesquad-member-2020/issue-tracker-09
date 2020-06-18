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
    
    var url: URL? {
        var components = URLComponents()
        components.host = baseUrl
        components.scheme = scheme
        components.path = path.description
        
        return components.url
    }
    static let githubLogin: URL? = URL(string: "https://github.com/login/oauth/authorize?client_id=1aad2658e941ef024da5&scope=user%20public_repo")
    private let baseUrl: String = "13.209.115.251"
    let path: Path
    let scheme: String = "http"
}
