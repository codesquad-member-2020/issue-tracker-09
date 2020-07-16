//
//  MileStoneFormViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/07/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class MileStoneFormViewController: CategoryFormViewController {
    
    // MARK: - Properties
    private var descriptionView: DescriptionView!
    
    override init(style: FormStyle) {
        super.init(style: style)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: - Configure
    private func configure() {
        configureDescriptionView()
    }
    
    override func configureContentView(title: String?, subtitle: String?) {
        super.configureContentView(title: title,
                                   subtitle: subtitle)
        contentView.resetButton.addTarget(self,
                                          action: #selector(resetMileStoneContentView),
                                          for: .touchUpInside)
    }
    
    private func configureDescriptionView() {
        descriptionView = DescriptionView()
        contentView.addArrangedSubview(descriptionView)
    }
    
    // MARK: - Constraints
    override func makeConstraintsContentView() {
        super.makeConstraintsContentView()
        contentView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
        }
    }
    
    // MARK: Objc
    @objc private func resetMileStoneContentView() {
        contentView.resetContentView()
    }
}
