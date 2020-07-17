//
//  UIAlert.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/18.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

extension UIAlertController {
    convenience init(message: String) {
        self.init(title: "Error",
                  message: message,
                  preferredStyle: .alert)
        let cancel = UIAlertAction(title: "close",
                                   style: .cancel)
        addAction(cancel)
    }
}
