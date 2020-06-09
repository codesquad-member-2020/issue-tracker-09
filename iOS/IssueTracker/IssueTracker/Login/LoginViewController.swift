//
//  LoginViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/09.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import AuthenticationServices
import SnapKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var signinGitHubButton: UIButton!
    
    // MARK:  - Properties
    private var authorizationButton: ASAuthorizationAppleIDButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraints()
    }
    
    // MARK: - Methods
    func configure() {
        configureAppleLoginButton()
    }
    
    func configureAppleLoginButton() {
        authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton
            .addTarget(self,
                       action: #selector(handleAuthorizationAppleIDButtonPress),
                       for: .touchUpInside)
        view.addSubview(authorizationButton)
    }
    
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

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            
            
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            
        default:
            break
        }
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = view.window else { return UIWindow() }
        return window
    }
}
