//
//  Label.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

struct Label: Codable, Identifierable {
    var id: Int?
    let title: String
    let contents: String?
    let colorCode: String?
    
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
