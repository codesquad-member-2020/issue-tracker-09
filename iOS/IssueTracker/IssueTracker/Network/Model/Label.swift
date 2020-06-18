//
//  Label.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

struct Label: Codable {
    let id: Int
    let title: String
    let contents: String?
    let colorCode: String
}

struct PostLabel: Codable {
    let title: String
    let contents: String?
    let colorCode: String
}
