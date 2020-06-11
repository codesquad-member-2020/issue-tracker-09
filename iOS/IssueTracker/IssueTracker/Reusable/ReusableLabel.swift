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
    private let cornerRadius: CGFloat = 6.0
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: - Methods
    func apply(borderColor: CGColor, borderWidth: CGFloat) {
        layer.borderColor = borderColor
        layer.borderWidth = borderWidth
    }
    
    // MARK: Configure
    private func configure() {
        layer.cornerRadius = cornerRadius
    }
}
