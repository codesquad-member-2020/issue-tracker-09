//
//  UsableImpl.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/22.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation
import Combine

struct UseCase: Usable {
    
    // MARK: - Properties
    static let shared: UseCase = .init()
    private let decoder: JSONDecoder = .init()
    
    // MARK: - Lifecycle
    private init() { }
    
    // MARK: - Methods
    func decode<D: Decodable>(_ type: D.Type, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<D, IssueTrackerNetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: IssueTrackerNetworkError.urlError).eraseToAnyPublisher()
        }
        
        return IssueTrackerNetworkImpl.shared
            .request(request: URLRequest(url: url,
                                         method: method))
            .map { $0.data }
            .decode(type: type.self, decoder: decoder)
            .mapError { _ in IssueTrackerNetworkError.jsonDecodingError }
            .eraseToAnyPublisher()
    }
    
    func encode(endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<HTTPURLResponse, IssueTrackerNetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: IssueTrackerNetworkError.urlError).eraseToAnyPublisher()
        }
        
        return IssueTrackerNetworkImpl.shared
            .request(request: URLRequest(url: url,
                                         method: method))
            .compactMap { $0.response as? HTTPURLResponse }
            .mapError { _ in IssueTrackerNetworkError.jsonDecodingError }
            .eraseToAnyPublisher()
    }
    
    func encode<E: Encodable>(_ data: E, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<HTTPURLResponse, IssueTrackerNetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: IssueTrackerNetworkError.urlError).eraseToAnyPublisher()
        }
        guard let data = try? JSONEncoder().encode(data) else {
            return Fail(error: IssueTrackerNetworkError.jsonEncodingError).eraseToAnyPublisher()
        }
        
        return IssueTrackerNetworkImpl.shared
            .request(request: URLRequest(url: url,
                                         method: method,
                                         body: data))
            .compactMap { $0.response as? HTTPURLResponse }
            .mapError { _ in IssueTrackerNetworkError.jsonDecodingError }
            .eraseToAnyPublisher()
    }
    
    func code<C>(_ data: C, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<(data: C?, response: HTTPURLResponse?), IssueTrackerNetworkError> where C : Decodable,
    C: Encodable {
        guard let url = endpoint.url else {
            return Fail(error: IssueTrackerNetworkError.urlError).eraseToAnyPublisher()
        }
        guard let data = try? JSONEncoder().encode(data) else {
            return Fail(error: IssueTrackerNetworkError.jsonEncodingError).eraseToAnyPublisher()
        }
        
        return IssueTrackerNetworkImpl.shared
            .request(request: URLRequest(url: url,
                                         method: method,
                                         body: data))
            .map({ data, response in
                return (try? self.decoder.decode(C.self, from: data), response as? HTTPURLResponse)
            })
            .mapError { _ in IssueTrackerNetworkError.jsonDecodingError }
            .eraseToAnyPublisher()
    }
}
