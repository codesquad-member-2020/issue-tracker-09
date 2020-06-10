//
//  UIControlSubscription.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/10.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
    
    private var subscriber: SubscriberType?
    private let control: Control
    
    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self,
                          action: #selector(eventHandler),
                          for: event)
    }
    
    // MARK: Methods
    func request(_ demand: Subscribers.Demand) { }
    
    func cancel() {
        subscriber = nil
    }
    
    @objc func eventHandler() {
        _ = subscriber?.receive(control)
    }
}
