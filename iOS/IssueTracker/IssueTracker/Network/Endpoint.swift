//
//  Endpoint.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

protocol RequestProviding {
    var url: URL? { get }
}

struct Endpoint: RequestProviding {

    enum Path: CustomStringConvertible {
        case appleLogin
        case labels(String? = nil)
        case mileStone(String? = nil)
        
        var description: String {
            switch self {
                case .appleLogin:
                    return "/api/applelogin"
            case let .labels(identifier):
                guard let identifier = identifier else { return "/api/labels" }
                return "/api/labels/\(identifier)"
            case let .mileStone(identifier):
                guard let identifier = identifier else { return "/api/milestones" }
                return "/api/labels/\(identifier)"
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
}
