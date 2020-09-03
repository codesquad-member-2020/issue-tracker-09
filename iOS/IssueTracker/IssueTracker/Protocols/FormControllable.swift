//
//  FormControllable.swift
//  IssueTracker
//
//  Created by Cloud on 2020/09/02.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

protocol FormControllable: NSObject {
    associatedtype Item: Codable, Identifierable
    var cancellables: Set<AnyCancellable> { get set }
    var selectItem: Item? { get set }
}

extension FormControllable where Self: UIViewController {
    func request<C>(controllable: C, item: Item, method: HTTPMethod) where C: Controllable, C: UIViewController, Item == C.ViewModel.Item {
        UseCase.shared
            .fetch(data: item,
                   endpoint: Endpoint(path: generatePath(method: method, identity: item.id)),
                   method: method)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] in
                guard case let .failure(error) = $0 else { return }
                let alertController = UIAlertController(message: error.message)
                self?.present(alertController,
                              animated: true)
            }) { [weak self] _, response in
                guard let statusCode = response?.statusCode else { return }
                self?.checkStatusCode(controllable: controllable,
                                      statusCode: statusCode,
                                      method: method,
                                      item: item)
        }
        .store(in: &cancellables)
    }
    
    private func generatePath(method: HTTPMethod, identity: Int?) -> Endpoint.Path {
        switch method {
        case .post:
            guard selectItem is Label else {
                return .mileStone()
            }
            
            return .labels()
        default:
            guard selectItem is Label else {
                return .mileStone(String(identity ?? 0))
            }
            
            return .labels(String(identity ?? 0))
        }
    }
    
    private func checkHTTPMethod<C>(controllable: C, method: HTTPMethod, updateItem: Item) where C: Controllable, C: UIViewController, Item == C.ViewModel.Item {
        switch method {
        case .post:
            guard selectItem is Label else {
                controllable
                    .fetch(endpoint: Endpoint(path: .mileStone()))
                
                return
            }
            
            controllable
                .fetch(endpoint: Endpoint(path: .labels()))
        default:
            for (index, item) in controllable.viewModel.items.enumerated() {
                guard updateItem.id == item.id else { return }
                controllable.viewModel.items
                    .remove(at: index)
                controllable.viewModel.items
                    .insert(updateItem, at: index)
            }
        }
    }
    
    private func checkStatusCode<C>(controllable: C, statusCode: Int, method: HTTPMethod, item: Item) where C: Controllable, C: UIViewController, Item == C.ViewModel.Item {
        switch statusCode {
        case 200 ..< 300:
            checkHTTPMethod(controllable: controllable,
                            method: method,
                            updateItem: item)
        default:
            let alert = UIAlertController(message: "Network Error")
            present(alert,
                    animated: true)
        }
    }
}
