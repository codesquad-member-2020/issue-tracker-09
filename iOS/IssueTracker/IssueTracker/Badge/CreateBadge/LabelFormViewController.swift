//
//  LabelFormViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class LabelFormViewController: CategoryFormViewController {
    
    // MARK: - Properties
    private var colorView: ColorView!
    var subscription: Set<AnyCancellable> = .init()
    
    // MARK: - Lifecycle
    override init(style: FormStyle) {
        super.init(style: style)
        configure(style: style)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure(style: nil)
    }
    
    // MARK: - Methods
    // MARK: Configure
    private func configure(style: FormStyle?) {
        colorView = ColorView()
        contentView.addArrangedSubview(colorView)
        addTartgetButton(style: style)
    }
    
    override func configureContentView(title: String?, subtitle: String?) {
        super.configureContentView(title: title, subtitle: subtitle)
        contentView.apply(subtitle: "설명")
        contentView.resetButton.addTarget(self,
                                          action: #selector(resetLabelContentView),
                                          for: .touchUpInside)
    }
    
    private func addTartgetButton(style: FormStyle?) {
        switch style {
        case .save:
            contentView.saveButton.addTarget(self,
                                             action: #selector(saveLabelContent),
                                             for: .touchUpInside)
        default:
            
            contentView.saveButton.addTarget(self,
                                             action: #selector(editLabelContent),
                                             for: .touchUpInside)
        }
    }
    
    func request(data: Label, method: HTTPMethod) {
        UseCase.shared
            .code(data, endpoint: Endpoint(path: .labels()),
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
    }
    
    @objc private func saveLabelContent() {
        guard let hexColor = colorView.color?.hexString,
            let title = contentView.labelSubject.title else { return }
        let postLabel = Label(id: nil,
                              title: title,
                              contents: contentView.labelSubject.subtitle,
                              colorCode: hexColor)
        request(data: postLabel, method: .get)
        dismiss(animated: true)
    }
    
    @objc private func editLabelContent() {
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
