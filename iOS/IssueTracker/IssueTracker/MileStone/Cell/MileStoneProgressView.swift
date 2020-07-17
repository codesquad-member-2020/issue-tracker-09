//
//  MileStoneProgressView.swift
//  IssueTracker
//
//  Created by Cloud on 2020/07/02.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class MileStoneProgressView: UIView {
    
    // MARK: - Properties
    private var progressLabel: UILabel!
    private var openIssueLabel: UILabel!
    private var closedIssueLabel: UILabel!
    
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
    
    // MARK: - Method
    func apply(_ progress: MileStoneProgressable) {
        progressLabel.text = String(progress.progressRate) + "%"
        openIssueLabel.text = String(progress.numberOfOpenIssue) + "open"
        closedIssueLabel.text = String(progress.numberOfClosedIssue) + "closed"
    }
    
    // MARK: Configure
    private func configure() {
        configureProgressLabel()
        configureOpenIssueLabel()
        configureClosedIssueLabel()
    }
    
    private func configureProgressLabel() {
        progressLabel = UILabel(font: .boldSystemFont(ofSize: 11),
                                textColor: .systemGreen)
        progressLabel.setContentHuggingPriority(.fittingSizeLevel,
                                                for: .vertical)
        progressLabel.textAlignment = .right
        addSubview(progressLabel)
    }
    
    private func configureOpenIssueLabel() {
        openIssueLabel = UILabel(font: .systemFont(ofSize: 11),
                                 textColor: .darkGray)
        openIssueLabel.textAlignment = .right
        addSubview(openIssueLabel)
    }
    
    private func configureClosedIssueLabel() {
        closedIssueLabel = UILabel(font: .systemFont(ofSize: 11),
                                   textColor: .darkGray)
        addSubview(closedIssueLabel)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsProgressLabel()
        makeConstraintsOpenIssueLabel()
        makeConstraintsClosedIssueLabel()
    }
    
    private func makeConstraintsProgressLabel() {
        progressLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    private func makeConstraintsOpenIssueLabel() {
        openIssueLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(progressLabel.snp.bottom).inset(-6)
        }
    }
    
    private func makeConstraintsClosedIssueLabel() {
        closedIssueLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(openIssueLabel.snp.bottom)
        }
    }
}
