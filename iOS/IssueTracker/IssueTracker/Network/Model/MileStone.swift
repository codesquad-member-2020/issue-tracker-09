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
    var description: String? { get }
    var dueDate: String? { get }
}

protocol MileStoneProgressable {
    var openIssueCount: Int { get }
    var closedIssueCount: Int { get }
    var progressRate: Int { get }
}

struct DeficientMileStone: Codable, MileStoneInforamationable, Identifierable {
    var id: Int?
    let title: String
    let description: String?
    let dueDate: String?
    let lastUpdatedDate: String
    let openIssueCount: Int
    let closedIssueCount: Int
    let completeRatio: Double
    let opened: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher
            .combine(id)
        hasher
            .combine(title)
        hasher
            .combine(description)
        hasher
            .combine(dueDate)
        hasher
            .combine(openIssueCount)
        hasher
            .combine(closedIssueCount)
    }
}

struct MileStone: MileStoneInforamationable, MileStoneProgressable {
    let id: Int?
    let title: String
    let description: String?
    let dueDate: String?
    let openIssueCount: Int
    let closedIssueCount: Int
    let progressRate: Int
    
    init(milestone: DeficientMileStone, progressRate: Int) {
        id = milestone.id
        title = milestone.title
        description = milestone.description
        dueDate = milestone.dueDate
        openIssueCount = milestone.openIssueCount
        closedIssueCount = milestone.closedIssueCount
        self.progressRate = progressRate
    }
}
