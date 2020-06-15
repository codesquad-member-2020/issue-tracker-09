//
//  DetailFormStackView.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/15.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class DetailFormStackView: UIStackView {
    private var titleView: UIView!
    private var innerTitleLabel: UILabel!
    private var innerTitleTextField: UITextField!
    private var subTitleView: UIView!
    private var innerSubtitleLabel: UILabel!
    private var innerSubtitleTextField: UITextField!
    
    init(subtitle: String, placeHolder: String? = nil) {
        super.init(frame: .zero)
        configure()
        makeConstraints()
        apply(subtitle: subtitle, placeHolder: placeHolder)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        makeConstraints()
        apply(subtitle: "")
    }
    
    private func apply(subtitle: String, placeHolder: String? = nil) {
        innerSubtitleLabel.text = subtitle
        innerSubtitleTextField.placeholder = placeHolder
    }
    
    private func configure() {
        axis = .vertical
        distribution = .fillEqually
        configureTitleView()
        configureSubtitleView()
    }
    
    private func configureTitleView() {
        titleView = UIView()
        configureInnerTitleLabel()
        innerTitleTextField = UITextField()
        titleView.addSubview(innerTitleLabel)
        titleView.addSubview(innerTitleTextField)
        titleView.addSeperatorLayer()
        addArrangedSubview(titleView)
    }
    
    private func configureInnerTitleLabel() {
        innerTitleLabel = UILabel()
        innerTitleLabel.text = "제목"
        innerTitleLabel.font = .systemFont(ofSize: 14)
    }
    
    private func configureSubtitleView() {
        subTitleView = UIView()
        configureSubtitleLabel()
        innerSubtitleTextField = UITextField()
        subTitleView.addSubview(innerSubtitleLabel)
        subTitleView.addSubview(innerSubtitleTextField)
        subTitleView.addSeperatorLayer()
        addArrangedSubview(subTitleView)
    }
    
    private func configureSubtitleLabel() {
        innerSubtitleLabel = UILabel()
        innerSubtitleLabel.font = .systemFont(ofSize: 14)
    }
    
    private func makeConstraints() {
        makeConstraintsTitleView()
        makeConstraintsSubtitleView()
    }
    
    private func makeConstraintsTitleView() {
        makeConstraintsInnerTitleLabel()
        makeConstraintsInnerTitleTextField()
    }
    
    private func makeConstraintsSubtitleView() {
        makeConstraintsInnerSubtitleLabel()
        makeConstraintsInnerSubtitleTextField()
    }
    
    private func makeConstraintsInnerTitleLabel() {
        innerTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsInnerTitleTextField() {
        innerTitleTextField.snp.makeConstraints { make in
            make.leading.equalTo(innerTitleLabel.snp.trailing).offset(16)
            make.trailing.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsInnerSubtitleLabel() {
        innerSubtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsInnerSubtitleTextField() {
        innerSubtitleTextField.snp.makeConstraints { make in
            make.leading.equalTo(innerSubtitleLabel.snp.trailing).offset(16)
            make.trailing.centerY.equalToSuperview()
        }
    }
}
