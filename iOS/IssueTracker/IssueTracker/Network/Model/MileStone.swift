//
//  MileStone.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/27.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

protocol MileStoneInforamationable {
    var title: String { get }
    var contents: String? { get }
    var dueOn: String? { get }
}

struct MileStone: Codable, MileStoneInforamationable {
    let id: Int?
    let title: String
    let contents: String?
    let dueOn: String?
    let numberOfOpenIssue: Int?
    let numberOfClosedIssue: Int?
}


