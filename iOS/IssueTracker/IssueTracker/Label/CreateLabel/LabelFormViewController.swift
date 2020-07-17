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
    private var subscriptions: Set<AnyCancellable> = .init()
    private var selectLabel: Label?
    
    // MARK: - Lifecycle
    override init(_ style: FormStyle) {
        super.init(style)
        configure(style: style)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure(style: nil)
    }
    
    // MARK: - Methods
    private func generateColor(style: FormStyle) -> UIColor? {
        switch style {
        case let .editLabel(label):
            return UIColor(hex: label.colorCode)
        default:
            return UIColor.random
        }
    }
    
    private func generatePath(method: HTTPMethod, identity: Int?) -> Endpoint.Path {
        switch method {
        case .post:
            return .labels()
        default:
            return .labels(String(identity ?? 0))
        }
    }
    
    private func request(label: Label, method: HTTPMethod) {
        UseCase.shared
            .code(label,
                  endpoint: Endpoint(path: generatePath(method: method, identity: label.id)),
                  method: method)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                let alertController = UIAlertController(message: error.message)
                self?.present(alertController,
                              animated: true)
            }) { [weak self] data, response in
                guard let statusCode = response?.statusCode else { return }
                self?.checkStatusCode(statusCode,
                                      method: method,
                                      label: label)
        }
        .store(in: &subscriptions)
    }
    
    private func checkHTTPMethod(_ viewController: LabelTableViewController, method: HTTPMethod, updateLabel: Label) {
        switch method {
        case .post:
            viewController.fetchLabels()
        default:
            for (index, label) in viewController.dataSource.labels.enumerated() {
                _ = updateLabel.id == label.id ? viewController.dataSource.labels.remove(at: index) : nil
                updateLabel.id == label.id ? viewController.dataSource.labels.insert(updateLabel, at: index) : nil
            }
        }
    }
    
    private func checkStatusCode(_ statusCode: Int, method: HTTPMethod, label: Label) {
        switch statusCode {
        case 200 ..< 300:
            guard let superViewController = self.presentingViewController as? UITabBarController,
                let labelViewController = superViewController.selectedViewController as? LabelTableViewController else { return }
            checkHTTPMethod(labelViewController,
                            method: method,
                            updateLabel: label)
        default:
            let alert = UIAlertController(message: "Network Error")
            present(alert,
                    animated: true)
        }
    }
    
    private func addTartgetButton(_ style: FormStyle?) {
        switch style {
        case let .editLabel(label):
            selectLabel = label
            contentView.saveButton
                .addTarget(self,
                           action: #selector(editLabelContent),
                           for: .touchUpInside)
        default:
            contentView.saveButton
                .addTarget(self,
                           action: #selector(saveLabelContent),
                           for: .touchUpInside)
        }
    }
    
    // MARK: Configure
    private func configure(style: FormStyle?) {
        guard let style = style else { return }
        configureColorView(style)
        addTartgetButton(style)
    }
    
    override func configureContentView(title: String?, subtitle: String?) {
        super.configureContentView(title: title,
                                   subtitle: subtitle)
        contentView.resetButton
            .addTarget(self,
                       action: #selector(resetLabelContentView),
                       for: .touchUpInside)
    }
    
    func configureColorView(_ style: FormStyle) {
        colorView = ColorView(color: generateColor(style: style))
        contentView
            .addArrangedSubview(colorView)
    }
    
    // MARK: Constraints
    override func makeConstraintsContentView() {
        super.makeConstraintsContentView()
        contentView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
        }
    }
    
    // MARK: Objc
    @objc private func saveLabelContent() {
        guard let hexColor = colorView.color?.hexString,
            let title = contentView.labelSubject.title else { return }
        let label = Label(id: nil,
                          title: title,
                          contents: contentView.labelSubject.subtitle,
                          colorCode: hexColor)
        request(label: label,
                method: .post)
        dismiss(animated: true)
    }
    
    @objc private func editLabelContent() {
        guard let hexColor = colorView.color?.hexString,
            let title = contentView.labelSubject.title else { return }
        let label = Label(id: selectLabel?.id,
                          title: title,
                          contents: contentView.labelSubject.subtitle,
                          colorCode: hexColor)
        request(label: label,
                method: .put)
        dismiss(animated: true)
    }
    
    @objc private func resetLabelContentView() {
        contentView.resetContentView()
        colorView.resetColorView()
    }
}
