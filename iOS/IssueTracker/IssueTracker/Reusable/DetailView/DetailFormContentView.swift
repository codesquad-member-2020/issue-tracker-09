//
//  DetailFormContentView.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class DetailFormContentView: UIView {
    
    // MARK: - Properties
    private var seperatorLine: UIView!
    private var saveButton: SaveButton!
    private var contentView: DetailFormStackView!
    var dismissButton: UIButton!
    var resetButton: UIButton!
    
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
    func apply(subtitle: String) {
        contentView.apply(subtitle: subtitle)
    }
    
    func addArrangedSubview(_ view: UIView) {
        contentView.addArrangedSubview(view)
    }
    
    func resetContentView() {
        contentView.resetDetailForm()
    }
    
    // MARK: Configure
    private func configure() {
        backgroundColor = .systemBackground
        configureDismissButton()
        configureSeperatorLine()
        configureResetButton()
        configureSaveButton()
        configureContentView()
    }
    
    private func configureDismissButton() {
        dismissButton = UIButton()
        dismissButton.tintColor = .black
        dismissButton.setImage(UIImage(systemName: "xmark"),
                               for: .normal)
        addSubview(dismissButton)
    }
    
    private func configureSeperatorLine() {
        seperatorLine = UIView()
        seperatorLine.backgroundColor = .systemGray
        addSubview(seperatorLine)
    }
    
    private func configureResetButton() {
        resetButton = UIButton()
        resetButton.setTitleColor(.systemGray,
                                  for: .normal)
        resetButton.setTitle("reset",
                             for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 13)
        addSubview(resetButton)
    }
    
    private func configureSaveButton() {
        saveButton = SaveButton()
        addSubview(saveButton)
    }
    
    private func configureContentView() {
        contentView = DetailFormStackView()
        addSubview(contentView)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsDismissButton()
        makeConstraintsSeperatorLine()
        makeConstraintsResetButton()
        makeConstraintsSaveButton()
        makeConstratinsContentView()
    }
    
    private func makeConstraintsDismissButton() {
        dismissButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(12)
            make.width.equalTo(dismissButton.snp.height)
            make.width.equalTo(32)
        }
    }
    
    private func makeConstraintsSeperatorLine() {
        seperatorLine.snp.makeConstraints { make in
            make.top.equalTo(dismissButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func makeConstraintsResetButton() {
        resetButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(24)
        }
    }
    
    private func makeConstraintsSaveButton() {
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(resetButton.snp.centerY)
        }
    }
    
    private func makeConstratinsContentView() {
        contentView.snp.makeConstraints { make in
            make.top.equalTo(seperatorLine.snp.bottom)
            make.bottom.equalTo(saveButton.snp.top)
            make.leading.trailing.equalToSuperview()
            
        }
    }
}
