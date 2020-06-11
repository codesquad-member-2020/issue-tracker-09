//
//  LabelTableViewCell.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class LabelTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier: String = "LabelTableViewCell"
    private var label: ReusableLabel!
    private var labelDescription: UILabel!
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        makeConstraints()
    }
    
    // MARK: - Methods
    // MARK: Configure
    private func configure() {
        configureLabel()
        configureLabelDescription()
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }
    
    private func configureLabel() {
        label = ReusableLabel()
        label.font = .systemFont(ofSize: 13)
        addSubview(label)
    }
    
    private func configureLabelDescription() {
        labelDescription = UILabel()
        labelDescription.font = .systemFont(ofSize: 15)
        labelDescription.textColor = .systemGray
        addSubview(labelDescription)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsLabel()
        makeConstraintsLabelDescription()
    }
    
    private func makeConstraintsLabel() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    private func makeConstraintsLabelDescription() {
        labelDescription.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(8)
            make.leading.equalTo(label.snp.leading)
        }
    }
}
