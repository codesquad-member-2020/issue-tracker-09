//
//  SaveButton.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class DecisionButton: UIButton {
    
    // MARK: - Properties
    override var intrinsicContentSize: CGSize {
        let width = super.intrinsicContentSize.width + padding.width
        let height = super.intrinsicContentSize.height + padding.height
        
        return CGSize(width: width,
                      height: height)
    }
    private let padding: CGSize = CGSize(width: 16, height: 6)
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
    
    // MARK: Methods
    // MARK: Configure
    private func configure() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        backgroundColor = .black
        setTitleColor(.white,
                      for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
}
