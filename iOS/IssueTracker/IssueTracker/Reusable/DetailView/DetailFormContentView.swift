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
    private var dismissButton: UIButton!
    private var seperatorLine: UIView!
    private var resetButton: UIButton!
    private var saveButton: UIButton!
//    private var contentView: DetailFormStackView!
    
    init(subtitle: String, placeHolder: String? = nil) {
        super.init(frame: .zero)
        configure()
        makeConstraints()
//        contentView = DetailFormStackView(subtitle: subtitle, placeHolder: placeHolder)
//        contentView.snp.makeConstraints { make in
//            make.top.equalTo(seperatorLine.snp.bottom)
//            make.bottom.equalTo(saveButton.snp.top)
//            make.leading.trailing.equalToSuperview()
//        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        contentView = DetailFormStackView(subtitle: "")
        configure()
        makeConstraints()
    }
    
//    // MARK: - Methods
//    func addContentView(view: UIView) {
//        addSubview(view)
//        view.snp.makeConstraints { make in
//            make.top.equalTo(seperatorLine.snp.bottom)
//            make.bottom.equalTo(saveButton.snp.top)
//            make.leading.trailing.equalToSuperview()
//        }
//    }
    
    // MARK: Configure
    private func configure() {
        configureDismissButton()
        configureSeperatorLine()
        configureResetButton()
        configureSaveButton()
    }
    
    private func configureDismissButton() {
        dismissButton = UIButton()
        dismissButton.tintColor = .black
        dismissButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        addSubview(dismissButton)
    }
    
    private func configureSeperatorLine() {
        seperatorLine = UIView()
        seperatorLine.backgroundColor = .systemGray
        addSubview(seperatorLine)
    }
    
    private func configureResetButton() {
        resetButton = UIButton()
        resetButton.setTitleColor(.systemGray, for: .normal)
        resetButton.setTitle("reset", for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 13)
        addSubview(resetButton)
    }
    
    private func configureSaveButton() {
        saveButton = UIButton()
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.setTitle("save", for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsDismissButton()
        makeConstraintsSeperatorLine()
        makeConstraintsResetButton()
        makeConstraintsSaveButton()
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
            make.top.equalTo(dismissButton.snp.bottom).inset(12)
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
            make.trailing.equalToSuperview().inset(-8)
            make.centerY.equalTo(resetButton.snp.centerY)
        }
    }
}
