//
//  Controllable.swift
//  IssueTracker
//
//  Created by Cloud on 2020/08/30.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

protocol Controllable: class {
    associatedtype ViewModel: Modelable
    var headerViewTitle: String { get }
    var viewModel: ViewModel { get set }
    var cancellables: Set<AnyCancellable> { get set }
}

extension Controllable where Self: UIViewController {
    func fetch(endpoint: RequestProviding) {
        UseCase.shared
            .fetch(type: [ViewModel.Item].self,
                    endpoint: endpoint,
                    method: .get)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                let alertController = UIAlertController(message: error.message)
                self?.present(alertController,
                              animated: true)
            }) { [weak self] items in
                self?.viewModel.items = items
        }
        .store(in: &cancellables)
    }
}
