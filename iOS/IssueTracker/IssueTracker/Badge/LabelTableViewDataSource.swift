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
    var subscription: Set<AnyCancellable> = .init()
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UseCase.shared.encode(endpoint: Endpoint.init(path: .labels(String(labels[indexPath.row].id!))), method: .delete)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { _ in
                    
                }) { response in
                    if response.statusCode == 404 {
                        
                    } else {
                        self.labels.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
            }.store(in: &subscription)
        }
    }
}
