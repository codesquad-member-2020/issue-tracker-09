//
//  URLRequest.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/21.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

extension URLRequest {
    public enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    public init(url: URL, method: HTTPMethod, contentType: String?, body: Data?) {
        self.init(url: url)
        self.method = method
        self.setValue(contentType, forHTTPHeaderField: "Content-Type")
        self.setValue("Bearer " + KeychainItem.currentUserIdentifier, forHTTPHeaderField: "Authorization")
        self.httpBody = body
    }
    
    public var method: HTTPMethod? {
        get {
            guard let httpMethod = self.httpMethod else { return nil }
            let method = HTTPMethod(rawValue: httpMethod)
            return method
        } set {
            self.httpMethod = newValue?.rawValue
        }
    }
}
