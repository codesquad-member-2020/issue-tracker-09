//
//  Categorable.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

protocol Categorable {
    var tableView: UITableView! { get set }
}

extension Categorable {
    func configure() {
        tableView.tableFooterView = .init()
        tableView.sectionHeaderHeight = TitleHeaderView.height
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = .zero
        registerHeaderView()
    }
    
    func registerCell(_ anyClass: AnyClass, identifier: String) {
        tableView
            .register(anyClass.self,
                      forCellReuseIdentifier: identifier)
    }
    
    private func registerHeaderView() {
        tableView
            .register(TitleHeaderView.self,
                      forHeaderFooterViewReuseIdentifier: TitleHeaderView.identifier)
    }
}
