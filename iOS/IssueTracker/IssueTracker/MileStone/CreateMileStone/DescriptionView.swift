//
//  DescriptionView.swift
//  IssueTracker
//
//  Created by Cloud on 2020/07/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class DescriptionView: UIView {
    
    // MARK: - Properties
    private var titleLabel: UILabel!
    private var textField: UITextField!
    private var sepertorLine: UIView!
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        makeConstraints()
    }
    
    // MARK: - Methods
    
    // MARK: Configure
    private func configure() {
        configureTitleLabel()
        configureTextField()
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel(font: .systemFont(ofSize: 14),
                             textColor: .black)
        addSubview(titleLabel)
    }
    
    private func configureTextField() {
        textField = UITextField()
        addSubview(textField)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsTitleLabel()
        makeConstraintsTextField()
    }
    
    private func makeConstraintsTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(titleLabel.snp.height)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsTextField() {
        textField.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).inset(24)
            make.trailing.centerY.equalToSuperview()
            make.top.equalToSuperview().inset(4)
        }
    }
}
