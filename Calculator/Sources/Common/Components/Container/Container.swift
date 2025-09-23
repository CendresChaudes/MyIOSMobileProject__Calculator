//
//  Container.swift
//  Calculator
//
//  Created by Роман on 23.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import UIKit

final class Container: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints(view: UIView) {
        let HORIZONTAL_PADDING: CGFloat = 16
        let VERTICAL_PADDING: CGFloat = 36

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: VERTICAL_PADDING),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -VERTICAL_PADDING),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: HORIZONTAL_PADDING),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -HORIZONTAL_PADDING),
        ])
    }
}
