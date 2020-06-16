//
//  DetailFormStackView.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/15.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class DetailFormStackView: UIStackView {
    
    // MARK: - Properties
    private var titleView: UIView!
    private var innerTitleLabel: UILabel!
    private var innerTitleTextField: UITextField!
    private var subTitleView: UIView!
    private var innerSubtitleLabel: UILabel!
    private var innerSubtitleTextField: UITextField!
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraints()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        makeConstraints()
    }
    
    // MARK: - Methods
    func apply(subtitle: String, placeHolder: String? = nil) {
        innerSubtitleLabel.text = subtitle
        innerSubtitleTextField.placeholder = placeHolder
    }
    
    // MARK: Configure
    private func configure() {
        axis = .vertical
        distribution = .fillEqually
        configureTitleView()
        configureSubtitleView()
    }
    
    private func configureTitleView() {
        titleView = UIView()
        configureInnerTitleLabel()
        configureInnerTextField()
        addArrangedSubview(titleView)
    }
    
    private func configureInnerTitleLabel() {
        innerTitleLabel = UILabel()
        innerTitleLabel.text = "제목"
        innerTitleLabel.font = .systemFont(ofSize: 14)
        titleView.addSubview(innerTitleLabel)
    }
    
    private func configureInnerTextField() {
        innerTitleTextField = UITextField()
        innerTitleTextField.font = .systemFont(ofSize: 14)
        titleView.addSubview(innerTitleTextField)
    }
    
    private func configureSubtitleView() {
        subTitleView = UIView()
        configureSubtitleLabel()
        configureSubtitleTextField()
        addArrangedSubview(subTitleView)
    }
    
    private func configureSubtitleLabel() {
        innerSubtitleLabel = UILabel()
        innerSubtitleLabel.font = .systemFont(ofSize: 14)
        subTitleView.addSubview(innerSubtitleLabel)
    }
    
    private func configureSubtitleTextField() {
        innerSubtitleTextField = UITextField()
        innerSubtitleTextField.font = .systemFont(ofSize: 14)
        subTitleView.addSubview(innerSubtitleTextField)
    }
    
    // MARK: Constratins
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
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(innerTitleLabel.snp.height)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsInnerTitleTextField() {
        innerTitleTextField.snp.makeConstraints { make in
            make.leading.equalTo(innerTitleLabel.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsInnerSubtitleLabel() {
        innerSubtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(innerSubtitleLabel.snp.height)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsInnerSubtitleTextField() {
        innerSubtitleTextField.snp.makeConstraints { make in
            make.leading.equalTo(innerSubtitleLabel.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
