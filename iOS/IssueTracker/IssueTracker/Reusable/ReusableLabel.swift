//
//  ReusableLabel.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class ReusableLabel: UILabel {
    
    // MARK: - Properties
    override var intrinsicContentSize: CGSize {
        let width = super.intrinsicContentSize.width + padding.width
        let height = super.intrinsicContentSize.height + padding.height
        
        return CGSize(width: width,
                      height: height)
    }
    private let padding: CGSize = CGSize(width: 4, height: 2)
    
    // MARK: - Methods
    func apply(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
    }
    
    func apply(borderColor: CGColor, borderWidth: CGFloat) {
        layer.borderColor = borderColor
        layer.borderWidth = borderWidth
    }
}
