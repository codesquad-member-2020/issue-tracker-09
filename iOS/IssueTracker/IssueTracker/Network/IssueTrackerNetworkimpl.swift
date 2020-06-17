//
//  IssueTrackerNetworkimpl.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation
import Combine

struct IssueTrackerNetworkimpl: IssueTrackerNetwork {
    var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func requeset<T>(_ type: T.Type, providing: RequestPorviding) -> AnyPublisher<T, IssueTrackerNetworkError> where T : Decodable {
        
        guard let url = providing.url else {
            return Fail(error: .error("Invaild URL"))
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .mapError { _ in IssueTrackerNetworkError.error("IssueTracker API Error") }
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in .error("JSON Parsing Error") }
            .eraseToAnyPublisher()
    }
}
