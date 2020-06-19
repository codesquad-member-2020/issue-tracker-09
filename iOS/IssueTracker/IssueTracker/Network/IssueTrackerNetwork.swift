//
//  IssueTrackerNetwork.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation
import AuthenticationServices
import Combine

enum IssueTrackerNetworkError: Error {
    case error(String)
    case defalutError
    
    var message: String {
        switch self {
        case let .error(msg):
            return msg
        case .defalutError:
            return "잠시 후에 다시 시도해주세요"
        }
    }
}

protocol IssueTrackerNetwork {
    var session: URLSession { get }
    
    func requeset<T: Decodable>(_ type: T.Type, providing: RequestPorviding) -> AnyPublisher<T, IssueTrackerNetworkError>
    func request<V: Encodable>(_ value: V, providing: RequestPorviding, method: String?, headers: [String: String]) ->  AnyPublisher<HTTPURLResponse, IssueTrackerNetworkError>
}
