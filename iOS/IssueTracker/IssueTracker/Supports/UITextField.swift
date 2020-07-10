//
//  UIControl.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/10.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

extension UITextField {
    //MARK: Method
    func publisher(for event: UIControl.Event) -> UIControlPublisher {
        return UIControlPublisher(control: self,
                                  event: event)
    }
    
    // MARK: Publisher
    struct UIControlPublisher: Publisher {

        typealias Output = UITextField
        typealias Failure = Never

        // MARK: - Properties
        let control: UITextField
        let event: UIControl.Event
        
        // MARK: - Methods
        func receive<S>(subscriber: S) where S : Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
            let subscription = UIControlSubscription(subscriber: subscriber,
                                                     control: control,
                                                     event: event)
            subscriber.receive(subscription: subscription)
        }
    }

    // MARK: Subscription
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
}
