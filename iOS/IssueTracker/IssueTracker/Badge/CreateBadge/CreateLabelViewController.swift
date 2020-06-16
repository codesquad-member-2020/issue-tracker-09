//
//  CreateLabelViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class CreateLabelViewController: CategoryFormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureContentView() {
        super.configureContentView()
        contentView.apply(subtitle: "설명")
    }
    
    override func makeConstraintsContentView() {
        super.makeConstraintsContentView()
        contentView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
        }
    }
}
