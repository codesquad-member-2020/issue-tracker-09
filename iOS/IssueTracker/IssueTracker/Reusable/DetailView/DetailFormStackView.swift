//
//  DetailFormStackView.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/15.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

typealias LabelSubjects = (title: String?, subtitle: String?)

final class DetailFormStackView: UIStackView {
    
    // MARK: - Properties
    private var titleView: UIView!
    private var innerTitleLabel: UILabel!
    private var innerTitleTextField: UITextField!
    private var titleSeperatorLine: UIView!
    private var subTitleView: UIView!
    private var innerSubtitleLabel: UILabel!
    private var innerSubtitleTextField: UITextField!
    private var subtitleSeperatorLine: UIView!
    @Published var innerTitleTextFieldIsEmpty: Bool = false
    @Published var labelSubject: LabelSubjects = (title: nil, subtitle: nil)
    private var subscriptions: Set<AnyCancellable> = .init()
    
    // MARK: - Lifecycle
    init(title: String?, subtitle: String?) {
        super.init(frame: .zero)
        configure(title: title, subtitle: subtitle)
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
    
    func resetDetailForm() {
        innerTitleTextField.text = ""
        innerSubtitleTextField.text = ""
    }
    
    // MARK: Configure
    private func configure(title: String? = nil, subtitle: String? = nil) {
        axis = .vertical
        distribution = .fillEqually
        configureTitleView(title: title)
        configureSubtitleView(title: subtitle)
        bindViewToViewModel()
    }
    
    private func configureTitleLabel(title: String? = nil, fontSize font: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: font)
        
        return label
    }
    
    private func configureTextField(title: String?, fontSize font: CGFloat) -> UITextField {
        let textField = UITextField()
        textField.text = title
        textField.font = .systemFont(ofSize: font)
        
        return textField
    }
    
    private func configureSeperatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray
        
        return view
    }
    
    private func configureTitleView(title: String?) {
        titleView = UIView()
        configureInnerTitleLabel()
        configureInnerTextField(title: title)
        configureTitleSeperatorLine()
        addArrangedSubview(titleView)
    }
    
    private func configureInnerTitleLabel() {
        innerTitleLabel = configureTitleLabel(title: "제목", fontSize: 14)
        titleView.addSubview(innerTitleLabel)
    }
    
    private func configureInnerTextField(title: String?) {
        innerTitleTextField = configureTextField(title: title, fontSize: 14)
        titleView.addSubview(innerTitleTextField)
    }
    
    private func configureTitleSeperatorLine() {
        titleSeperatorLine = configureSeperatorView()
        titleView.addSubview(titleSeperatorLine)
    }
    
    private func configureSubtitleView(title: String?) {
        subTitleView = UIView()
        configureSubtitleLabel()
        configureSubtitleTextField(title: title)
        configureSubtitleSeperatorLine()
        addArrangedSubview(subTitleView)
    }
    
    private func configureSubtitleLabel() {
        innerSubtitleLabel = configureTitleLabel(fontSize: 14)
        subTitleView.addSubview(innerSubtitleLabel)
    }
    
    private func configureSubtitleTextField(title: String?) {
        innerSubtitleTextField = configureTextField(title: title, fontSize: 14)
        subTitleView.addSubview(innerSubtitleTextField)
    }
    
    private func configureSubtitleSeperatorLine() {
        subtitleSeperatorLine = configureSeperatorView()
        subTitleView.addSubview(subtitleSeperatorLine)
    }
    
    // MARK: Constratins
    private func makeConstraints() {
        makeConstraintsTitleView()
        makeConstraintsSubtitleView()
    }
    
    private func makeConstraintsTitleView() {
        makeConstraintsInnerTitleLabel()
        makeConstraintsInnerTitleTextField()
        makeConstraintsTitleSeperatorLine()
    }
    
    private func makeConstraintsSubtitleView() {
        makeConstraintsInnerSubtitleLabel()
        makeConstraintsInnerSubtitleTextField()
        makeConstraintsSubtitleSeperatorLine()
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
    
    private func makeConstraintsTitleSeperatorLine() {
        titleSeperatorLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
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
    
    private func makeConstraintsSubtitleSeperatorLine() {
        subtitleSeperatorLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
    }
    // MARK: Bind
    func bindViewToViewModel() {
        validateInnerTitleTextField()
        bindTextFieldtoSubject(textField: innerTitleTextField, type: true)
        bindTextFieldtoSubject(textField: innerSubtitleTextField, type: false)
    }
    
    func validateInnerTitleTextField() {
        innerTitleTextField.publisher(for: .editingChanged)
            .sink { [weak self] textField in
                self?.innerTitleTextFieldIsEmpty = !(textField.text?.isEmpty ?? true)
        }
        .store(in: &subscriptions)
    }
    
    
    func bindTextFieldtoSubject(textField: UITextField, type: Bool) {
        textField.publisher(for: .editingChanged)
            .sink { [weak self] textField in
                if type {
                    self?.labelSubject.title = textField.text
                } else {
                    self?.labelSubject.subtitle = textField.text
                }
        }
        .store(in: &subscriptions)
    }
}
