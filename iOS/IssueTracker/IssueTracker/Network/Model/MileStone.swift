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
    var numberOfOpenIssue: Int { get }
    var numberOfClosedIssue: Int { get }
    var progressRate: Int { get }
}

struct DeficientMileStone: Hashable, Codable, MileStoneInforamationable, Identifierable {
    var id: Int?
    let title: String
    let contents: String?
    let dueOn: String?
    let numberOfOpenIssue: Int
    let numberOfClosedIssue: Int
    
    static func ==(lhs: DeficientMileStone, rhs: DeficientMileStone) -> Bool {
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
            .combine(dueOn)
        hasher
            .combine(numberOfOpenIssue)
        hasher
            .combine(numberOfClosedIssue)
    }
}

struct MileStone: MileStoneInforamationable, MileStoneProgressable {
    let id: Int?
    let title: String
    let contents: String?
    let dueOn: String?
    let numberOfOpenIssue: Int
    let numberOfClosedIssue: Int
    let progressRate: Int
    
    init(milestone: DeficientMileStone, progressRate: Int) {
        id = milestone.id
        title = milestone.title
        contents = milestone.contents
        dueOn = milestone.dueOn
        numberOfOpenIssue = milestone.numberOfOpenIssue
        numberOfClosedIssue = milestone.numberOfClosedIssue
        self.progressRate = progressRate
    }
}
