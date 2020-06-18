//
//  AppleLoginEncoder.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/18.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

struct AppleIdentifierEncoder {
    
    // MARK: - Properties
    private let encoder: JSONEncoder
    
    // MARK: - Lifecycle
    init(encoder: JSONEncoder = .init()) {
        self.encoder = encoder
    }
    
    // MARK: - Methods
    func encode(_ appleLogin: AppleLogin) throws -> Data {
        return try encoder.encode(appleLogin)
    }
}
