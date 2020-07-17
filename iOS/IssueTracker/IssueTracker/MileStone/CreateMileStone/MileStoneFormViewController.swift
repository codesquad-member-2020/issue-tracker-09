//
//  MileStoneFormViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/07/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class MileStoneFormViewController: CategoryFormViewController {
    
    // MARK: - Properties
    private var descriptionView: DescriptionView!
    private var subscriptions: Set<AnyCancellable> = .init()
    private var selectMileStone: DeficientMileStone?
    
    // MARK: - Lifecycle
    override init(_ style: FormStyle) {
        super.init(style)
        configure(style)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure(nil)
    }
    
    // MARK: - Methods
    private func generatePath(method: HTTPMethod, identity: Int?) -> Endpoint.Path {
        switch method {
        case .post:
            return .mileStone()
        default:
            return .mileStone(String(identity ?? 0))
        }
    }
    
    private func request(_ mileStone: DeficientMileStone, method: HTTPMethod) {
        UseCase.shared
            .code(mileStone,
                  endpoint: Endpoint(path: generatePath(method: method, identity: mileStone.id)),
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
                                      mileStone: mileStone)
        }
        .store(in: &subscriptions)
    }
    
    private func checkHTTPMethod(viewController: MileStoneTableViewController, method: HTTPMethod, updateMileStone: DeficientMileStone) {
        switch method {
        case .post:
            viewController.dataSource.mileStones.append(updateMileStone)
        default:
            for (index, mileStone) in viewController.dataSource.mileStones.enumerated() {
                _ = updateMileStone.id == mileStone.id ? viewController.dataSource.mileStones.remove(at: index) : nil
                updateMileStone.id == mileStone.id ? viewController.dataSource.mileStones.insert(updateMileStone, at: index) : nil
            }
        }
    }
    
    private func checkStatusCode(_ statusCode: Int, method: HTTPMethod, mileStone: DeficientMileStone) {
        switch statusCode {
        case 200 ..< 300:
            guard let superViewController = self.presentingViewController as? UITabBarController else { return }
            guard let labelViewController = superViewController.selectedViewController as? MileStoneTableViewController else { return }
            checkHTTPMethod(viewController: labelViewController,
                            method: method,
                            updateMileStone: mileStone)
        default:
            let alert = UIAlertController(message: "Network Error")
            DispatchQueue.main.async {
                self.present(alert,
                        animated: true)
            }
        }
    }
    
    private func addTargetButton(_ style: FormStyle?) {
        switch style {
        case let .editMileStone(mileStone):
            selectMileStone = mileStone
            contentView.saveButton
                .addTarget(self,
                           action: #selector(editMileStoneContent),
                           for: .touchUpInside)
        default:
            contentView.saveButton
                .addTarget(self,
                           action: #selector(saveMileStoneContent),
                           for: .touchUpInside)
        }
    }
    
    // MARK: Configure
    private func configure(_ style: FormStyle?) {
        configureDescriptionView()
        addTargetButton(style)
    }
    
    override func configureContentView(title: String?, subtitle: String?) {
        super.configureContentView(title: title,
                                   subtitle: subtitle)
        contentView.resetButton
            .addTarget(self,
                       action: #selector(resetMileStoneContentView),
                       for: .touchUpInside)
    }
    
    private func configureDescriptionView() {
        descriptionView = DescriptionView()
        contentView
            .addArrangedSubview(descriptionView)
    }
    
    // MARK: Constraints
    override func makeConstraintsContentView() {
        super.makeConstraintsContentView()
        contentView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
        }
    }
    
    // MARK: Objc
    @objc private func saveMileStoneContent() {
        guard let title = contentView.labelSubject.title else { return }
        let mileStone = DeficientMileStone(id: nil,
                                           title: title,
                                           contents: contentView.labelSubject.subtitle,
                                           dueOn: "2020-08-06",
                                           numberOfOpenIssue: 0,
                                           numberOfClosedIssue: 0)
        request(mileStone,
                method: .post)
        dismiss(animated: true)
    }
    
    @objc private func editMileStoneContent() {
        guard let title = contentView.labelSubject.title else { return }
        let mileStone = DeficientMileStone(id: nil,
                                           title: title,
                                           contents: contentView.labelSubject.subtitle,
                                           dueOn: "2020-08-06",
                                           numberOfOpenIssue: 0,
                                           numberOfClosedIssue: 0)
        request(mileStone,
                method: .put)
        dismiss(animated: true)
    }
    
    @objc private func resetMileStoneContentView() {
        contentView
            .resetContentView()
    }
}
