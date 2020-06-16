//
//  CreateLabelViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class CreateLabelViewController: CategoryFormViewController {
    
    private var colorView: ColorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        colorView = ColorView()
        contentView.addArrangedSubview(colorView)
    }
    
    override func configureContentView() {
        super.configureContentView()
        contentView.apply(subtitle: "설명")
        
        contentView.resetButton.addTarget(self, action: #selector(resetLabelContentView), for: .touchUpInside)
    }
    
    override func makeConstraintsContentView() {
        super.makeConstraintsContentView()
        contentView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
        }
    }
    
    @objc private func resetLabelContentView() {
        contentView.resetContentView()
        colorView.resetColorView()
    }
}
