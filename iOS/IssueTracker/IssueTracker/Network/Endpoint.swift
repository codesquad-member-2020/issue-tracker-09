//
//  Endpoint.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

struct Endpoint: RequestProviding {
    
    enum Path: CustomStringConvertible {
        case githubLogin
        case appleLogin
        case labels(String? = nil)
        case mileStone(String? = nil)
        
        var description: String {
            switch self {
            case .githubLogin:
                return "/api/login"
            case .appleLogin:
                return "/api/applelogin"
            case let .labels(identifier):
                guard let identifier = identifier else { return "/api/labels" }
                return "/api/labels/\(identifier)"
            case let .mileStone(identifier):
                guard let identifier = identifier else { return "/api/milestones" }
                return "/api/milestones/\(identifier)"
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
    var baseUrl: String = "13.124.148.192"
    var scheme: String = "http"
    var path: Path
}
