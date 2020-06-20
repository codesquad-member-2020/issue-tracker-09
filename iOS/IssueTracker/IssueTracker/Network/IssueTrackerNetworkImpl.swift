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
    var encoder: JSONEncoder
    
    init(session: URLSession = .shared, encoder: JSONEncoder = .init()) {
        self.session = session
        self.encoder = encoder
    }
    
    func requeset<T>(_ type: T.Type, providing: RequestPorviding) -> AnyPublisher<T, IssueTrackerNetworkError> where T : Decodable {
        guard let url = providing.url else {
            return Fail(error: .urlError)
                .eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.addValue("Bearer " + KeychainItem.currentUserIdentifier, forHTTPHeaderField: "Authorization")
        
        return session.dataTaskPublisher(for: request)
            .mapError { _ in IssueTrackerNetworkError.apiError }
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { _ in .jsonDecodingError }
            .eraseToAnyPublisher()
    }
    
    func request<V: Encodable>(_ value: V, providing: RequestPorviding, method: String?, headers: [String: String]) ->  AnyPublisher<HTTPURLResponse, IssueTrackerNetworkError> {
        guard let data = try? encoder.encode(value) else {
            return Fail(error: .jsonEncodingError)
                .eraseToAnyPublisher()
        }
        guard let request = try? providing.request(method,
                                                   data: data,
                                                   headers: headers) else {
                                                    return Fail(error: .urlRequestError)
                                                        .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .mapError { _ in IssueTrackerNetworkError.apiError }
            .compactMap { $0.response as? HTTPURLResponse }
            .eraseToAnyPublisher()
    }
}
