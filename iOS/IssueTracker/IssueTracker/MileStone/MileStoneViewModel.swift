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

final class MileStoneViewModel: UITableViewDiffableDataSource<Section, DeficientMileStone> {
    
    // MARK: - Properties
    private var cancellable: AnyCancellable?
    @Published var mileStones:[DeficientMileStone] = .init()
    
    // MARK: - Lifecycle
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, mileStone in
            let cell = tableView
                .dequeueReusableCell(withIdentifier: MileStoneTableViewCell.identifier,
                                     for: indexPath) as? MileStoneTableViewCell
            let progressRate = ProgressRateCalculator.shared
                .apply(open: mileStone.numberOfOpenIssue,
                       closed: mileStone.numberOfClosedIssue)
            cell?
                .apply(MileStone(milestone: mileStone,
                                 progressRate: progressRate))
            
            return cell
        }
    }
    
    // MARK: - Methods
    func applySnapshot(_ animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, DeficientMileStone>()
        snapshot
            .appendSections([.main])
        snapshot
            .appendItems(mileStones)
        apply(snapshot,
              animatingDifferences: animatingDifferences)
    }
    
    // MARK: TableView
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete,
            let id = mileStones[indexPath.row].id else { return }
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
                            self?.mileStones.remove(at: indexPath.row)
                        }
        }
    }
}
