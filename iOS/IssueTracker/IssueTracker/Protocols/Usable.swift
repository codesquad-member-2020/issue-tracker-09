//
//  Usable.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/22.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation
import Combine

enum HTTPMethod: CustomStringConvertible {
    
    case get
    case put
    case post
    case delete
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .put:
            return "PUT"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}

protocol Usable {
    func fetch<D: Decodable>(_ network: IssueTrackerNetwork, type: D.Type, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<D, IssueTrackerNetworkError>
    func request(_ network: IssueTrackerNetwork, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<HTTPURLResponse, IssueTrackerNetworkError>
    func request<E: Encodable>(_ network: IssueTrackerNetwork, data: E, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<HTTPURLResponse, IssueTrackerNetworkError>
    func fetch<C: Codable>(_ network: IssueTrackerNetwork, data: C, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<(data: C?, response: HTTPURLResponse?), IssueTrackerNetworkError>
}
