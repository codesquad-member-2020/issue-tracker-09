//
//  UIControlPublisher.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/10.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

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
