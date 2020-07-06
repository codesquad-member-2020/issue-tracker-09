//
//  PercentCalculator.swift
//  IssueTracker
//
//  Created by Cloud on 2020/07/02.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

struct ProgressRateCalculator {
    
    //MARK: - Properties
    static let shared: ProgressRateCalculator = .init()
    
    // MARK: - Lifecycle
    private init() {  }
    
    // MARK: - Method
    func apply(open: Int, closed: Int) -> Int {
        guard closed != 0 else { return 0 }
        let total = Double(open) + Double(closed)
        return Int(Double(closed) / total * 100)
    }
}
