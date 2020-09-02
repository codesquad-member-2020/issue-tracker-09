//
//  LabelFormViewController.swift
//  IssueTracker
//
//  Created by Cloud on 2020/06/16.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit
import Combine

final class LabelFormViewController: CategoryFormViewController, FormControllable {
    
    // MARK: - Properties
    private var colorView: ColorView!
    var cancellables: Set<AnyCancellable> = .init()
    var selectItem: Label?
    
    // MARK: - Lifecycle
    override init(_ style: FormStyle) {
        super.init(style)
        configure(style: style)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure(style: nil)
    }
    
    // MARK: - Methods
    private func generateColor(style: FormStyle) -> UIColor? {
        switch style {
        case let .editLabel(label):
            guard let colorCode = label.colorCode else { return UIColor.random }
            return UIColor(hex: colorCode)
        default:
            return UIColor.random
        }
    }
    
    private func addTartgetButton(_ style: FormStyle?) {
        switch style {
        case let .editLabel(label):
            selectItem = label
            contentView.saveButton
                .addTarget(self,
                           action: #selector(editLabelContent),
                           for: .touchUpInside)
        default:
            contentView.saveButton
                .addTarget(self,
                           action: #selector(saveLabelContent),
                           for: .touchUpInside)
        }
    }
    
    // MARK: Configure
    private func configure(style: FormStyle?) {
        guard let style = style else { return }
        configureColorView(style)
        addTartgetButton(style)
    }
    
    override func configureContentView(title: String?, subtitle: String?) {
        super.configureContentView(title: title,
                                   subtitle: subtitle)
        contentView.resetButton
            .addTarget(self,
                       action: #selector(resetLabelContentView),
                       for: .touchUpInside)
    }
    
    func configureColorView(_ style: FormStyle) {
        colorView = ColorView(color: generateColor(style: style))
        contentView
            .addArrangedSubview(colorView)
    }
    
    // MARK: Constraints
    override func makeConstraintsContentView() {
        super.makeConstraintsContentView()
        contentView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
        }
    }
    
    // MARK: Objc
    @objc private func saveLabelContent() {
        guard let hexColor = colorView.color?.hexString,
            let title = contentView.dataSubjects.title else { return }
        let label = Label(id: nil,
                          title: title,
                          contents: contentView.dataSubjects.subtitle,
                          colorCode: hexColor)
        guard let controllable = presentingViewController?.presentingViewController as? LabelTableViewController else { return }
        request(controllable: controllable,
                item: label,
                method: .get)
        dismiss(animated: true)
    }
    
    @objc private func editLabelContent() {
        guard let hexColor = colorView.color?.hexString,
            let title = contentView.dataSubjects.title else { return }
        let label = Label(id: selectItem?.id,
                          title: title,
                          contents: contentView.dataSubjects.subtitle,
                          colorCode: hexColor)
        guard let viewController = presentingViewController?.presentingViewController as? LabelTableViewController else { return }
        request(controllable: viewController,
                item: label,
                method: .post)
        dismiss(animated: true)
    }
    
    @objc private func resetLabelContentView() {
        contentView.resetContentView()
        colorView.resetColorView()
    }
}
