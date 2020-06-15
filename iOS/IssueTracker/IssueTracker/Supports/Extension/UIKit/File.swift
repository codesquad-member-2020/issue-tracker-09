//
//  File.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/15.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

extension UIView {
    func addSeperatorLayer() {
        var seperator = CALayer()
        seperator.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: 1)
        seperator.borderColor = UIColor.systemGray.cgColor
        layer.addSublayer(seperator)
    }
}
