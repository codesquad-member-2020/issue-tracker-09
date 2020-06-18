//
//  IssueTrackerNetworkimpl.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation
import Combine

struct IssueTrackerNetworkImpl: IssueTrackerNetwork {
    
    static var shared: IssueTrackerNetworkImpl = .init()
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
    
    func requestAppleIDJwtToken(userId: String, providing: RequestPorviding) -> AnyPublisher<URLResponse, IssueTrackerNetworkError> {
        
        guard let url = providing.url else {
            return Fail(error: .error("Invaild URL"))
                .eraseToAnyPublisher()
        }
        
        guard let encodeData = try? JSONEncoder().encode(AppleLogin(name: nil, social_id: userId, email: nil)) else { return Fail(error: .error("Invaild Encode Data"))
            .eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = encodeData
        
        return session.dataTaskPublisher(for: url)
            .mapError { _ in IssueTrackerNetworkError.error("IssueTracker API Error") }
            .map { $0.response }
            .eraseToAnyPublisher()
    }
}
