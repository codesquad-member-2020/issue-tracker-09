//
//  MileStoneTableViewCell.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/27.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class MileStoneTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier: String = "MileStoneTableViewCell"
    private var informationView: MileStoneInformationView!
    private var progressView: MileStoneProgressView!
    
    // MARK: - Lifecycle
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
    func apply(mileStone: MileStone) {
        apply(information: mileStone)
        apply(progress: mileStone)
    }
    
    private func apply(information: MileStoneInforamationable) {
        informationView.apply(information)
    }
    
    private func apply(progress: MileStoneProgressable) {
        progressView.apply(progress)
    }
    
    // MARK: Configure
    private func configure() {
        configureInformationView()
        configureProgressView()
    }
    
    private func configureInformationView() {
        informationView = MileStoneInformationView()
        addSubview(informationView)
    }
    
    private func configureProgressView() {
        progressView = MileStoneProgressView()
        addSubview(progressView)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsInformationView()
        makeConstraintsProgressView()
    }
    
    private func makeConstraintsInformationView() {
        informationView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.trailing.equalTo(progressView.snp.leading).inset(12)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().inset(8)
        }
    }
    
    private func makeConstraintsProgressView() {
        progressView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
}
