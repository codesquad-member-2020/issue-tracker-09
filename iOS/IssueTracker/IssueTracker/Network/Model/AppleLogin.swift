//
//  AppleLogin.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/18.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation
import AuthenticationServices

struct AppleLogin: Codable {
    
    // MARK: - Properties
    let name: String?
    let social_id: String
    let email: String?
    
    // MARK: - Lifecycle
    init(credential: ASAuthorizationAppleIDCredential) {
        name = credential.fullName?.nickname
        social_id = credential.user
        email = credential.email
    }
}
