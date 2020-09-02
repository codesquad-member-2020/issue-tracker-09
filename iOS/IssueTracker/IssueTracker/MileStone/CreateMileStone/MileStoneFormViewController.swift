//
//  MileStoneFormViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/07/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class MileStoneFormViewController: CategoryFormViewController, FormControllable {
    
    // MARK: - Properties
    private var endDateView: EndDateView!
    var cancellables: Set<AnyCancellable> = .init()
    var selectItem: DeficientMileStone?
    
    // MARK: - Lifecycle
    override init(_ style: FormStyle) {
        super.init(style)
        configure(style)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure(nil)
    }
    
    // MARK: - Methods
    private func generateData(style: FormStyle) -> DeficientMileStone? {
        switch style {
        case let .editMileStone(mileStone):
            return mileStone
        default:
            return nil
        }
    }
    
    private func addTargetButton(_ style: FormStyle?) {
        switch style {
        case let .editMileStone(mileStone):
            selectItem = mileStone
            contentView.saveButton
                .addTarget(self,
                           action: #selector(editMileStoneContent),
                           for: .touchUpInside)
        default:
            contentView.saveButton
                .addTarget(self,
                           action: #selector(saveMileStoneContent),
                           for: .touchUpInside)
        }
    }
    
    // MARK: Configure
    private func configure(_ style: FormStyle?) {
        guard let style = style else { return }
        configureEndDateView(style)
        addTargetButton(style)
    }
    
    override func configureContentView(title: String?, subtitle: String?) {
        super.configureContentView(title: title,
                                   subtitle: subtitle)
        contentView.resetButton
            .addTarget(self,
                       action: #selector(resetMileStoneContentView),
                       for: .touchUpInside)
    }
    
    private func configureEndDateView(_ style: FormStyle) {
        endDateView = EndDateView(generateData(style: style),
                                  labelWidth: contentView.labelWidth)
        contentView
            .addArrangedSubview(endDateView)
    }
    
    // MARK: Constraints
    override func makeConstraintsContentView() {
        super.makeConstraintsContentView()
        contentView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
        }
    }
    
    // MARK: Objc
    @objc private func saveMileStoneContent() {
        guard let dueOn = endDateView.dueOn,
            let title = contentView.dataSubjects.title else { return }
        let mileStone = DeficientMileStone(id: nil,
                                           title: title,
                                           contents: contentView.dataSubjects.subtitle,
                                           dueOn: dueOn,
                                           numberOfOpenIssue: 0,
                                           numberOfClosedIssue: 0)
        guard let controllable = presentingViewController?.presentingViewController as? MileStoneTableViewController else { return }
        request(controllable: controllable,
                item: mileStone,
                method: .get)
        dismiss(animated: true)
    }
    
    @objc private func editMileStoneContent() {
        guard let dueOn = endDateView.dueOn,
            let title = contentView.dataSubjects.title else { return }
        
        let mileStone = DeficientMileStone(id: selectItem?.id,
                                           title: title,
                                           contents: contentView.dataSubjects.subtitle,
                                           dueOn: dueOn,
                                           numberOfOpenIssue: selectItem?.numberOfOpenIssue ?? 0,
                                           numberOfClosedIssue: selectItem?.numberOfClosedIssue ?? 0)
        guard let controllable = presentingViewController?.presentingViewController as? MileStoneTableViewController else { return }
        request(controllable: controllable,
                item: mileStone,
                method: .post)
        dismiss(animated: true)
    }
    
    @objc private func resetMileStoneContentView() {
        contentView
            .resetContentView()
        endDateView
            .resetEndDateView()
    }
}
