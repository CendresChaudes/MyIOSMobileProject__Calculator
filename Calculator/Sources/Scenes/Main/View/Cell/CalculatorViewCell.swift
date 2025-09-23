//
//  CalculuatorCell.swift
//  Calculator
//
//  Created by Роман on 22.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import UIKit

final class CalculatorViewCell: UICollectionViewCell {

    static let REUSE_ID = "CalculatorViewCell"

    private var button: Button!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with variant: CalculatorButton.Button) {
        let title = variant.description

        switch variant {
        case .number:
            button = ButtonFactory.makeButton(title: title, variant: .primary)
        case .baseOperation:
            button = ButtonFactory.makeButton(title: title, variant: .secondary)
        case .algebraicOperation:
            button = ButtonFactory.makeButton(title: title, variant: .accent)
        }

        contentView.addSubview(button)
        setupButtonConstraints()
    }

    private func setupButtonConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            button.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
}
