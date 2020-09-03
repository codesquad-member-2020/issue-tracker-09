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

final class LabelTableViewController: UITableViewController, Categorable, Controllable {
    
    // MARK: - Properties
    lazy var viewModel: LabelViewModel = .init(tableView)
    var headerViewTitle: String = "Label"
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registerCell(LabelTableViewCell.self,
                     identifier: LabelTableViewCell.identifier)
        fetch(endpoint: Endpoint(path: .labels()))
        bindViewModelToView()
    }
    
    // MARK: - Methods
    // MARK: Delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeaderView.identifier) as? TitleHeaderView
        headerView?
            .apply(title: headerViewTitle)
        headerView?.addButton
            .addTarget(self,
                       action: #selector(presentCreateLabelViewController),
                       for: .touchUpInside)
        
        headerView?.frame = CGRect(origin: .zero,
                                   size: .init(width: view.frame.width, height: TitleHeaderView.height))
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel.itemIdentifier(for: indexPath) else { return }
        present(LabelFormViewController(.editLabel(item)),
                animated: true)
    }
    
    // MARK: Bind
    private func bindViewModelToView() {
        viewModel.$items
            .receive(on: RunLoop.main)
            .sink { [weak self] lables in
                self?.viewModel
                    .applySnapshot(self?.viewModel)
        }
        .store(in: &cancellables)
    }
    
    // MARK: Objc
    @objc private func presentCreateLabelViewController() {
        present(LabelFormViewController(.save),
                animated: true)
    }
}
