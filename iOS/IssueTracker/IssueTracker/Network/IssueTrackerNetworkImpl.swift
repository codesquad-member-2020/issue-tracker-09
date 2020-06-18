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
    
    static var shared: IssueTrackerNetworkImpl = .init()
    var session: URLSession
    var encoder: AppleIdentifierEncoder
    
    init(session: URLSession = .shared, encoder: AppleIdentifierEncoder = .init()) {
        self.session = session
        self.encoder = encoder
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
    
    func requestAppleIDJwtToken(credential:  ASAuthorizationAppleIDCredential, providing: RequestPorviding) -> AnyPublisher<URLResponse, IssueTrackerNetworkError> {
        guard let url = providing.url else {
            return Fail(error: .error("Invaild URL"))
                .eraseToAnyPublisher()
        }
        guard let data = try? encoder.encode(AppleLogin(credential: credential)) else {
            return Fail(error: .error("Invaild Encode Data"))
                .eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.addValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        return session.dataTaskPublisher(for: request)
            .mapError { _ in IssueTrackerNetworkError.error("IssueTracker API Error") }
            .map { $0.response }
            .eraseToAnyPublisher()
    }
}
