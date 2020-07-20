//
//  CategoryFormViewController.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

enum FormStyle {
    case editLabel(Label)
    case editMileStone(DeficientMileStone)
    case save
}

class CategoryFormViewController: UIViewController {
    
    // MARK: - Properties
    private var dimmedView: UIView!
    var contentView: DetailFormContentView!
    var labelWidth: CGFloat {
        return contentView.labelWidth
    }
    
    // MARK: - Lifecycle
    init(_ style: FormStyle) {
        super.init(nibName: nil,
                   bundle: nil)
        checkStyle(style)
        setTitle(style)
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
        case let .editLabel(label):
            configure(title: label.title,
                      subtitle: label.contents)
        case let .editMileStone(mileStone):
            configure(title: mileStone.title,
                      subtitle: mileStone.contents)
        }
    }
    
    func setTitle(_ style: FormStyle) {
        switch style {
        case .save:
            contentView.saveButton
                .setTitle("save",
                          for: .normal)
        default:
            contentView.saveButton
                .setTitle("edit",
                          for: .normal)
        }
    }
    
    // MARK: Configure
    private func configure(title: String?, subtitle: String?) {
        configureDimmedView()
        configureContentView(title: title,
                             subtitle: subtitle)
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
        contentView.dismissButton
            .addTarget(self,
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
