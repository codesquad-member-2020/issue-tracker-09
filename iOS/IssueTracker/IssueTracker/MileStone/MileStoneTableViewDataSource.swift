//
//  MileStoneTableViewDataSource.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/27.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class MileStoneTableViewDataSource: NSObject {
    // MARK: - Properties
    private var subscription: AnyCancellable?
    @Published var mileStones:[DeficientMileStone] = .init()
}

// MARK: - Extension
// MARK: TableViewDataSource
extension MileStoneTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mileStones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MileStoneTableViewCell.identifier, for: indexPath) as? MileStoneTableViewCell else { return UITableViewCell() }
        let item = mileStones[indexPath.row]
        let progressRate = ProgressRateCalculator.shared
            .apply(open: item.numberOfOpenIssue,
                   closed: item.numberOfClosedIssue)
        cell.apply(MileStone(milestone: item, progressRate: progressRate))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete,
            let id = mileStones[indexPath.row].id else { return }
        subscription = NetworkPublisher.shared
            .request(endpoint: Endpoint(path: .mileStone(String(id))), method: .delete)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }) { [weak self] response in
                switch response.statusCode {
                case 400 ..< 500:
                    break
                default:
                    self?.mileStones.remove(at: indexPath.row)
                }
        }
    }
}
