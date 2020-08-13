//
//  LabelTableViewDataSource.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class LabelTableViewDifferDataSource: NSObject {
    
    // MARK: - Properties
    private var subscription: Set<AnyCancellable> = .init()
    @Published var labels: [Label] = .init()
    var dataSource: UITableViewDiffableDataSource<Section, Label>
    
    // MARK: - Lifecycle
    init(_ tableView: UITableView) {
        dataSource = UITableViewDiffableDataSource<Section, Label>(tableView: tableView) { tableView, indexPath, label in
            let cell = tableView
                .dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier,
                                     for: indexPath) as? LabelTableViewCell
            cell?
                .apply(title: label.title,
                       description: label.contents,
                       backgroundColor: UIColor(hex: label.colorCode) ?? UIColor.white)
            
            return cell
        }
    }
    
    // MARK: - Methods
    func applySnapshot(_ animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Label>()
        snapshot
            .appendSections([.main])
        snapshot
            .appendItems(labels)
        dataSource
            .apply(snapshot,
                   animatingDifferences: animatingDifferences)
    }
}


// MARK: - Extension
// MARK: TableViewDataSource
//extension LabelTableViewDataSource: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard editingStyle == .delete,
//            let id = labels[indexPath.row].id else { return }
//        UseCase.shared
//            .encode(endpoint: Endpoint.init(path: .labels(String(id))),
//                    method: .delete)
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { _ in return }) { [weak self] response in
//                switch response.statusCode {
//                case 400 ..< 500:
//                    break
//                default:
//                    self?.labels.remove(at: indexPath.row)
//                }
//        }
//        .store(in: &subscription)
//    }
//}
