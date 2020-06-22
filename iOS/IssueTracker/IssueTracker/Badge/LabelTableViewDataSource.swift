//
//  LabelTableViewDataSource.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class LabelTableViewDataSource: NSObject {
    
    // MARK: - Properties
    @Published var labels: [Label] = .init()
}

// MARK: - Extension
// MARK: TableViewDataSource
extension LabelTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier, for: indexPath) as? LabelTableViewCell else { return LabelTableViewCell() }
        let item = labels[indexPath.row]
        cell.apply(title: item.title,
                   description: item.contents ?? "",
                   backgroundColor: UIColor(hex: item.colorCode) ?? UIColor.white)

        return cell
    }
}
