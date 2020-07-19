//
//  MileStoneTableViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/27.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class MileStoneTableViewController: CategoryTableViewController {
    
    // MARK: - Properties
    private let headerViewTitle: String = "MileStone"
    private var subscriptions: Set<AnyCancellable> = .init()
    lazy var viewModel: MileStoneViewModel = .init(self.tableView)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell(MileStoneTableViewCell.self,
                     identifier: MileStoneTableViewCell.identifier)
        fetchMileStones()
        bindViewModelToView()
    }
    
    // MARK: - Methods
    private func fetchMileStones() {
        UseCase.shared
            .decode([DeficientMileStone].self,
                    endpoint: Endpoint(path: .mileStone()),
                    method: .get)
            .sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                let alertController = UIAlertController(message: error.message)
                self?.present(alertController,
                              animated: true)
            }) { [weak self] mileStones in
                self?.viewModel.mileStones = mileStones
        }
        .store(in: &subscriptions)
    }
    
    // MARK: Delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeaderView.identifier) as? TitleHeaderView
        headerView?.apply(title: headerViewTitle)
        headerView?.addButton.addTarget(self,
                                        action: #selector(presentCreateMileStoneViewController),
                                        for: .touchUpInside)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel.itemIdentifier(for: indexPath) else { return }
        present(MileStoneFormViewController(.editMileStone(item)),
    }
    
    // MARK: Bind
    private func bindViewModelToView() {
        viewModel.$mileStones
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.viewModel
                    .applySnapshot()
        }
        .store(in: &subscriptions)
    }
    
    // MARK: Objc
    @objc func presentCreateMileStoneViewController() {
        present(MileStoneFormViewController(.save),
                animated: true)
    }
}
