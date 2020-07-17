//
//  TitleHeaderView.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class TitleHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    static let identifier: String = "ReusableHeaderView"
    static let height: CGFloat = 100
    private var titleLabel: UILabel!
    private var separatorView: UIView!
    var addButton: UIButton!
    
    // MARK: - Lifecycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        makeConstraints()
    }
    
    // MARK: - Methods
    func apply(title: String) {
        titleLabel.text = title
    }
    
    // MARK: Configure
    private func configure() {
        tintColor = .white
        configureTitleLabel()
        configureAddButton()
        configureSeparatorView()
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel(font: .boldSystemFont(ofSize: 32),
                             textColor: .black)
        addSubview(titleLabel)
    }
    
    private func configureAddButton() {
        addButton = UIButton()
        addButton
            .setImage(UIImage(systemName: "plus"),
                      for: .normal)
        addButton.tintColor = .systemBlue
        addSubview(addButton)
    }
    
    private func configureSeparatorView() {
        separatorView = UIView()
        separatorView.backgroundColor = .separator
        separatorView.alpha = 0.4
        addSubview(separatorView)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsTitleLabel()
        makeConstraintsAddButton()
        makeConstraintsSeparatorView()
    }
    
    private func makeConstraintsTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func makeConstraintsAddButton() {
        addButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(4)
            make.width.equalTo(addButton.snp.height)
            make.width.equalTo(32)
        }
    }
    
    private func makeConstraintsSeparatorView() {
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
