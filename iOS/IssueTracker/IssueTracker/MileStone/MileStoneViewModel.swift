//
//  MileStoneTableViewDataSource.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/27.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

import UIKit
import Combine

final class MileStoneViewModel: UITableViewDiffableDataSource<Section, DeficientMileStone>, Modelable {
    
    // MARK: - Properties
    @Published var items:[DeficientMileStone] = .init()
    var cancellable: AnyCancellable?
    
    // MARK: - Lifecycle
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, mileStone in
            let cell = tableView
                .dequeueReusableCell(withIdentifier: MileStoneTableViewCell.identifier,
                                     for: indexPath) as? MileStoneTableViewCell
            let progressRate = ProgressRateCalculator.shared
                .apply(open: mileStone.openIssueCount,
                       closed: mileStone.closedIssueCount)
            cell?
                .apply(MileStone(milestone: mileStone,
                                 progressRate: progressRate))
            
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
            .request(endpoint: Endpoint.init(path: .mileStone(String(id))),
                     method: .delete)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.cancellable?
                    .cancel() }) { [weak self] response in
                        switch response.statusCode {
                        case 400 ..< 500:
                            break
                        default:
                            self?.items.remove(at: indexPath.row)
                        }
        }
    }
}
