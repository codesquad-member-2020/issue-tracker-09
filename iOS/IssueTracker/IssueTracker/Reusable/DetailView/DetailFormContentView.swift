//
//  DetailFormContentView.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class DetailFormContentView: UIView {
    
    // MARK: - Properties
    private var seperatorLine: UIView!
    private var contentView: DetailFormStackView!
    private var subscriptions: Set<AnyCancellable> = .init()
    var saveButton: DecisionButton!
    var dismissButton: UIButton!
    var resetButton: UIButton!
    var dataSubjects: dataSubjects = (nil, nil)
    var labelWidth: CGFloat {
        return contentView.labelWidth
    }
    
    // MARK: - Lifecycle
    init(title: String?, subtitle: String?) {
        super.init(frame: .zero)
        configure(title: title,
                  subtitle: subtitle)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure(title: nil,
                  subtitle: nil)
        makeConstraints()
    }
    
    // MARK: - Methods    
    func addArrangedSubview(_ view: UIView) {
        contentView
            .addArrangedSubview(view)
    }
    
    func resetContentView() {
        contentView
            .resetDetailForm()
    }
    
    // MARK: Configure
    private func configure(title: String?, subtitle: String?) {
        backgroundColor = .systemBackground
        configureDismissButton()
        configureSeperatorLine()
        configureResetButton()
        configureSaveButton()
        configureContentView(title: title,
                             subtitle: subtitle)
        bind()
    }
    
    private func configureDismissButton() {
        dismissButton = UIButton()
        dismissButton.tintColor = .black
        dismissButton
            .setImage(UIImage(systemName: "xmark"),
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
        resetButton
            .setTitleColor(.systemGray,
                                  for: .normal)
        resetButton
            .setTitle("reset",
                             for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 13)
        addSubview(resetButton)
    }
    
    private func configureSaveButton() {
        saveButton = DecisionButton()
        addSubview(saveButton)
    }
    
    private func configureContentView(title: String?, subtitle: String?) {
        contentView = DetailFormStackView(title: title,
                                          subtitle: subtitle)
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
            make.top.equalTo(dismissButton.snp.bottom).inset(-8)
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
            make.top.equalTo(seperatorLine.snp.bottom).inset(-16)
            make.bottom.equalTo(saveButton.snp.top).inset(-16)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: Bind
    private func bind() {
        bindViewToViewModel()
        passDataViewToViewController()
    }
    
    private func bindViewToViewModel() {
        contentView.$innerTitleTextFieldIsEmpty
            .sink { [weak self] selected in
                self?.saveButton.isEnabled = selected
        }
        .store(in: &subscriptions)
    }
    
    private func passDataViewToViewController() {
        contentView.$labelSubject
            .sink { [weak self] labelSubject in
                self?.dataSubjects = labelSubject
        }
        .store(in: &subscriptions)
    }
}
