//
//  Modelable.swift
//  IssueTracker
//
//  Created by Cloud on 2020/08/30.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

protocol Modelable {
    associatedtype Item: Hashable, Codable, Identifierable
    var items: [Item] { get set }
    var cancellable: AnyCancellable? { get set }
}

extension Modelable {
    func applySnapshot(_ viewModel: UITableViewDiffableDataSource<Section, Item>?) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot
            .appendSections([.main])
        snapshot
            .appendItems(items)
        viewModel?
            .apply(snapshot)
    }
}
