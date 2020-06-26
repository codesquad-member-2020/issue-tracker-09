//
//  CategoryFormViewController.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

enum FormStyle {
    case edit(Label)
    case save
}

class CategoryFormViewController: UIViewController {
    
    // MARK: - Properties
    private var dimmedView: UIView!
    var contentView: DetailFormContentView!
    
    // MARK: - Lifecycle
    init(style: FormStyle) {
        super.init(nibName: nil,
                   bundle: nil)
        checkStyle(style)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        checkStyle(nil)
        makeConstraints()
    }
    
    // MARK: - Methods
    func checkStyle(_ style: FormStyle?) {
        guard let style = style else { return }
        switch style {
        case .save:
            configure(title: nil,
                      subtitle: nil)
        case let .edit(label):
            configure(title: label.title,
                      subtitle: label.contents)
        }
    }
    // MARK: Configure
    private func configure(title: String?, subtitle: String?) {
        configureDimmedView()
        configureContentView(title: title, subtitle: subtitle)
    }
    
    private func configureDimmedView() {
        dimmedView = UIView()
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(0.66)
        view.addSubview(dimmedView)
    }
    
    func configureContentView(title: String?, subtitle: String?) {
        contentView = DetailFormContentView(title: title,
                                            subtitle: subtitle)
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
