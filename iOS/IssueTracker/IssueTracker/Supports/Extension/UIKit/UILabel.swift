//
//  UILabel.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/30.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(font: UIFont?, textColor: UIColor) {
        self.init()
        guard let font = font else {
            self.textColor = textColor
            return
        }
        self.font = font
        self.textColor = textColor
    }
}
