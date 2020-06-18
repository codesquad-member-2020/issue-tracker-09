//
//  AppleLogin.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/18.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

struct AppleLogin: Codable {
    let name: String?
    let social_id: String
    let email: String?
}
