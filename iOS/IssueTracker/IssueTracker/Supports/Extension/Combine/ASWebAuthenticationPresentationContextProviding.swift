//
//  ASWebAuthenticationPresentationContextProviding.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/24.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Combine
import AuthenticationServices

extension ASWebAuthenticationSession {
    static func publisher(_ provider: ASWebAuthenticationPresentationContextProviding, url: URL, scheme: String?) -> TokenPublisher {
        return TokenPublisher(provider,
                              url: url,
                              scheme: scheme)
    }
    
    // MARK: - Publisher
    struct TokenPublisher: Publisher {
        
        // MARK: - Type
        typealias Output = String
        typealias Failure = Error
        
        // MARK: - Properties
        let url: URL
        let scheme: String?
        let provider: ASWebAuthenticationPresentationContextProviding
        
        // MARK: - Lifecycle
        init(_ provider: ASWebAuthenticationPresentationContextProviding, url: URL, scheme: String?) {
            self.provider = provider
            self.url = url
            self.scheme = scheme
        }
        
        // MARK: - Method
        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = TokenSubscription(subscriber,
                                                 presenting: provider,
                                                 url: url,
                                                 callbackURLScheme: scheme)
            subscriber.receive(subscription: subscription)
        }
    }
    
    // MARK: Subscription
    class TokenSubscription<S: Subscriber>: Subscription where S.Input == String, S.Failure == Error {
        
        // MARK: - Type
        typealias Output = String
        typealias Failure = Error
        
        // MARK: - Properties
        private var subscriber: S?
        
        // MARK: - Lifecycle
        init(_ subscriber: S, presenting provider: ASWebAuthenticationPresentationContextProviding, url: URL, callbackURLScheme scheme : String?) {
            self.subscriber = subscriber
            sendRequest(provider,
                        url: url,
                        callbackURLScheme: scheme)
        }
        
        // MARK: - Method
        func request(_ demand: Subscribers.Demand) {  }
        
        func cancel() {
            subscriber = nil
        }
        
        private func sendRequest(_ provider: ASWebAuthenticationPresentationContextProviding, url: URL, callbackURLScheme scheme: String?) {
            let session = ASWebAuthenticationSession(url: url, callbackURLScheme: scheme) { url, error in
                if let error = error {
                    self.subscriber?.receive(completion: .failure(error))
                }
                guard let url = url else { return }
                let queryItems = URLComponents(string: url.absoluteString)?.queryItems
                guard let token = queryItems?.filter({ $0.name == "token" }).first?.value else { return }
                _ = self.subscriber?.receive(token)
                self.subscriber?.receive(completion: .finished)
            }
            session.presentationContextProvider = provider
            session.start()
        }
    }
}
