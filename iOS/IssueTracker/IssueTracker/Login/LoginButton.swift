//
//  LoginButton.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/09.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

@IBDesignable
final class LoginButton: UIButton {
    
    // MARK: - IBInspectable
    // MARK: Border
    @IBInspectable var conerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    // MARK: Padding
    @IBInspectable var paddingWidth: CGFloat {
        get { padding.width }
        set { padding.width = newValue }
    }
    @IBInspectable var paddingHeight: CGFloat {
        get { padding.height }
        set { padding.height = newValue }
    }
    
    // MARK: - Properties
    override var intrinsicContentSize: CGSize {
        let width = super.intrinsicContentSize.width + padding.width
        let height = super.intrinsicContentSize.height + padding.height
        
        return CGSize(width: width, height: height)
    }
    private var padding: CGSize = .init(width: 0, height: 0)
}
