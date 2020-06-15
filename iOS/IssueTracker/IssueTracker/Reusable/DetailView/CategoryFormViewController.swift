//
//  CategoryFormViewController.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

class CategoryFormViewController: UIViewController {
    
    // MARK: - Properties
    private var dimmedView: UIView!
    private var contentView: DetailFormContentView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraints()
    }
    
    // MARK: - Methods
    // MARK: Configure
    private func configure() {
        configureDimmedView()
        configureContentView()
    }
    
    private func configureDimmedView() {
        dimmedView = UIView()
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.66)
    }
    
    private func configureContentView() {
        contentView = DetailFormContentView()
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsDimmedView()
        makeConstraintsContentView()
    }
    
    private func makeConstraintsDimmedView() {
        dimmedView.snp.makeConstraints { make in
            make.centerX.centerY.width.height.equalToSuperview()
        }
    }
    
    private func makeConstraintsContentView() {
        contentView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
