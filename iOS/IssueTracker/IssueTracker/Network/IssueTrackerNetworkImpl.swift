//
//  IssueTrackerNetworkimpl.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation
import AuthenticationServices
import Combine

struct IssueTrackerNetworkImpl: IssueTrackerNetwork {
    
    // MARK: - Properties
    static var shared: IssueTrackerNetworkImpl = .init()
    var session: URLSession
    
    // MARK: - Lifecycle
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Methods
    func request(request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), IssueTrackerNetworkError> {
        session.dataTaskPublisher(for: request)
            .mapError { _ in IssueTrackerNetworkError.apiError }
            .map {  data, response in return (data, response) }
            .eraseToAnyPublisher()
    }
}
