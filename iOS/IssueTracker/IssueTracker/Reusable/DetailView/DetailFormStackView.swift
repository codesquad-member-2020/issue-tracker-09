//
//  DetailFormStackView.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/15.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

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
    var subject: CurrentValueSubject<Bool, Never> = .init(false)
    var titleSubject: CurrentValueSubject<String, Never> = .init("")
    var subtitleSubject: CurrentValueSubject<String?, Never> = .init(nil)
    var subscription: Set<AnyCancellable> = .init()
    
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
    func bindViewToViewModel() {
        innerTitleTextField.publisher(for: .editingChanged)
            .sink { [weak self] textField in
                self?.subject.send(!(textField.text?.isEmpty ?? true))
        }.store(in: &subscription)
    }
    
    func bindTextFieldtoSubject() {
        innerTitleTextField.publisher(for: .editingChanged)
            .sink { textField in
                self.titleSubject.send(textField.text!)
        }.store(in: &subscription)
        
        innerSubtitleTextField.publisher(for: .editingChanged)
            .sink { textField in
                self.subtitleSubject.send(textField.text!)
        }.store(in: &subscription)
    }
    
    func apply(subtitle: String, placeHolder: String? = nil) {
        innerSubtitleLabel.text = subtitle
        innerSubtitleTextField.placeholder = placeHolder
    }
    
    func resetDetailForm() {
        innerTitleTextField.text = ""
        innerSubtitleTextField.text = ""
    }
    
    // MARK: Configure
    private func configure() {
        axis = .vertical
        distribution = .fillEqually
        configureTitleView()
        configureSubtitleView()
        bindViewToViewModel()
        bindTextFieldtoSubject()
    }
    
    private func configureTitleLabel(title: String? = nil, fontSize font: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: font)
        
        return label
    }
    
    private func configureTextField(fontSize font: CGFloat) -> UITextField {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: font)
        
        return textField
    }
    
    private func configureSeperatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray
        
        return view
    }
    
    private func configureTitleView() {
        titleView = UIView()
        configureInnerTitleLabel()
        configureInnerTextField()
        configureTitleSeperatorLine()
        addArrangedSubview(titleView)
    }
    
    private func configureInnerTitleLabel() {
        innerTitleLabel = configureTitleLabel(title: "제목", fontSize: 14)
        titleView.addSubview(innerTitleLabel)
    }
    
    private func configureInnerTextField() {
        innerTitleTextField = configureTextField(fontSize: 14)
        titleView.addSubview(innerTitleTextField)
    }
    
    private func configureTitleSeperatorLine() {
        titleSeperatorLine = configureSeperatorView()
        titleView.addSubview(titleSeperatorLine)
    }
    
    private func configureSubtitleView() {
        subTitleView = UIView()
        configureSubtitleLabel()
        configureSubtitleTextField()
        configureSubtitleSeperatorLine()
        addArrangedSubview(subTitleView)
    }
    
    private func configureSubtitleLabel() {
        innerSubtitleLabel = configureTitleLabel(fontSize: 14)
        subTitleView.addSubview(innerSubtitleLabel)
    }
    
    private func configureSubtitleTextField() {
        innerSubtitleTextField = configureTextField(fontSize: 14)
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
}
