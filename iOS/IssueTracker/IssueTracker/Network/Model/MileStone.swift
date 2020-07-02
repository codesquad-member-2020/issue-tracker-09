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

protocol MileStoneProgressable {
    var numberOfOpenIssue: Int? { get }
    var numberOfClosedIssue: Int? { get }
}

struct MileStone: Codable, MileStoneInforamationable, MileStoneProgressable {
    let id: Int?
    let title: String
    let contents: String?
    let dueOn: String?
    let numberOfOpenIssue: Int?
    let numberOfClosedIssue: Int?
}
