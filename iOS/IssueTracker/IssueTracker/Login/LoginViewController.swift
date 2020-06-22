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
    private var authorizationButton: ASAuthorizationAppleIDButton!
    private let tabbarControllerIdentifier: String = "MasterViewController"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraints()
    }
    
    @IBAction func githubLoginAction(_ sender: UIButton) {
        guard let authURL = Endpoint.githubLogin else { return }
        let scheme = "issuenine"
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme) { callbackURL, error in
            guard error == nil else {
                let alertController = UIAlertController(message: error?.localizedDescription ?? "")
                DispatchQueue.main.async { [weak self] in
                    self?.present(alertController,
                                  animated: true)
                }
                
                return
            }
            guard let callbackURL = callbackURL else { return }
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            guard let token = queryItems?.filter({ $0.name == "token" }).first?.value else { return }
            self.saveUserInKeychain(token)
            self.dismiss(animated: true)
        }
        session.presentationContextProvider = self
        session.start()
    }
    
    // MARK: - Methods
    func presentLabelTableViewController() {
       let labelTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: tabbarControllerIdentifier)
        present(labelTableViewController
            ,animated: true)
    }
    
    // MARK: Configure
    private func configure() {
        configureAppleLoginButton()
    }
    
    private func configureAppleLoginButton() {
        authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self,
                                      action: #selector(handleAuthorizationAppleIDButtonPress),
                                      for: .touchUpInside)
        view.addSubview(authorizationButton)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsAppleLoginButton()
    }
    
    private func makeConstraintsAppleLoginButton() {
        authorizationButton.snp.makeConstraints { make in
            make.height.equalTo(signinGitHubButton.snp.height)
            make.width.equalTo(signinGitHubButton.snp.width)
            make.top.equalTo(signinGitHubButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func handleAuthorizationAppleIDButtonPress() {
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
            .request(AppleLogin(credential: appleIDCredential),
                     providing: Endpoint(path: .appleLogin),
                     method: "GET",
                     headers: ["application/json": "Content-Type"])
            .receive(subscriber: Subscribers.Sink(receiveCompletion: {
                guard case let .failure(error) = $0 else { return }
                let alertController = UIAlertController(message: error.message)
                self.present(alertController,
                             animated: true)
            }, receiveValue: { [weak self] response in
                guard let key = response.allHeaderFields["Authorization"] as? String else { return }
                self?.saveUserInKeychain(key)
            }))
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: KeychainItem.service,
                             account: KeychainItem.account).saveItem(userIdentifier)
        } catch {
            let alertController = UIAlertController(message: "Unable to save userIdentifier to keychain.")
            present(alertController,
                    animated: true)
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
