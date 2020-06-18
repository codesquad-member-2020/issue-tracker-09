//
//  UITabBarController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/18.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

extension UITabBarController {
    func presentLoginViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: LoginViewController.identifier) as? LoginViewController {
            loginViewController.modalPresentationStyle = .formSheet
            loginViewController.isModalInPresentation = true
            present(loginViewController, animated: true, completion: nil)
        }
    }
}
