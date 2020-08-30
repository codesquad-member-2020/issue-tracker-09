//
//  RequestProviding.swift
//  IssueTracker
//
//  Created by Cloud on 2020/08/30.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

protocol RequestProviding {
    var url: URL? { get }
    var baseUrl: String { get }
    var scheme: String { get }
    var path: Endpoint.Path { get }
}
