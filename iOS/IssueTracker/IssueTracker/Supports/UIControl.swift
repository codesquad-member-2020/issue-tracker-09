//
//  UIControl.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/10.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

extension UIControl {
    func publisher(for event: UIControl.Event) -> UIControlPublisher {
        return UIControlPublisher(control: self,
                                  event: event)
    }
}
