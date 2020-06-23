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
        let postLabel = Label(id: nil,
                              title: title,
                              contents: contentView.labelSubject.subtitle,
                              colorCode: hexColor)
        UseCase.shared
            .code(postLabel, endpoint: Endpoint(path: .labels()),
                  method: .post)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                let alertController = UIAlertController(message: error.message)
                self?.present(alertController,
                              animated: true)
            }) { [weak self] data, response in
                guard let label = data,
                    let statusCode = response?.statusCode else { return }
                switch statusCode {
                case 200 ..< 300:
                    guard let superViewController = self?.presentingViewController as? UITabBarController else { return }
                    guard let labelViewController = superViewController.customizableViewControllers?.first as? LabelTableViewController else { return }
                    labelViewController.dataSource.labels.append(label)
                default:
                    let alert = UIAlertController(message: "")
                    self?.present(alert,
                            animated: true)
                }
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
