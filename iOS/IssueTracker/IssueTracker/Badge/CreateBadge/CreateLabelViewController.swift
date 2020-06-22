//
//  CreateLabelViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class CreateLabelViewController: CategoryFormViewController {
    
    // MARK: - Properties
    private var colorView: ColorView!
    var subscription: Set<AnyCancellable> = .init()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Methods
    // MARK: Configure
    private func configure() {
        colorView = ColorView()
        contentView.addArrangedSubview(colorView)
        configureSaveButton()
    }
    
    override func configureContentView() {
        super.configureContentView()
        contentView.apply(subtitle: "설명")
        contentView.resetButton.addTarget(self,
                                          action: #selector(resetLabelContentView),
                                          for: .touchUpInside)
    }
    
    private func configureSaveButton() {
        contentView.saveButton.addTarget(self, action: #selector(saveLabelContent), for: .touchUpInside)
    }
    
    @objc private func saveLabelContent() {
        guard let hexColor = colorView.color?.hexString,
            let title = contentView.labelSubject.title else { return }
        let postLabel = PostLabel(title: title,
                                  contents: contentView.labelSubject.subtitle,
                                  colorCode: hexColor)
        UseCase.shared
            .encode(postLabel, endpoint: Endpoint(path: .labels()),
                    method: .post)
            .sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                let alertController = UIAlertController(message: error.message)
                self?.present(alertController,
                              animated: true)
            }) { _ in
                // MARK: ToDo 테이블 뷰 추가적인 작업 구현
        }
        .store(in: &subscription)
        dismiss(animated: true)
    }
    
    // MARK: Constraints
    override func makeConstraintsContentView() {
        super.makeConstraintsContentView()
        contentView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
        }
    }
    
    @objc private func resetLabelContentView() {
        contentView.resetContentView()
        colorView.resetColorView()
    }
}
