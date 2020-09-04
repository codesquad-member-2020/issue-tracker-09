//
//  LabelTableViewDataSource.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/17.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine


final class LabelViewModel: UITableViewDiffableDataSource<Section, Label>, Modelable {
    
    // MARK: - Properties
    @Published var items: [Label] = .init()
    var cancellable: AnyCancellable?
    
    // MARK: - Lifecycle
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, label in
            let cell = tableView
                .dequeueReusableCell(withIdentifier: LabelTableViewCell.identifier,
                                     for: indexPath) as? LabelTableViewCell
            cell?
                .apply(title: label.title,
                       description: label.description,
                       backgroundColor: UIColor(hex: label.color) ?? UIColor.white)
            
            return cell
        }
    }
    
    // MARK: - Methods    
    // MARK: TableView
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete,
            let id = items[indexPath.row].id else { return }
        cancellable = UseCase.shared
            .request(endpoint: Endpoint.init(path: .labels(String(id))),
                     method: .delete)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.cancellable?
                    .cancel() }) { [weak self] response in
                        switch response.statusCode {
                        case 400 ..< 500:
                            break
                        default:
                            self?.items
                                .remove(at: indexPath.row)
                        }
        }
    }
}
