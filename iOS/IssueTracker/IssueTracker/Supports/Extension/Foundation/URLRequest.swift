//
//  URLRequest.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/21.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

extension URLRequest {
    init(url: URL, method: HTTPMethod, body: Data? = nil) {
        self.init(url: url)
        self.httpMethod = method.description
        self.setValue("application/json",
                      forHTTPHeaderField: "Content-Type")
        self.setValue("Bearer " + KeychainItem.currentUserIdentifier,
                      forHTTPHeaderField: "Authorization")
        self.setValue(UserDefaults.standard.object(forKey: "loginType") as? String,
                      forHTTPHeaderField: "loginType")
        self.httpBody = body
    }
}
