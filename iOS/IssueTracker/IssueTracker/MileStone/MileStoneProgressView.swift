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
        guard let openIssue = progress.numberOfOpenIssue,
            let closedIssue = progress.numberOfClosedIssue else {
                openIssueLabel.text = "open"
                closedIssueLabel.text = "closed"
                
                return
        }
        let rate = closedIssue / openIssue
        progressLabel.text = String(rate) + "%"
        openIssueLabel.text = String(openIssue) + "open"
        closedIssueLabel.text = String(closedIssue) + "closed"
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
