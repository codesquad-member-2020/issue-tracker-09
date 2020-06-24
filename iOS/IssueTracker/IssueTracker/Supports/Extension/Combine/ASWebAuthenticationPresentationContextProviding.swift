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
    static func publisher(_ viewController: ASWebAuthenticationPresentationContextProviding, url: URL, scheme: String?) -> TokenPublisher {
        return TokenPublisher(viewController, url: url, scheme: scheme)
    }
    
    // MARK: - Publisher
    struct TokenPublisher: Publisher {
        
        // MARK: - Type
        typealias Output = String
        typealias Failure = Error
        
        // MARK: - Properties
        let url: URL
        let scheme: String?
        let viewController: ASWebAuthenticationPresentationContextProviding
        
        // MARK: - Lifecycle
        init(_ viewController: ASWebAuthenticationPresentationContextProviding, url: URL, scheme: String?) {
            self.viewController = viewController
            self.url = url
            self.scheme = scheme
        }
        
        // MARK: - Method
        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = TokenSubscription(subscriber,
                                                 presenting: viewController,
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
        init(_ subscriber: S, presenting viewController: ASWebAuthenticationPresentationContextProviding, url: URL, callbackURLScheme scheme : String?) {
            self.subscriber = subscriber
            sendRequest(viewController, url: url, callbackURLScheme: scheme)
        }
        
        // MARK: - Method
        func request(_ demand: Subscribers.Demand) {  }
        
        func cancel() {
            subscriber = nil
        }
        
        private func sendRequest(_ viewController: ASWebAuthenticationPresentationContextProviding, url: URL, callbackURLScheme scheme: String?) {
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
            session.presentationContextProvider = viewController
            session.start()
        }
    }
}
