//
//  Button.swift
//  Calculator
//
//  Created by Роман on 15.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import UIKit

final class Button: UIButton {

    enum Variant {

        case primary
        case secondary
        case accent
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(title: String, variant: Variant) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont(font: FontFamily.Montserrat.regular, size: 28)
        setTitleColor(Asset.text.color, for: .normal)
        layer.cornerRadius = 18
        contentHorizontalAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false

        switch variant {
        case .primary:
            configurePrimaryVariant()
        case .secondary:
            configureSecondaryVariant()
        case .accent:
            configureAccentVariant()
        }
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func configureCommonParams() {
        layer.cornerRadius = 18
        contentHorizontalAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func configurePrimaryVariant() {
        backgroundColor = Asset.primary.color
    }

    private func configureSecondaryVariant() {
        backgroundColor = Asset.secondary.color
    }

    private func configureAccentVariant() {
        backgroundColor = Asset.accent.color
        self.titleLabel?.font = UIFont(font: FontFamily.Montserrat.regular, size: 36)
    }
}
