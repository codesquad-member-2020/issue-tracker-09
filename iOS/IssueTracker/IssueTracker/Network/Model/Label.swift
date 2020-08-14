//
//  Label.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

struct Label: Codable, Hashable {
    let id: Int?
    let title: String
    let contents: String?
    let colorCode: String?
    
    static func ==(lhs: Label, rhs: Label) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher
            .combine(id)
        hasher
            .combine(title)
        hasher
            .combine(contents)
        hasher
            .combine(colorCode)
    }
}
