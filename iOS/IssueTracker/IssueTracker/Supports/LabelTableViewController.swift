//
//  LabelTableViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

enum Section {
    case main
}

final class LabelTableViewController: UITableViewController, Categorable {
    
    // MARK: - Properties
    static let identifier: String = "LabelTableViewController"
    lazy var viewModel: LabelViewModel = LabelViewModel(self.tableView)
    private let headerViewTitle: String = "Label"
    private var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registerCell(LabelTableViewCell.self,
                     identifier: LabelTableViewCell.identifier)
        fetchLabels()
        bindViewModelToView()
    }
    

    
    // MARK: - Methods
    func fetchLabels() {
        UseCase.shared
            .fetch(type: [Label].self,
                    endpoint: Endpoint(path: .labels()),
                    method: .get)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                let alertController = UIAlertController(message: error.message)
                self?.present(alertController,
                              animated: true)
            }) { [weak self] lables in
                self?.viewModel.labels = lables
        }
        .store(in: &cancellables)
    }
    
    // MARK: Delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeaderView.identifier) as? TitleHeaderView
        headerView?
            .apply(title: headerViewTitle)
        headerView?.addButton
            .addTarget(self,
                       action: #selector(presentCreateLabelViewController),
                       for: .touchUpInside)
        headerView?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: TitleHeaderView.height)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel.itemIdentifier(for: indexPath) else { return }
        present(LabelFormViewController(.editLabel(item)),
                animated: true)
    }
    
    // MARK: Bind
    private func bindViewModelToView() {
        viewModel.$labels
            .receive(on: RunLoop.main)
            .sink { [weak self] lables in
                self?.viewModel
                    .applySnapshot()
        }
        .store(in: &cancellables)
    }
    
    // MARK: Objc
    @objc private func presentCreateLabelViewController() {
        present(LabelFormViewController(.save),
                animated: true)
    }
}
