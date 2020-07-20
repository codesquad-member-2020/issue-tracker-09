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
    private var subscription: AnyCancellable?
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
        guard let colorCode = item.colorCode else { return cell }
        cell
            .apply(title: item.title,
                   description: item.contents,
                   backgroundColor: UIColor(hex: colorCode))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete,
            let id = labels[indexPath.row].id else { return }
        subscription = NetworkPublisher.shared
            .request(endpoint: Endpoint.init(path: .labels(String(id))),
                    method: .delete)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in return }) { [weak self] response in
                switch response.statusCode {
                case 400 ..< 500:
                    break
                default:
                    self?.labels.remove(at: indexPath.row)
                }
        }
        
    }
}
