//
//  ColorView.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class ColorView: UIView {
    
    // MARK: - Properties
    private var titleLabel: UILabel!
    private var hexLabel: UILabel!
    private var colorPreView: UIView!
    private var separtorLine: UIView!
    private var generateButton: UIButton!
    private var subscriber: AnyCancellable?
    @Published var color: UIColor?
    
    // MARK: - Lifecycle
    init(color: UIColor?) {
        self.color = color
        super.init(frame: .zero)
        configure()
        makeConstraints()
        bindViewModelToView()
    }
    
    required init?(coder: NSCoder) {
        color = UIColor.random
        super.init(coder: coder)
        configure()
        makeConstraints()
        bindViewModelToView()
    }
    
    // MARK: - Methods
    func resetColorView() {
        hexLabel.text?
            .removeAll()
        colorPreView.backgroundColor = .clear
    }
    
    // MARK: Configure
    private func configure() {
        configureTitleLabel()
        configureHexLabel()
        configureColorPreView()
        configureGenerateButton()
        configureSepertorLine()
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel(font: .systemFont(ofSize: 14),
                             textColor: .black)
        titleLabel.text = "색상"
        addSubview(titleLabel)
    }
    
    private func configureHexLabel() {
        hexLabel = UILabel(font: .systemFont(ofSize: 14),
                           textColor: .black)
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
        generateButton
            .setImage(UIImage(systemName: "arrow.clockwise"),
                      for: .normal)
        generateButton.tintColor = .black
        generateButton
            .addTarget(self,
                       action: #selector(generateRandomColor),
                       for: .touchUpInside)
        addSubview(generateButton)
    }
    
    private func configureSepertorLine() {
        separtorLine = UIView()
        separtorLine.backgroundColor = .lightGray
        addSubview(separtorLine)
    }
    
    // MARK: Constraints
    private func makeConstraints() {
        makeConstraintsTitleLabel()
        makeConstraintsHexLabel()
        makeConstraintsColorPreView()
        makeConstraintsGenerateButton()
        makeConstraintsSeparatorLine()
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
            make.height.equalTo(hexLabel.snp.height).multipliedBy(1.2)
            make.width.equalTo(hexLabel.snp.width)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeConstraintsGenerateButton() {
        generateButton.snp.makeConstraints { make in
            make.leading.equalTo(colorPreView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(generateButton.snp.height)
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
    
    // MARK: Bind
    private func bindViewModelToView() {
        subscriber = $color
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.subscriber?.cancel()
            }) { [weak self] color in
                self?.hexLabel.text = color?.hexString
                UIView.animate(withDuration: 0.2) {
                    self?.colorPreView.backgroundColor = color
                }
        }
    }
    
    // MARK: Objc
    @objc private func generateRandomColor() {
        color = UIColor.random
    }
}
