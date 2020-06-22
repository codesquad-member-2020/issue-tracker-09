//
//  Usable.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/22.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation
import Combine

protocol Usable {
    func decode<D: Decodable>(_ type: D.Type, endpoint: RequestProviding, method: URLRequest.HTTPMethod) -> AnyPublisher<D, IssueTrackerNetworkError>
    func encode(endpoint: RequestProviding, method: URLRequest.HTTPMethod) -> AnyPublisher<HTTPURLResponse, IssueTrackerNetworkError>
    func encode<E: Encodable>(_ data: E, endpoint: RequestProviding, method: URLRequest.HTTPMethod) -> AnyPublisher<HTTPURLResponse, IssueTrackerNetworkError>
}
