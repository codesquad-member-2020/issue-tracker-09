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
    var contentView: DetailFormContentView!
    
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
        view.addSubview(dimmedView)
    }
    
    func configureContentView() {
        contentView = DetailFormContentView()
        view.addSubview(contentView)
        contentView.dismissButton.addTarget(self,
                                            action: #selector(dismissContentView),
                                            for: .touchUpInside)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsDimmedView()
        makeConstraintsContentView()
    }
    
    private func makeConstraintsDimmedView() {
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func makeConstraintsContentView() {
        contentView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc private func dismissContentView() {
        dismiss(animated: true)
    }
}
