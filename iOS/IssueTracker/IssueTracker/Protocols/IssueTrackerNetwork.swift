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
    
    case urlError
    case urlRequestError
    case apiError
    case jsonEncodingError
    case jsonDecodingError
    
    var message: String {
        switch self {
        case .urlError:
            return "Invalid URL"
        case .urlRequestError:
            return "Invalid URL Requset"
        case .apiError:
            return "Invalid API"
        case .jsonEncodingError, .jsonDecodingError:
            return "Invalid JSON Format"
        }
    }
}

protocol IssueTrackerNetwork {
    var session: URLSession { get }
    
    func request(request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), IssueTrackerNetworkError>
}
