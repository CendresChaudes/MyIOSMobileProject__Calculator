//
//  Switch.swift
//  Calculator
//
//  Created by Роман on 30.09.2025.
//  Copyright © 2025 Роман Пронин (Personal Team). All rights reserved.
//

import UIKit

final class Switch: UISwitch {

    convenience init(isOn: Bool) {
        self.init(frame: .zero)
        self.isOn = isOn
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
