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
        
        var description: String {
            "/api/mock/labels"
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.host = baseUrl
        components.scheme = scheme
        components.path = path.description
        
        return components.url
    }
    static let githubLogin: String = "https://github.com/login/oauth/authorize?client_id=1aad2658e941ef024da5&scope=user%20public_repo"
    private let baseUrl: String = "13.209.115.251"
    let path: Path
    let scheme: String = "http"
}
