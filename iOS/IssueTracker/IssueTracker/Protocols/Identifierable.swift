//
//  Identifierable.swift
//  IssueTracker
//
//  Created by Cloud on 2020/09/03.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

protocol Identifierable: Hashable {
    var id: Int? { get }
}

extension Identifierable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
