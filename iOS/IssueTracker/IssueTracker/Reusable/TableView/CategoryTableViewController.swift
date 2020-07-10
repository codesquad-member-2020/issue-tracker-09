//
//  CategoryTableViewController.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Methods
    
    func registerCell(_ anyClass: AnyClass, identifier: String) {
        tableView.register(anyClass.self,
                           forCellReuseIdentifier: identifier)
    }
    // MARK: DataSource
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TitleHeaderView.height
    }
    
    // MARK: Configure
    private func configure() {
        tableView.tableFooterView = .init()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = .zero
        registerHeaderView()
    }
    
    private func registerHeaderView() {
        tableView.register(TitleHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: TitleHeaderView.identifier)
    }
}
