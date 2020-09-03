//
//  MileStoneTableViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/27.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class MileStoneTableViewController: UITableViewController, Categorable, Controllable {
    
    // MARK: - Properties
    lazy var viewModel: MileStoneViewModel = .init(tableView)
    var headerViewTitle: String = "MileStone"
    var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registerCell(MileStoneTableViewCell.self,
                     identifier: MileStoneTableViewCell.identifier)
        fetch(endpoint: Endpoint(path: .mileStone()))
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
                       action: #selector(presentCreateMileStoneViewController),
                       for: .touchUpInside)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel.itemIdentifier(for: indexPath) else { return }
        present(MileStoneFormViewController(.editMileStone(item)),
                animated: true)
    }
    
    // MARK: Bind
    private func bindViewModelToView() {
        viewModel.$items
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.viewModel
                    .applySnapshot(self?.viewModel)
        }
        .store(in: &cancellables)
    }
    
    // MARK: Objc
    @objc func presentCreateMileStoneViewController() {
        present(MileStoneFormViewController(.save),
                animated: true)
    }
}
