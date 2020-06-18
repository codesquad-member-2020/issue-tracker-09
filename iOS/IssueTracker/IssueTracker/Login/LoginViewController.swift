//
//  LoginViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/09.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import AuthenticationServices
import Combine

final class LoginViewController: UIViewController, ASWebAuthenticationPresentationContextProviding {
    
    // MARK: - IBOutlets
    @IBOutlet weak var signinGitHubButton: UIButton!
    
    // MARK: - Properties
    static let identifier: String = "LoginViewController"
    private var authorizationButton: ASAuthorizationAppleIDButton!
    private var subscription: AnyCancellable?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraints()
    }
    
    @IBAction func githubLoginAction(_ sender: UIButton) {
        guard let authURL = URL(string: Endpoint.githubLogin) else { return }
        let scheme = "issuenine"
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme) { callbackURL, error in
            guard error == nil else {
                let alertController = UIAlertController.errorAlert(message: error?.localizedDescription ?? "")
                DispatchQueue.main.async { self.present(alertController, animated: true) }
                
                return
            }
            guard let callbackURL = callbackURL else { return }
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            guard let token = queryItems?.filter({ $0.name == "token" }).first?.value else { return }
            self.saveUserInKeychain(token)
        }
        session.presentationContextProvider = self
        session.start()
    }
    
    // MARK: - Methods
    // MARK: Configure
    func configure() {
        configureAppleLoginButton()
    }
    
    func configureAppleLoginButton() {
        authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self,
                                      action: #selector(handleAuthorizationAppleIDButtonPress),
                                      for: .touchUpInside)
        view.addSubview(authorizationButton)
    }
    
    // MARK: Constraints
    func makeConstraints() {
        makeConstraintsAppleLoginButton()
    }
    
    func makeConstraintsAppleLoginButton() {
        authorizationButton.snp.makeConstraints { make in
            make.height.equalTo(signinGitHubButton.snp.height)
            make.width.equalTo(signinGitHubButton.snp.width)
            make.top.equalTo(signinGitHubButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - Extension
// MARK: ASAuthorizationControllerDelegate
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        IssueTrackerNetworkImpl.shared
            .requestAppleIDJwtToken(credential: appleIDCredential,
                                    providing: Endpoint(path: .appleLogin))
            .receive(subscriber: Subscribers.Sink(receiveCompletion: {
                guard case .failure(let error) = $0 else { return }
                let alertViewController = UIAlertController.errorAlert(message: error.message)
                self.present(alertViewController,
                             animated: true)
            }, receiveValue: { response in
                guard let response = response as? HTTPURLResponse,
                    let key = response.allHeaderFields["Authorization"] as? String else { return }
                self.saveUserInKeychain(key)
            }))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alertController = UIAlertController(title: "Fail Authentication",
                                                message: "Apple ID 인증에 실패하였습니다.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done",
                                                style: .cancel,
                                                handler: nil))
        present(alertController,
                animated: true,
                completion: nil)
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: KeychainItem.service,
                             account: KeychainItem.account).saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
}

// MARK: ASAuthorizationControllerPresentationContextProviding
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = view.window else { return UIWindow() }
        return window
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        guard let window = view.window else { return UIWindow() }
        return window
    }
}
