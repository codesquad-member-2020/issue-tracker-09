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
    var abc: AnyCancellable?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        abc = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.fetch(provider: IssueTrackerNetworkimpl(),
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
            .sink(receiveCompletion: {
                guard case .failure(let error) = $0 else { return }
                self.errorAlert(message: error.message)
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
    
    private func errorAlert(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        let cancel = UIAlertAction(title: "close",
                                   style: .cancel)
        alert.addAction(cancel)
        present(alert, animated: true)
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
