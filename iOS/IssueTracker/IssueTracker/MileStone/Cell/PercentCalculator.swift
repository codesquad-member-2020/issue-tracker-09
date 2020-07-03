//
//  PercentCalculator.swift
//  IssueTracker
//
//  Created by Cloud on 2020/07/02.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

struct PercentCalculator {
    
    //MARK: - Properties
    var progressRate: Int {
        let total = Double(openIssue) + Double(closedIssue)
        guard closedIssue != 0 else { return 0 }
        
        return Int(Double(closedIssue) / total * 100)
    }
    private var openIssue: Int
    private var closedIssue: Int
    
    // MARK: - Lifecycle
    init(openIssue: Int, closedIssue: Int) {
        self.openIssue = openIssue
        self.closedIssue = closedIssue
    }
}
