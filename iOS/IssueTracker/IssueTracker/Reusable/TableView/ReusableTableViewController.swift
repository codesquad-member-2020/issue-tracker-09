//
//  ReusableTableViewController.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

class ReusableTableViewController: UITableViewController {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Methods
    // MARK: DataSource
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ReusableHeaderView.height
    }
    
    func registerCell(anyClass: AnyClass, identifier: String) {
        tableView.register(anyClass.self,
                           forCellReuseIdentifier: identifier)
    }
    
    // MARK: Configure
    private func configure() {
        tableView.showsVerticalScrollIndicator = false
        registerHeaderView()
    }
    
    private func registerHeaderView() {
        tableView.register(ReusableHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: ReusableHeaderView.identifier)
    }
}
