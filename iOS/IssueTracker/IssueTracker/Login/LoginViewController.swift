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

final class LoginViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var signinGitHubButton: UIButton!
    
    // MARK: - Properties
    private var authorizationButton: ASAuthorizationAppleIDButton!
    private let tabbarControllerIdentifier: String = "MasterViewController"
    private var subscriptions: Set<AnyCancellable> = .init()
    private var loginManager: LoginManager!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraints()
    }
    
    @IBAction func githubLoginAction(_ sender: UIButton) {
        loginManager
            .requestGithubLoginToken()
    }
    
    // MARK: - Methods
    func presentTabBarController() {
        let labelTableViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: tabbarControllerIdentifier)
        labelTableViewController.modalPresentationStyle = .fullScreen
        present(labelTableViewController
            ,animated: true)
    }
    
    // MARK: Configure
    private func configure() {
        configureAppleLoginButton()
        loginManager = LoginManager(viewController: self)
    }
    
    private func configureAppleLoginButton() {
        authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton
            .addTarget(self,
                       action: #selector(handleAuthorizationAppleIDButtonPress),
                       for: .touchUpInside)
        view
            .addSubview(authorizationButton)
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
    
    // MARK: Objc
    @objc private func handleAuthorizationAppleIDButtonPress() {
        let authorizationController = ASAuthorizationController(authorizationRequests: [loginManager.authorizationRequests])
        authorizationController.delegate = self
        authorizationController
            .performRequests()
    }
}


// MARK: - Extension
// MARK: ASAuthorizationControllerDelegate
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        loginManager
            .requestAppleLoginToken(credential: appleIDCredential)
    }
}
