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
    func fetch<D: Decodable>(_ network: IssueTrackerNetwork = IssueTrackerNetworkImpl.shared, type: D.Type, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<D, IssueTrackerNetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: IssueTrackerNetworkError.urlError).eraseToAnyPublisher()
        }
        
        return network
            .request(request: URLRequest(url: url,
                                         method: method))
            .map { $0.data }
            .decode(type: type.self, decoder: decoder)
            .mapError { _ in IssueTrackerNetworkError.jsonDecodingError }
            .eraseToAnyPublisher()
    }
    
    func request(_ network: IssueTrackerNetwork = IssueTrackerNetworkImpl.shared, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<HTTPURLResponse, IssueTrackerNetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: IssueTrackerNetworkError.urlError).eraseToAnyPublisher()
        }
        
        return network
            .request(request: URLRequest(url: url,
                                         method: method))
            .compactMap { $0.response as? HTTPURLResponse }
            .mapError { _ in IssueTrackerNetworkError.jsonDecodingError }
            .eraseToAnyPublisher()
    }
    
    func request<E: Encodable>(_ network: IssueTrackerNetwork = IssueTrackerNetworkImpl.shared, data: E, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<HTTPURLResponse, IssueTrackerNetworkError> {
        guard let url = endpoint.url else {
            return Fail(error: IssueTrackerNetworkError.urlError).eraseToAnyPublisher()
        }
        guard let data = try? JSONEncoder().encode(data) else {
            return Fail(error: IssueTrackerNetworkError.jsonEncodingError).eraseToAnyPublisher()
        }
        
        return network
            .request(request: URLRequest(url: url,
                                         method: method,
                                         body: data))
            .compactMap { $0.response as? HTTPURLResponse }
            .mapError { _ in IssueTrackerNetworkError.jsonDecodingError }
            .eraseToAnyPublisher()
    }
    
    func fetch<C>(_ network: IssueTrackerNetwork = IssueTrackerNetworkImpl.shared, data: C, endpoint: RequestProviding, method: HTTPMethod) -> AnyPublisher<(data: C?, response: HTTPURLResponse?), IssueTrackerNetworkError> where C : Decodable,
        C: Encodable {
            guard let url = endpoint.url else {
                return Fail(error: IssueTrackerNetworkError.urlError).eraseToAnyPublisher()
            }
            guard let data = try? JSONEncoder().encode(data) else {
                return Fail(error: IssueTrackerNetworkError.jsonEncodingError).eraseToAnyPublisher()
            }
            
            return network
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
