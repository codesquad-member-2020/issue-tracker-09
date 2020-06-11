//
//  ReusableTableViewController.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/11.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

@IBDesignable
class ReusableTableViewController: UITableViewController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    // MARK: Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
