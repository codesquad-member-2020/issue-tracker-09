//
//  BadgeLabel.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class BadgeLabel: UILabel {
    
    // MARK: - Properties
    override var intrinsicContentSize: CGSize {
        let width = super.intrinsicContentSize.width + padding.width
        let height = super.intrinsicContentSize.height + padding.height
        
        return CGSize(width: width,
                      height: height)
    }
    private let padding: CGSize = CGSize(width: 16, height: 0)
    private let cornerRadius: CGFloat = 8.0
    
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
        textAlignment = .center
        clipsToBounds = true
    }
}
