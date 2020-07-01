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
    func apply(information: MileStoneInforamationable) {
        informationView.apply(information)
    }
    
    // MARK: Configure
    private func configure() {
        configureInformationView()
    }
    
    private func configureInformationView() {
        informationView = MileStoneInformationView()
        addSubview(informationView)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsInformationView()
    }
    
    private func makeConstraintsInformationView() {
        informationView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().inset(8)
        }
    }
}
