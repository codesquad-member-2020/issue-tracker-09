//
//  ReusableHeaderView.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class ReusableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    static let identifier: String = "ReusableHeaderView"
    static let height: CGFloat = 100
    private var titleLabel: UILabel!
    private var addButton: UIButton!
    
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
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 32)
        addSubview(titleLabel)
    }
    
    private func configureAddButton() {
        addButton = UIButton()
        addButton.setImage(UIImage(systemName: "plus"),
                           for: .normal)
        addButton.tintColor = .systemBlue
        addSubview(addButton)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsTitleLabel()
        makeConstraintsAddButton()
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
}
