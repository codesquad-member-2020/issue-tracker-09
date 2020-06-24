//
//  LoginManager.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/25.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation
import Combine
import AuthenticationServices

class LoginManager: NSObject {
    
    // MARK: - Properties
    var authorizationRequests: ASAuthorizationAppleIDRequest {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        return request
    }
    private weak var viewController: LoginViewController?
    private var subscription: AnyCancellable?
    
    // MARK: - Lifecycle
    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Method
    func requestAppleLoginToken(credential: ASAuthorizationAppleIDCredential) {
        guard let token = String(data: credential.identityToken!,
                                 encoding: .utf8) else { return }
        UseCase.shared
            .encode(AppleLogin(token: token),
                    endpoint: Endpoint(path: .appleLogin),
                    method: .post)
            .receive(subscriber: Subscribers.Sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                let alertController = UIAlertController(message: error.message)
                self?.viewController?.present(alertController,
                                             animated: true)
                }, receiveValue: { [weak self] response in
                    print(response.statusCode)
                    if response.statusCode == 200 {
                        try? self?.saveUserInKeychain(token)
                        self?.viewController?.presentTabBarController()
                    } else {
                        let alertController = UIAlertController(message: "유효하지 않은 Apple ID 입니다.")
                        self?.viewController?.present(alertController,
                                                     animated: true)
                    }
            }))
    }
    
    func requestGithubLoginToken() {
        guard let authURL = Endpoint.githubLogin else { return }
        let scheme = "issuenine"
        subscription = ASWebAuthenticationSession.publisher(self,
                                                            url: authURL,
                                                            scheme: scheme)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self]  in
                guard case let .failure(error) = $0 else { return }
                let alertController = UIAlertController(message: error.localizedDescription)
                self?.viewController?.present(alertController,
                                             animated: true)
            }) { [weak self] token in
                try? self?.saveUserInKeychain(token)
                self?.viewController?.presentTabBarController()
        }
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) throws {
        try KeychainItem(service: KeychainItem.service,
                         account: KeychainItem.account).saveItem(userIdentifier)
    }
}

// MARK: - Extension
// MARK: ASWebAuthenticationPresentationContextProviding
extension LoginManager: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        guard let window = viewController?.view.window else { return UIWindow() }
        return window
    }
}

