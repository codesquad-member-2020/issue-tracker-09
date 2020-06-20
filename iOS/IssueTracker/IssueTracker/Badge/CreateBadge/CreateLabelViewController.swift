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
        let hexColor = colorView.color?.hexString
        let title = contentView.contentText.0
        let subtitle = contentView.contentText.1
        let postLabel = PostLabel(title: title,
                                  contents: subtitle,
                                  colorCode: hexColor!)
        IssueTrackerNetworkImpl.shared.request(postLabel,
                                               providing: Endpoint.init(path: .labels),
                                               method: "POST",
                                               headers: ["application/json":"Content-Type"])
            .sink(receiveCompletion: {
                guard case .failure(let error) = $0 else { return }
                let alertViewController = UIAlertController.errorAlert(message: error.message)
                self.present(alertViewController,
                             animated: true)
            }) { _ in }
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
