//
//  LabelTableViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class LabelTableViewController: CategoryTableViewController {
    
    // MARK: - Properties
    private let headerViewTitle: String = "Label"
    private let dataSource: LabelTableViewDataSource = .init()
    private var subscriptions: Set<AnyCancellable> = .init()
    private var subscriber: AnyCancellable?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        subscriber = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.fetch(provider: IssueTrackerNetworkImpl.shared,
                           endpoint: Endpoint(path: .labels))
        }
        bindViewModelToView()
        registerCell(anyClass: LabelTableViewCell.self,
                     identifier: LabelTableViewCell.identifier)
    }
    
    // MARK: - Methods
    private func fetch(provider: IssueTrackerNetwork, endpoint: RequestPorviding) {
        var subscriber: AnyCancellable?
        subscriber = provider.requeset([Label].self,
                                       providing: endpoint)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {
                guard case .failure(let error) = $0 else { return }
                let alertViewController = UIAlertController.errorAlert(message: error.message)
                self.present(alertViewController,
                             animated: true)
                subscriber?.cancel()
            }) { self.dataSource.labels = $0 }
    }
    
    private func bindViewModelToView() {
        var subscriber: AnyCancellable?
        subscriber = dataSource.$labels
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in subscriber?.cancel() }) { _ in
                self.tableView.reloadData()
        }
    }
    
    @objc private func presentCreateLabelViewController() {
        present(CreateLabelViewController(),
                animated: true)
    }
    
    // MARK: Delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeaderView.identifier) as? TitleHeaderView
        headerView?.apply(title: headerViewTitle)
        headerView?.addButton.addTarget(self,
                                        action: #selector(presentCreateLabelViewController),
                                        for: .touchUpInside)
        
        return headerView
    }
}
