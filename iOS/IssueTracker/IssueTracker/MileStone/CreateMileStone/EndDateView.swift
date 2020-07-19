//
//  EndDateView.swift
//  IssueTracker
//
//  Created by Cloud on 2020/07/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class EndDateView: UIView {
    
    // MARK: - Properties
    private var titleLabel: UILabel!
    private var textField: UITextField!
    private var separtorLine: UIView!
    
    // MARK: - Lifecycle
    init(_ mileStone: MileStoneInforamationable?) {
        super.init(frame: .zero)
        configure(mileStone)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure(nil)
        makeConstraints()
    }
    
    // MARK: - Methods
    
    // MARK: Configure
    private func configure(_ mileStone: MileStoneInforamationable?) {
        configureTitleLabel()
        configureTextField(mileStone?.dueOn)
        configureSepartorLine()
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel(font: .systemFont(ofSize: 14),
                             textColor: .black)
        titleLabel.numberOfLines = 0
        titleLabel.text = "완료\n날짜"
        addSubview(titleLabel)
    }
    
    private func configureTextField(_ text: String?) {
        textField = UITextField()
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "YY-mm-dd"
        textField.text = text
        addSubview(textField)
    }
    
    private func configureSepartorLine() {
        separtorLine = UIView()
        separtorLine.backgroundColor = .lightGray
        addSubview(separtorLine)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsTitleLabel()
        makeConstraintsTextField()
        makeConstraintsSeparatorLine()
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
            make.leading.equalTo(titleLabel.snp.trailing).inset(-16)
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsSeparatorLine() {
        separtorLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
    }
}