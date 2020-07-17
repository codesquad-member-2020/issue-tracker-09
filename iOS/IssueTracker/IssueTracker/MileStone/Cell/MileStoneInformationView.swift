//
//  MileStoneInformationView.swift
//  IssueTracker
//
//  Created by Cloud on 2020/07/01.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class MileStoneInformationView: UIView {
    
    // MARK: - Properties
    private var badgeLabel: BadgeLabel!
    private var descriptionLabel: UILabel!
    private var deadLineLabel: UILabel!
    
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
    func apply(_ information: MileStoneInforamationable) {
        badgeLabel.text = information.title
        descriptionLabel.text = information.contents
        deadLineLabel.text = information.dueOn
    }
    
    // MARK: Configure
    private func configure() {
        configureBadgeLabel()
        configureDescriptionLabel()
        configureDeadLineLabel()
    }
    
    private func configureBadgeLabel() {
        badgeLabel = BadgeLabel(font: .boldSystemFont(ofSize: 15),
                                textColor: .systemGray)
        badgeLabel
            .setContentHuggingPriority(.required,
                                             for: .vertical)
        badgeLabel
            .apply(borderColor: UIColor.systemGray.cgColor,
                         borderWidth: 1)
        addSubview(badgeLabel)
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel = UILabel(font: .systemFont(ofSize: 14),
                                   textColor: .systemGray)
        addSubview(descriptionLabel)
    }
    
    private func configureDeadLineLabel() {
        deadLineLabel = UILabel(font: .systemFont(ofSize: 12),
                                textColor: .systemGray)
        addSubview(deadLineLabel)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsBadgeLabel()
        makeConstraintsDescriptionLabel()
        makeConstraintsDeadLineLabel()
    }
    
    private func makeConstraintsBadgeLabel() {
        badgeLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
    }
    
    private func makeConstraintsDescriptionLabel() {
        descriptionLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.top.equalTo(badgeLabel.snp.bottom).inset(-8)
        }
    }
    
    private func makeConstraintsDeadLineLabel() {
        deadLineLabel.snp.makeConstraints { make in
            make.centerY.equalTo(badgeLabel.snp.centerY)
            make.leading.equalTo(badgeLabel.snp.trailing).inset(-8)
        }
    }
}
