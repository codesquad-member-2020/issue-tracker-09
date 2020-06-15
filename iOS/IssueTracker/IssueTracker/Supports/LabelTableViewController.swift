//
//  LabelTableViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

final class LabelTableViewController: CategoryTableViewController {
    
    // MARK: - Properties
    private let headerViewTitle: String = "Label"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell(anyClass: LabelTableViewCell.self,
                     identifier: LabelTableViewCell.identifier)
    }
    
    // MARK: - Methods
    // MARK: DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as? LabelTableViewCell else { return LabelTableViewCell() }
        
        guard let backgroundColor = UIColor(hex: "#e1f7d5") else { return cell }
        cell.apply(title: "feature",
                   description: "기능에 대한 레이블입니다.",
                   backgroundColor: backgroundColor)

        return cell
    }
    
    // MARK: Delegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeaderView.identifier) as? TitleHeaderView
        headerView?.apply(title: headerViewTitle)
        
        return headerView
    }
}
