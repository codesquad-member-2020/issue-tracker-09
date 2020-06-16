//
//  ColorView.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class ColorView: UIView {
    
    // MARK: Properties
    private var titleLabel: UILabel!
    private var hexLabel: UILabel!
    private var colorPreView: UIView!
    var generateButton: UIButton!
    
    // MARK: Lifecycle
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
    
    func resetColorView() {
        hexLabel.text = ""
        colorPreView.backgroundColor = .clear
    }
    
    // MARK: Methods
    private func configure() {
        configureTitleLabel()
        configureHexLabel()
        configureColorPreView()
        configureGenerateButton()
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "색상"
        titleLabel.font = .systemFont(ofSize: 14)
        addSubview(titleLabel)
    }
    
    private func configureHexLabel() {
        hexLabel = UILabel()
        hexLabel.font = .systemFont(ofSize: 14)
        hexLabel.textAlignment = .center
        addSubview(hexLabel)
    }
    
    private func configureColorPreView() {
        colorPreView = UIView()
        colorPreView.layer.cornerRadius = 8
        addSubview(colorPreView)
    }
    
    private func configureGenerateButton() {
        generateButton = UIButton()
        generateButton.setImage(UIImage(systemName: "arrow.clockwise"),
                                for: .normal)
        generateButton.tintColor = .black
        addSubview(generateButton)
    }
    
    private func makeConstraints() {
        makeConstraintsTitleLabel()
        makeConstraintsHexLabel()
        makeConstraintsColorPreView()
        makeConstraintsGenerateButton()
    }
    
    private func makeConstraintsTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(titleLabel.snp.height)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsHexLabel() {
        hexLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsColorPreView() {
        colorPreView.snp.makeConstraints { make in
            make.leading.equalTo(hexLabel.snp.trailing).offset(8)
            make.height.equalTo(hexLabel.snp.height)
            make.width.equalTo(hexLabel.snp.width)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsGenerateButton() {
        generateButton.snp.makeConstraints { make in
            make.leading.equalTo(colorPreView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(generateButton.snp.height)
            make.centerY.equalToSuperview()
        }
    }
}
